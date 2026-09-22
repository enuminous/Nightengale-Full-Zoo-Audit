from pathlib import Path
import hashlib,json,platform,struct,subprocess,sys,time
import numpy as np
import pandas as pd
from nightingale import Nightingale
P=Path(__file__).resolve().parent
exe=Path(sys.argv[1]).resolve(); protocol=json.loads((P/'protocol.json').read_text()); seed=protocol['seed']; cfg=protocol['config']
# Protocol written before any result is evaluated; output endpoints are fixed there.
rng=np.random.default_rng(seed); flat=[]; summary=[]; calls=0; evaluated=0

def predict(animal,a):
 global calls,evaluated
 a=np.asarray(a,dtype=float); calls+=1; evaluated+=len(a)
 r=subprocess.run([str(exe),animal],input=json.dumps(a.tolist(),allow_nan=False),text=True,capture_output=True,check=True,timeout=30)
 b=np.array([struct.unpack('<d',int(s).to_bytes(8,'little'))[0] for s in r.stdout.splitlines()])
 assert len(b)==len(a) and np.isfinite(b).all(),(animal,r.stdout,r.stderr)
 return b

def walk(nodes,animal,path=()):
 for node in nodes:
  route=path+(node.feature,)
  flat.append(dict(animal=animal,path=' -> '.join(route),depth=node.depth,amplitude=node.amplitude,stability=node.stability,stop_reason=node.stop_reason,min_bin_count=min(node.counts) if node.counts else 0))
  walk(node.children,animal,route)

# Adapter anchor checks against elementary cases, independent of sampled effects.
anchors=[('Tortoise',[.2,.8],.6),('Cat',[.8,.2],.6),('Crocodile',[.8,.2,.4],.7),('Falcon',[40,10,5],25),('Phoenix',[1,1,1],1),('Bonobo',[.2,.8],.6)]
for n,a,want in anchors:assert abs(predict(n,[a])[0]-want)<1e-12
start=time.perf_counter()
for spec in protocol['specifications']:
 n=spec['animal']; features=spec['features']; count=protocol['rows_per_animal']
 X=pd.DataFrame({f['name']:rng.uniform(f['lo'],f['hi'],count) for f in features})
 y=predict(n,X.to_numpy()); X.to_csv(P/(n+'-inputs.csv'),index=False)
 result=Nightingale(**cfg).fit(lambda a:predict(n,a),X)
 (P/(n+'-effects.json')).write_text(json.dumps(result.to_dict(),indent=2,allow_nan=False)+'\n')
 walk(result.effects,n)
 roots=result.effects; top=max(roots,key=lambda node:node.amplitude)
 summary.append(dict(animal=n,endpoint=spec['expression'],output_min=float(y.min()),output_max=float(y.max()),root_count=len(roots),dominant_feature=top.feature,dominant_amplitude=top.amplitude,recursive_nodes=sum(len(x.children) for x in roots)))
 print(n,top.feature,round(top.amplitude,6),flush=True)
# Diagnostic controls, not empirical models or interaction ground truth learned from this data.
c_rng=np.random.default_rng(seed+1); x=c_rng.exponential(1,1024); C=pd.DataFrame({'x':x,'y':x+c_rng.normal(0,.15,1024)})
C.to_csv(P/'control-inputs.csv',index=False)
for label,pred in [('constant_control',lambda a:np.ones(len(a))),('additive_control',lambda a:a[:,0]+a[:,1])]:
 result=Nightingale(**cfg).fit(pred,C); walk(result.effects,label)
 (P/(label+'.json')).write_text(json.dumps(result.to_dict(),indent=2,allow_nan=False))
 if label=='constant_control':assert all(n.amplitude==0 and not n.children for n in result.effects)

pd.DataFrame(flat).to_csv(P/'effects.csv',index=False); pd.DataFrame(summary).to_csv(P/'summary.csv',index=False)
checks={'animals_executed':len(summary),'all_outputs_finite':True,'anchor_checks':len(anchors),'constant_control_pass':True,'lean_process_calls':calls,'lean_rows_evaluated':evaluated,'elapsed_seconds':time.perf_counter()-start,'python':platform.python_version(),'numpy':np.__version__,'pandas':pd.__version__,'protocol_sha256':hashlib.sha256((P/'protocol.json').read_bytes()).hexdigest(),'binary_sha256':hashlib.sha256(exe.read_bytes()).hexdigest()}
(P/'checks.json').write_text(json.dumps(checks,indent=2)+'\n'); print(json.dumps(checks,indent=2))

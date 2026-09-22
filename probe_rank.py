from pathlib import Path
import json,struct,subprocess,sys
P=Path(__file__).resolve().parent; protocol=json.loads((P/'protocol.json').read_text()); exe=str(Path(sys.argv[1]).resolve()); out=[]
for s in protocol['specifications']:
 if s['features'][0]['name']!='focal_even':continue
 cases=[[.5,.5,-.2],[.5,.5,.2]]
 r=subprocess.run([exe,s['animal']],input=json.dumps(cases),text=True,capture_output=True,check=True)
 vals=[struct.unpack('<d',int(v).to_bytes(8,'little'))[0] for v in r.stdout.splitlines()]
 out.append({'animal':s['animal'],'focal_value_fixed':.5,'reference_shifts':[-.2,.2],'outputs':vals,'change':vals[1]-vals[0]})
assert len(out)==17 and all(r['change']<0 for r in out)
(P/'reference-context-probe.json').write_text(json.dumps(out,indent=2)+'\n');print('17/17 focal scores changed when only the reference rows changed; first:',out[0])

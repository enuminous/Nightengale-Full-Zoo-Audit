import Lean
import Zoo
open Zoo Lean

def bit (b : Bool) : Float := if b then 1.0 else 0.0
def status (x : Float) : Elephant.Status := if x > 0.5 then .active else .superseded
def asInt (x : Float) : Int := Int.ofNat x.toUInt64.toNat
def intFloat : Int → Float
  | .ofNat n => natFloat n
  | .negSucc n => -(natFloat (n+1))
def cols (k : Nat) (x y z : Float) : List (List Float) :=
  (List.range k).map (fun j => (if j % 2 == 0 then x else y) ::
    (List.range 9).map (fun i => natFloat i / 8.0 + z))
def beaver (x y z : Float) : Float :=
  bit (@decide (Beaver.Accepted ⟨x,y,z,true,true,0.05,0.2,1.0⟩)
    (by unfold Beaver.Accepted; infer_instance))
def evaluate (name : String) (x y z : Float) : Float :=
  match name with
  | "Tortoise" => Tortoise.gain ⟨x,y⟩
  | "Owl" => (Owl.run ⟨⟨cols (Owl.expectedColumns 1) x y z,10⟩,1⟩).getD 0 0.0
  | "Octopus" => (Octopus.run ⟨⟨cols (Octopus.expectedColumns 1) x y z,10⟩,1⟩).getD 0 0.0
  | "Gecko" => (Gecko.run ⟨⟨cols (Gecko.expectedColumns 1) x y z,10⟩,1⟩).getD 0 0.0
  | "Hive" => (Hive.run ⟨⟨cols (Hive.expectedColumns 1) x y z,10⟩,1⟩).getD 0 0.0
  | "Eagle" => (Eagle.run ⟨⟨cols (Eagle.expectedColumns 1) x y z,10⟩,1⟩).getD 0 0.0
  | "Crab" => (Crab.run ⟨⟨cols (Crab.expectedColumns 1) x y z,10⟩,1⟩).getD 0 0.0
  | "Shepherd" => (Shepherd.run ⟨⟨cols (Shepherd.expectedColumns 1) x y z,10⟩,1⟩).getD 0 0.0
  | "Pulse" => (Pulse.run ⟨⟨cols (Pulse.expectedColumns 1) x y z,10⟩,1⟩).getD 0 0.0
  | "Cat" => Cat.penalty x y
  | "Fox" => (Fox.run ⟨⟨cols (Fox.expectedColumns 1) x y z,10⟩,1⟩).getD 0 0.0
  | "Spider" => (Spider.run ⟨⟨cols (Spider.expectedColumns 1) x y z,10⟩,1⟩).getD 0 0.0
  | "Raven" => (Raven.run ⟨⟨cols (Raven.expectedColumns 1) x y z,10⟩,1⟩).getD 0 0.0
  | "Dolphin" => (Dolphin.run ⟨⟨cols (Dolphin.expectedColumns 1) x y z,10⟩,1⟩).getD 0 0.0
  | "Ant" => (Ant.run ⟨⟨cols (Ant.expectedColumns 1) x y z,10⟩,1⟩).getD 0 0.0
  | "Moth" => (Moth.run ⟨⟨cols (Moth.expectedColumns 1) x y z,10⟩,1⟩).getD 0 0.0
  | "Shark" => (Shark.run ⟨⟨cols (Shark.expectedColumns 1) x y z,10⟩,1⟩).getD 0 0.0
  | "Penguin" => (Penguin.run ⟨⟨cols (Penguin.expectedColumns 1) x y z,10⟩,1⟩).getD 0 0.0
  | "Bat" => bit (Bat.run ⟨x,y,z,0.5,0.002⟩ == .survives)
  | "Hedgehog" => bit (Hedgehog.run ⟨x,y,0.002,true⟩ == .generalizes)
  | "Crocodile" => Crocodile.did x y z 0.5
  | "Dragon" => (Dragon.run ⟨⟨cols (Dragon.expectedColumns 1) x y z,10⟩,1⟩).getD 0 0.0
  | "Turtle" => bit (Turtle.run ⟨true,decide (y > 0.5),3,3,0,x,3,0.18,0.05⟩ == .supported)
  | "Magpie" => Magpie.groundedness ⟨0.5,x,y,0.5,0.2,0.1,z,none,0.25⟩
  | "Wolf" => Wolf.update x y z
  | "Elephant" => natFloat (Elephant.current [⟨0,0,status x,none,"synthetic"⟩,⟨1,1,status y,none,"synthetic"⟩,⟨2,2,status z,none,"synthetic"⟩]).length
  | "Chameleon" => Chameleon.unexplained x y
  | "Jellyfish" => Jellyfish.nextHealth x y z
  | "Beaver" => beaver x y z
  | "Mantis" => bit (Mantis.run ⟨true,x,y,z,2.0,0.5⟩ == .intervene)
  | "Bison" => (Bison.step ⟨x,y,z,5.0⟩).dropped
  | "Weasel" => bit (Weasel.admissible 1 ⟨(if x > 0.5 then 2 else 1),y,0.5,1.0⟩)
  | "Salmon" => Salmon.unresolvedMass x [⟨0,2,y⟩,⟨1,2,z⟩]
  | "Orca" => Orca.coordination x y z 0.2 1.0
  | "Mole" => bit (Mole.hiddenFailure ⟨true,x,y,z,0.25,0.5⟩)
  | "Lynx" => Lynx.latentYield ⟨x,y,0.2,z,0.8,0.5,0.5,0.5,0.4,0.6⟩
  | "Horse" => Horse.workloadPenalty x y z
  | "Termite" => Termite.stepAgent ⟨x,y,0.0⟩ z 1.0
  | "Phoenix" => Phoenix.completeness x y z
  | "Cobra" => Cobra.risk ⟨x,y,0.2,0.0,0.0,0.2,z,0.8⟩
  | "Whale" => Whale.cumulativeDeviation [x,y,z] 0.5
  | "Falcon" => intFloat (Falcon.reactionMargin (asInt x) (asInt y) (asInt z))
  | "Rhino" => Rhino.retention x y
  | "Bonobo" => Bonobo.gain x y
  | "Axolotl" => Axolotl.resilience ⟨1.0,x,y,z,0.3,1.0⟩
  | "Butterfly" => Butterfly.stepLayer ⟨x,0.1,y,1.0⟩ z
  | _ => 0.0

def main (args : List String) : IO Unit := do
  let input ← (← IO.getStdin).getLine
  let json ← IO.ofExcept (Json.parse input)
  let rows ← IO.ofExcept json.getArr?
  let stdout ← IO.getStdout
  for row in rows do
    let vals ← IO.ofExcept row.getArr?
    let floats ← vals.toList.mapM (fun v => do
      let n ← IO.ofExcept v.getNum?
      pure n.toFloat)
    let value := evaluate (args.getD 0 "") (floats.getD 0 0.0) (floats.getD 1 0.0) (floats.getD 2 0.0)
    stdout.putStrLn (toString value.toBits)

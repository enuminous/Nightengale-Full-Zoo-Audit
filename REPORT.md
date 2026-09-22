# NIGHTENGALE on the full 46-animal Lean Zoo

## Result and scope

**Demonstrated:** NIGHTENGALE executed against one explicitly selected compiled Lean output for each of all 46 animals. Every selected output was finite in the sampled domain. This is a complete roster audit of selected endpoints, not an exhaustive audit of every function, branch, theorem, upstream pipeline or scientific claim.

The primary run evaluated 78,342 Lean input rows across 1,092 process calls. There were 256 synthetic base rows per animal (11,776 total); the remainder are ALE perturbation evaluations plus six anchor cases. Primary run elapsed time was 51.72 seconds, including process startup and Python analysis. A separate 34-row rank-context probe covered all 17 rank modules.

Zoo source: https://github.com/enuminous/Monolithic-Zoo-Lean4 at `94e0a9e2550a8fe62b03dc8213e3e3942c30899b`.
NIGHTENGALE source: https://github.com/enuminous/Nightengale at `849c39363beafc3dac70430bf1f032e7f7ce1623`; original `nightingale.py` Git blob `efd4087e5bf0191b855a5c0a2c5f7a76b2df6a98` verified byte-for-byte.

The published Zoo still has the two issues recorded in the preceding benchmark. This run uses the local FALCON decidability correction and restored `.gitignore`, with no GitHub changes. The audit adapter was compiled with Lean 4.19.0. It calls actual Zoo definitions; no Python reimplementation is substituted for those outputs. Floating output bits are transferred exactly to Python. JSON input numbers pass through Lean's JsonNumber-to-Float conversion.

## Frozen operation

NIGHTENGALE estimates first-order accumulated local effects by perturbing each feature between empirical quantile-bin edges, centering the accumulated effects, then recursively examining conditional changes in the resulting local-effect values. Its recursive operator is explicitly empirical, not a causal derivative.

Protocol: seed 92246, four quantile bins, depth two, minimum 16 observations per occupied bin, 10 bootstrap resamples, stability threshold 0.5, effect tolerance 1e-8. Numeric inputs were sampled independently and uniformly within the per-endpoint ranges in protocol.json. Binary conditions are threshold encodings, not interpolated physical measurements. Selected categorical outcomes are 0/1 indicators rather than invented ordinal scores.

The first attempted adapter failed to compile because Lean Int lacked the selected float conversion method and the stream lacked `readToEnd`; these harness API errors were corrected before the frozen protocol was executed. This did not change any Zoo function. The source snapshot and final adapter are included.

| Operation | Input | Criterion | Result |
|---|---|---|---|
| Compiled adapter | All 46 named Lean endpoints | Build and finite output for every evaluated row | PASS |
| Anchor checks | Six elementary cases, including integer timing | Absolute error below 1e-12 | 6/6 PASS |
| First-order ALE | 256 rows per endpoint, four bins | Finite serializable effect curves with sufficient sampled support | 130 root curves |
| Recursive operator | First-order local changes | Record support, bootstrap stability and stop reasons | 244 Zoo child nodes; 22 stopped for bootstrap instability, 222 at depth limit |
| Constant-output control | Same recursive settings | Zero root amplitudes, no children | PASS |
| Additive diagnostic control | f(x,y)=x+y, correlated nonuniform inputs | Check whether recursion alone establishes interaction | It does not: stable children exist despite exact zero mixed derivative |
| Reference-context probe | Fixed focal value 0.5, shifted other rows | Measure dependence on supplied reference data | 17/17 scores changed |

## Main findings

### 1. The rank family depends on its reference population

For each of the 17 rank-aggregation animals, fixing both focal inputs at 0.5 and shifting only the nine reference rows from -0.2 to +0.2 changed the focal score from approximately **0.70 to 0.40**. This is expected for percentile ranking, not a floating-point bug. However, if those reference rows are future observations, it demonstrates how future data can affect an earlier score. The current modules do not enforce an online, past-only reference population.

These 17 modules share the same ranking kernel. Their differing upstream feature descriptions do not turn identical final aggregation operations into independent corroboration. Small differences between this run's ALE profiles also reflect separate random samples and different counts of alternating component columns; they should not be interpreted as evidence that one animal is better.

### 2. Stable recursive branches do not establish interaction

The additive control is f(x,y)=x+y. Its mixed derivative is exactly zero. Inputs were x~Exponential(1) and y=x+Gaussian(0,0.15), with 1,024 rows and a fixed seed. NIGHTENGALE nevertheless returned:

| Recursive path | Amplitude | Bootstrap stability |
|---|---:|---:|
| x → y | 5.667974 | 0.999893 |
| y → x | 5.621499 | 0.999946 |

This is consistent with the implementation: it recursively studies **raw bin-endpoint differences**, whose size varies with quantile-bin width; correlated features can predict those differences even when the model is additive. Bootstrap correlation assesses reproducibility of that pattern. It does not distinguish an interaction from bin-width effects or dependence in the inputs. The implementation itself labels the recursive operator empirical; the invalid step would be interpreting its branches as causal interactions, emergence or new physics.

The constant-output control yielded exactly zero effects and no children. This confirms basic null behavior but does not resolve the additive-control interpretation issue.

### 3. The selected outputs respond to their specified inputs

Examples, conditional on these synthetic ranges and fixed settings:

- FALCON reaction margin was most sensitive by ALE amplitude to alarm time (74 integer ticks), consistent with hazard minus alarm minus delay.
- BISON dropped demand was most sensitive to demand (amplitude 4.534522).
- AXOLOTL resilience was most sensitive to adapted function (0.502045).
- MAGPIE groundedness was most sensitive to contradiction (0.197417).
- COBRA risk was most sensitive to confidence (0.195620).

Amplitudes are in different output units, with deliberately different input ranges. They are not comparable quality scores. These are sensitivity descriptions of specified software, not measured real-world predictive performance.

## All 46 selected endpoints

The dominant feature is the largest first-order ALE range within that endpoint. It is not necessarily unique or statistically distinguishable from another feature. Full curves, counts and bootstrap results are included in the CSV and JSON files.

| Animal | Dominant feature in this sample | ALE amplitude | Selected scope |
|---|---|---:|---|
| Tortoise | candidate_brier | 0.761586 | Brier gain only; prospective split obligations excluded. |
| Owl | focal_odd | 0.291406 | Focal row percentile score; one horizon; alternating focal values across all required columns, nine shifted reference rows. Feature extraction excluded. |
| Octopus | focal_odd | 0.284375 | Focal row percentile score; one horizon; alternating focal values across all required columns, nine shifted reference rows. Feature extraction excluded. |
| Gecko | focal_odd | 0.314844 | Focal row percentile score; one horizon; alternating focal values across all required columns, nine shifted reference rows. Feature extraction excluded. |
| Hive | focal_even | 0.296875 | Focal row percentile score; one horizon; alternating focal values across all required columns, nine shifted reference rows. Feature extraction excluded. |
| Eagle | focal_odd | 0.303906 | Focal row percentile score; one horizon; alternating focal values across all required columns, nine shifted reference rows. Feature extraction excluded. |
| Crab | focal_odd | 0.284375 | Focal row percentile score; one horizon; alternating focal values across all required columns, nine shifted reference rows. Feature extraction excluded. |
| Shepherd | focal_odd | 0.286719 | Focal row percentile score; one horizon; alternating focal values across all required columns, nine shifted reference rows. Feature extraction excluded. |
| Pulse | focal_even | 0.278125 | Focal row percentile score; one horizon; alternating focal values across all required columns, nine shifted reference rows. Feature extraction excluded. |
| Cat | full_brier | 0.768163 | Ablation penalty. |
| Fox | focal_even | 0.292187 | Focal row percentile score; one horizon; alternating focal values across all required columns, nine shifted reference rows. Feature extraction excluded. |
| Spider | focal_odd | 0.299219 | Focal row percentile score; one horizon; alternating focal values across all required columns, nine shifted reference rows. Feature extraction excluded. |
| Raven | focal_even | 0.333036 | Focal row percentile score; one horizon; alternating focal values across all required columns, nine shifted reference rows. Feature extraction excluded. |
| Dolphin | focal_even | 0.301705 | Focal row percentile score; one horizon; alternating focal values across all required columns, nine shifted reference rows. Feature extraction excluded. |
| Ant | focal_even | 0.310227 | Focal row percentile score; one horizon; alternating focal values across all required columns, nine shifted reference rows. Feature extraction excluded. |
| Moth | focal_even | 0.341071 | Focal row percentile score; one horizon; alternating focal values across all required columns, nine shifted reference rows. Feature extraction excluded. |
| Shark | focal_even | 0.294471 | Focal row percentile score; one horizon; alternating focal values across all required columns, nine shifted reference rows. Feature extraction excluded. |
| Penguin | focal_odd | 0.282031 | Focal row percentile score; one horizon; alternating focal values across all required columns, nine shifted reference rows. Feature extraction excluded. |
| Bat | gain | 0.593750 | Survives indicator; placebo Brier 0.5, material gain 0.002. |
| Hedgehog | win_rate | 0.578125 | Generalizes indicator; habitat support true. |
| Crocodile | treated_pre | 0.759802 | Difference in differences; control pre 0.5; identification assumptions not tested. |
| Dragon | focal_even | 0.308523 | Focal row percentile score; one horizon; alternating focal values across all required columns, nine shifted reference rows. Feature extraction excluded. |
| Turtle | score | 0.562500 | Supported indicator; three positive groups, no negative groups; veto Boolean encoded at >0.5. |
| Magpie | contradiction | 0.197417 | Groundedness; corroboration 0.5, unsupported inference 0.2, unresolved provenance 0.1; no alarm audit. |
| Wolf | instantaneous | 0.376417 | EMA update; distributed alarm gates excluded. |
| Elephant | active_gate_1 | 1.000000 | Count of active events; statuses active iff gate >0.5; lineage excluded. |
| Chameleon | observed_distance | 0.437778 | Nonnegative unexplained distance. |
| Jellyfish | health | 0.702126 | One-step health update. |
| Beaver | effectiveness | 0.281250 | Acceptance indicator; bounded and rollbackVerified true. Flags not evidence of real rollback. |
| Mantis | z_variance | 0.671875 | Intervene indicator, ready true; threshold 2, coherence minimum 0.5. |
| Bison | demand | 4.534522 | Dropped demand; queue limit 5. |
| Weasel | changed_keys_gate | 0.484375 | Admissibility with budget 1; changed keys 1 or 2, fixed cost/reproducibility. |
| Salmon | parent_weight_1 | 0.156363 | Unresolved mass for two parents; traversal excluded. |
| Orca | integrity | 0.224278 | Coordination; ambiguity 0.2, lag 1. |
| Mole | surface_health | 0.390625 | Hidden-failure indicator; indicators present true. |
| Lynx | replication | 0.215444 | Latent yield; rediscovery 0.2, yield score 0.8; default weights. |
| Horse | attention | 0.371407 | Workload penalty; handoff and joint effectiveness excluded. |
| Termite | incoming_target | 0.411628 | Single-agent update; bias 0, total weight 1. |
| Phoenix | fidelity | 0.301191 | Completeness; hold-window behavior excluded. |
| Cobra | confidence | 0.195620 | Risk; violation/context gap 0.2, proxy/goal deltas 0, persistence 0.8. |
| Whale | history_3 | 0.158359 | Cumulative deviation; baseline 0.5. |
| Falcon | alarm_time | 74.000000 | Reaction margin in integer ticks; nonnegative floats truncated to integers. |
| Rhino | after | 0.507408 | Retention away from zero baseline; singular branch excluded. |
| Bonobo | baseline_utility | 0.764062 | Utility gain; multi-participant mutual-gain contract excluded. |
| Axolotl | adapted | 0.502045 | Resilience; reference 1, transformation 0.3, invariant retention 1. |
| Butterfly | incoming | 0.714069 | Single-layer output; base 0.1, threshold 1; trajectory excluded. |

## Anti-circularity and obligations

- Input ranges, scalar endpoints, thresholds and execution checks were frozen in protocol.json before the primary run. They were chosen by the analyst for this exploratory audit, not independently validated as a real-world distribution.
- Sensitivity findings are consequences of the selected definitions. They do not supply evidence for their own scientific premises or for EFMW's physical claims.
- Borrowed status from the prior benchmark is explicitly separate: the minimally repaired build previously compiled all 46 modules, checked 98 theorem dependency reports, and passed 90 fixtures. This run adds different synthetic probes; it does not retroactively expand the original fixture coverage.
- Boolean gates and fixed assumptions are visible in the protocol. BEAVER's rollback and bounds flags were fixed true; this audit does not test actual rollback. CROCODILE's identification assumptions remain external. RHINO's zero-baseline branch, AXOLOTL's zero-cost branch, NaN/Inf behavior, invalid shapes and long temporal trajectories are outside this run.
- No cross-animal global scalar score was invented. There is no shared natural outcome or calibrated common scale across all 46 modules.
- The additive diagnostic is an analytic negative control. No external novelty claim is made: linear contrasts, weighted sums and percentile ranks remain standard operations. A new application or formalization does not establish a new physical law.

## Evidence statuses

**Demonstrated:** roster-wide selected-endpoint execution; constant-control null; reference-population dependence in all 17 rank modules; stable recursive branches on an additive function.

**Supported but incomplete:** NIGHTENGALE is useful for inspecting input sensitivity of these compiled kernels within the tested domains.

**Rejected as an inference:** a stable recursive branch by itself proves interaction, emergence, causality, or novelty. The additive control provides a direct counterexample to that inference.

**Unresolved:** full pipeline equivalence, boundary-domain reliability, temporal leakage prevention, predictive advantage over controls, and empirical validation of EFMW.

## Minimal next tests

1. **Interaction interpretation:** pre-register an independent mixed-difference check on f(x,y)=x+y and f(x,y)=xy. Require |f(x+h,y+h)-f(x+h,y)-f(x,y+h)+f(x,y)| ≤ 1e-10 for the additive control and agreement with h² within 1e-10 for the product, over a frozen grid with h=0.01. Recursive branches alone must not be labeled interactions. These tests are proposed, not reported as run here.
2. **Online ranking:** in a separate past-only ranking implementation, freeze a focal row and its preceding history, then mutate every later row. Require the focal output to remain bit-identical. Any change fails that online-isolation claim. Current batch-ranking behavior is expected to fail this criterion and should be described as retrospective.

## Reproduce

Install the toolchain specified by lean-source/lean-toolchain and the NumPy/Pandas versions in requirements.txt. From the extracted audit directory:

```sh
cd lean-source
lake build nightaudit
cd ..
python3 run.py lean-source/.lake/build/bin/nightaudit
python3 probe_rank.py lean-source/.lake/build/bin/nightaudit
```

Rerunning overwrites the included result files. Work in a copy to preserve this evidence packet. Source files are included, but the native compiler and generated binaries are not. Results are deterministic up to toolchain/library numeric behavior; elapsed time is environment-dependent. Synthetic sensitivity results do not require or imply that the prior experimental claims are true.

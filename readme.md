# NIGHTINGALE

<!-- ENUMINOUS-LIFECYCLE:START -->
**Lifecycle review — 2026-10-16: historical audit snapshot; copied Lean sources.**

This bundle records selected endpoints from the Zoo at `94e0a9e2550a8fe62b03dc8213e3e3942c30899b` and NIGHTENGALE at `849c39363beafc3dac70430bf1f032e7f7ce1623`. Its 53 source blobs shared with [Monolithic-Zoo-Lean4](https://github.com/enuminous/Monolithic-Zoo-Lean4) are a frozen audit copy. The diagnostic data and audit are distinct work. Use the upstream Zoo and [Nightengale](https://github.com/enuminous/Nightengale) for current implementations. Present-tense publication/build statements in the original report describe its frozen snapshot; current Zoo verification is recorded in [BUILD_STATUS.md](https://github.com/enuminous/Monolithic-Zoo-Lean4/blob/main/BUILD_STATUS.md) and [the successful structured-report run](https://github.com/enuminous/Monolithic-Zoo-Lean4/actions/runs/38831479150). The old diagnostic results have not been rerun here against the newer implementations. Selected-endpoint coverage is not end-to-end Zoo equivalence.

[Portfolio review and evidence](https://github.com/enuminous/EFMW_Post156_Zoo_Audit/blob/main/portfolio/REPOSITORY_LIFECYCLE_2026-10-16.md).
<!-- ENUMINOUS-LIFECYCLE:END -->

<!-- ENUMINOUS-NETWORK:START -->
**eNuminous network:** [All repositories](https://enuminous.github.io/EFMW/repositories.html) · [EFMW](https://enuminous.github.io/EFMW/) · [102 equations](https://github.com/enuminous/Monolithic_102_EFMW) · [165 triplets](https://enuminous.github.io/FieldSpace/) · [Zoo](https://enuminous.github.io/Tortoise/) · [Lean](https://enuminous.github.io/Aristotle-102-Monolithic-Lean/) · [Engine](https://enuminous.github.io/Archimedes-Engine/) · [Papers](https://enuminous.github.io/medium/papers-essays-index.html) · [Audit](https://github.com/enuminous/EFMW_Post156_Zoo_Audit/blob/main/portfolio/INTERLOCK_AUDIT.md)

[Repository](https://github.com/enuminous/Nightengale-Full-Zoo-Audit) · This repository is linked through its source; GitHub Pages is not enabled.

<details>
<summary>Recent repositories (9)</summary>

- [Oroboros](https://github.com/enuminous/Oroboros) · [README](https://github.com/enuminous/Oroboros/blob/main/README.md) · [Page](https://enuminous.github.io/Oroboros/)
- [P-NP](https://github.com/enuminous/P-NP) · [README](https://github.com/enuminous/P-NP/blob/main/README.md) · [Page](https://enuminous.github.io/P-NP/)
- [Research-Program](https://github.com/enuminous/Research-Program) · [README](https://github.com/enuminous/Research-Program/blob/main/README.md) · [Page](https://enuminous.github.io/Research-Program/)
- [I-Have-Guts](https://github.com/enuminous/I-Have-Guts) · [README](https://github.com/enuminous/I-Have-Guts/blob/main/README.md) · [Page](https://enuminous.github.io/I-Have-Guts/)
- [Wrights-Law](https://github.com/enuminous/Wrights-Law) · [README](https://github.com/enuminous/Wrights-Law/blob/main/README.md) · [Page](https://enuminous.github.io/Wrights-Law/)
- [Aristotle-eNuminous](https://github.com/enuminous/Aristotle-eNuminous) · [README](https://github.com/enuminous/Aristotle-eNuminous/blob/main/README.md) · [Page](https://enuminous.github.io/Aristotle-eNuminous/)
- [Multiverse-Simulator](https://github.com/enuminous/Multiverse-Simulator) · [README](https://github.com/enuminous/Multiverse-Simulator/blob/main/README.md) · [Page](https://enuminous.github.io/Multiverse-Simulator/)
- [accelerando-8192](https://github.com/enuminous/accelerando-8192) · [README](https://github.com/enuminous/accelerando-8192/blob/main/README.md) · [Page source](https://github.com/enuminous/accelerando-8192/blob/main/docs/index.html)
- [Codex-888](https://github.com/enuminous/Codex-888) · [README](https://github.com/enuminous/Codex-888/blob/main/README.md) · [Page](https://enuminous.github.io/Codex-888/)

</details>
<!-- ENUMINOUS-NETWORK:END -->

**Recursive Accumulated Local Effects (ALE)** for examining how feature effects change when their effect landscapes are analyzed recursively.

The GitHub repository is spelled [`enuminous/nightengale`](https://github.com/enuminous/nightengale). The project name and Python files use **Nightingale**; the repository spelling **nightengale** is intentional.

## What it does

NIGHTINGALE is a research prototype for recursively diagnosing model sensitivity. It starts with first-order feature effects, then examines how those effect landscapes vary across supported regions of the data. At each level it asks:

- What does the feature effect look like in this region?
- Which other features or conditions change that effect?
- Does the next layer reveal a stable modulation, or mostly noise and sparse support?
- Should the analysis continue, or stop?

The aim is to make feature-effect diagnostics more informative while preserving the distinction between an observed model response and a causal claim about the world.

## Conceptual workflow

1. Compute first-order ALE effects for the selected model and dataset.
2. Treat an effect landscape as the object for the next diagnostic pass.
3. Examine how that landscape varies over other features or supported regions.
4. Repeat recursively, recording each branch’s inputs, support, effect size, and stability.
5. Stop a branch when support, amplitude, stability, or the preselected depth limit no longer justifies further analysis.

Recursive depth is a diagnostic choice. A deeper branch is not automatically a stronger finding.

## Why ALE

Accumulated Local Effects estimates changes in model predictions within intervals of the observed data, then accumulates those local changes. This helps avoid some of the unrealistic combinations that can occur when a feature is varied independently of correlated features. ALE still describes a fitted model’s behavior; it does not, by itself, establish causal effects.

## Research status and evidence limits

A reported synthetic audit covered **3,600 snapshots from 36 synthetic trajectories**. In that audit, a one-step adapter exactly matched the published monitor. Recursive branches were stable for an exactly linear signed update. That stability is a useful control result, but it is **not evidence for an additional physical term**.

The reduced audit representation reported memory’s first-order ALE amplitude at approximately **15×** that of current residual. This is a result for that representation and audit only. It is not a universal feature-importance ratio, a causal result, or an energy measurement.

NIGHTINGALE should therefore be treated as an exploratory sensitivity-analysis method. Any scientific claim based on its output needs independently specified endpoints, suitable controls, support checks, and validation on data not used to develop the analysis.

## Interpretation rules

- ALE values describe the model’s predictions over the analyzed data distribution.
- Recursive branches describe changes in those model effects; they do not prove that features interact in the underlying system.
- Correlated features and limited support can make effect decompositions unstable or ambiguous.
- Stable results should be checked against controls, alternative specifications, and held-out data.
- Do not interpret a high-amplitude effect as causal importance without a separate causal design.
- Do not infer new physics from recursive stability alone.

## Repository

Source and updates: <https://github.com/enuminous/nightengale>

The exact installation command, supported Python version, dependency list, and command-line interface should be taken from the repository’s current source and packaging files; this README does not assume an API that has not been documented here.

## Name

**NIGHTINGALE** is the animal/project name. The repository’s lowercase spelling, `nightengale`, is retained in its URL for compatibility.

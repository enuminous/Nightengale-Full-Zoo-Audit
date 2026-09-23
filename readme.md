# NIGHTINGALE

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

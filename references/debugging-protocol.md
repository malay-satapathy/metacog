# Scientific Debugging & Fault Isolation Protocol

Use this playbook when diagnosing non-trivial bugs, flaky tests, race conditions, or regressions.

## 1. Reproduce Deterministically Before Touching Code
- Capture the exact failure signature (stack trace, exit code, failing input payload, or visual artifact).
- If the bug is intermittent, identify the non-deterministic source (clock time, async ordering, shared mutable state, network timing, unseeded randomness) and construct a minimal reproduction harness.

## 2. Binary-Search the Fault Boundary
Instead of reading hundreds of lines linearly, bisect the data/control flow:
1. Identify the **Entry Point** $A$ (where state is known-good) and the **Failure Point** $B$ (where state is corrupted or throws).
2. Inspect the midpoint $M$ (via test assertion, log trace, or debugger/print probe).
3. Halve the search space iteratively until you isolate the exact state transition that violates the invariant.

## 3. Falsification Table
Before editing code, construct a quick mental or scratchpad falsification matrix:

| Hypothesis | Predicted Observation if True | Fast Probe / Check | Status |
| :--- | :--- | :--- | :--- |
| $H_1$: Stale cache entry | Second request fails while cold start succeeds | Bypass cache in test | `FALSIFIED` / `CONFIRMED` |
| $H_2$: Async race on shared state | Concurrent calls interleave mutations | Run `Promise.all` stress test | `FALSIFIED` / `CONFIRMED` |

## 4. Cure the Root Cause, Not the Symptom
- Never slap a superficial `null` check or `try/catch` over a corrupted state without tracing *why* that state became invalid upstream.
- Check if the same anti-pattern exists in sibling modules across the codebase.

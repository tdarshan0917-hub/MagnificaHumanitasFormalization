# Build verification — prototype 0.4

Date: 2026-11-01.

Official binary distribution: [Lean 4.35.0](https://github.com/leanprover/lean4/releases/tag/v4.35.0), compiler commit `eb6cafb7290e8bd5f2937522d8d804f58f02bafc`. This exact toolchain is pinned; no Mathlib dependency is used. It was selected from the official releases and Reservoir listings, not guessed.

## Checks performed

Source was copied to a clean directory without build artifacts. `lake build` succeeded (10 jobs), `lake env lean Audit.lean` succeeded, and `python3 scripts/audit_sources.py` succeeded (40 source candidates, 9 Lean files). Full outputs are under verification/.

Audit.lean prints selected theorem statements and axiom dependencies of twenty principal declarations. Fifteen report no logical axioms; five high-stakes declarations use only Lean's standard `propext`, introduced by simplifier proofs. No custom axioms, proof placeholders, or native_decide-based certificate bypasses are used. This is not a claim that policy interpretations or case assumptions are assumption-free. Their substantive choices are visible in the model and theory definitions. The exact counts are recorded in verification/summary.json.

## Container compatibility

This execution container exposes the current executable through `/proc/self/exe` but the runtime's `/proc/<own-pid>/exe` lookup failed. An optional C shim in scripts/proc_self_compat.c redirects only that same-process link lookup to the equivalent self path. It does not modify Lean's kernel, proof objects, or any logical operation. Lean's original binary and libraries performed the checks.

The logs were produced with the compatibility shim loaded and explicit LEAN_SYSROOT/LAKE_HOME paths to the extracted distribution. On a normal Linux or macOS installation, follow the ordinary README commands; the compatibility shim should not be necessary.

To reproduce this container-specific workaround when needed:

```bash
gcc -shared -fPIC -O2 scripts/proc_self_compat.c -ldl -o /tmp/mh-proc-compat.so
LD_PRELOAD=/tmp/mh-proc-compat.so lake build
LD_PRELOAD=/tmp/mh-proc-compat.so lake env lean Audit.lean
```

This Linux-only workaround is not enabled in the supplied GitHub workflow. The user successfully pushed version 0.3 to the private repository. The connected GitHub app returned 404 when attempting to inspect that repository; no remote CI result has been observed. Version 0.4 is checked locally, and no new remote push or remote clean-clone reproduction is claimed.

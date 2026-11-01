# Build verification — prototype 0.3

Date: 2026-11-01.

Official binary distribution: [Lean 4.35.0](https://github.com/leanprover/lean4/releases/tag/v4.35.0), compiler commit `eb6cafb7290e8bd5f2937522d8d804f58f02bafc`. This exact toolchain is pinned; no Mathlib dependency is used. It was selected from the official releases and Reservoir listings, not guessed.

## Checks performed

Source was copied to a clean directory without build artifacts. `lake build` succeeded (9 jobs), `lake env lean Audit.lean` succeeded, and `python3 scripts/audit_sources.py` succeeded (40 source candidates, 8 Lean files). Full outputs are under verification/.

Audit.lean prints selected theorem statements and axiom dependencies of twelve principal declarations, including the new sufficient bridges and public-benefits witnesses. Each printed dependency report says the declaration does not depend on any axioms. This is not a claim that policy interpretations or case assumptions are assumption-free. Their substantive choices are visible in the model and theory definitions.

## Container compatibility

This execution container exposes the current executable through `/proc/self/exe` but the runtime's `/proc/<own-pid>/exe` lookup failed. An optional C shim in scripts/proc_self_compat.c redirects only that same-process link lookup to the equivalent self path. It does not modify Lean's kernel, proof objects, or any logical operation. Lean's original binary and libraries performed the checks.

The logs were produced with the compatibility shim loaded and explicit LEAN_SYSROOT/LAKE_HOME paths to the extracted distribution. On a normal Linux or macOS installation, follow the ordinary README commands; the compatibility shim should not be necessary.

To reproduce this container-specific workaround when needed:

```bash
gcc -shared -fPIC -O2 scripts/proc_self_compat.c -ldl -o /tmp/mh-proc-compat.so
LD_PRELOAD=/tmp/mh-proc-compat.so lake build
LD_PRELOAD=/tmp/mh-proc-compat.so lake env lean Audit.lean
```

This Linux-only workaround is not enabled in the supplied GitHub workflow. The workflow is configured, but no remote CI run has been observed. No clean-clone remote reproduction is claimed.

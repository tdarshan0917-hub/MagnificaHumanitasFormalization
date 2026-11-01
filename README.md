# Magnifica Humanitas Formalization

Research prototype 0.2 — 2026-11-01. A small Lean model and example suite; see the verification logs for actual build status. No remote GitHub repository is claimed.

Question: what governance conclusions follow from explicit formal interpretations, and what additional assumptions do other conclusions need?

## Start here

1. [Research contract](docs/V1_RESEARCH_CONTRACT.md)
2. [Source scope and evidence](docs/SOURCE_SCOPE.md)
3. [Claim ledger](docs/CLAIM_LEDGER.md): 40 candidates, 28 selected for modeling, 12 deferred.
4. [Interpretation ledger](docs/INTERPRETATION_LEDGER.md)
5. [Assumption ledger](docs/ASSUMPTION_LEDGER.md)
6. [Theorem dependency audit](docs/THEOREM_DEPENDENCY_AUDIT.md)
7. [Countermodel protocol](docs/COUNTERMODEL_PROTOCOL.md)
8. [Execution status and next milestone](docs/EXECUTION_STATUS.md)
9. [Required public report](docs/PUBLIC_REPORT_REQUIREMENTS.md)
10. [Prototype result explanations](docs/TECHNICAL_RESULTS.md)
11. [Plain-language progress report](output/pdf/MagnificaHumanitas_Plain_Language_Progress_Report.pdf)
12. [Build evidence and environment notes](docs/BUILD_VERIFICATION.md)

The machine-readable claim ledger is [claims.csv](data/claims.csv), with the same records in [JSON](data/claims.json).

## Evidence boundary

Selection is an editorial decision for this prototype, not acceptance of a claim as universally true. Formal candidates are our modeling proposals. Only the small responsibility/appeal/remedy fragment is implemented. Source fidelity, satisfiability, formal consequences, and empirical validation are separate questions.

Local build evidence is recorded in verification/. A workflow is supplied; remote CI success, release 1.0, novelty priority, and operational compliance certification are not claimed.

## Build and reproduce

Pinned toolchain: `leanprover/lean4:v4.35.0`. No Mathlib or third-party Lean package is needed. Install Lean following the [official instructions](https://lean-lang.org/install/manual/), then run these commands inside the extracted project directory:

```bash
lake build
lake env lean Audit.lean
python3 scripts/audit_sources.py
```

An official Lean binary distribution also works when its `bin` directory is on PATH. The first prototype separates appeal from correction capacity and supplies a non-vacuous satisfying example. See the public PDF and technical result map for the scope of those claims.

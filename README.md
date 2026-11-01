# Magnifica Humanitas Formalization

Research prototype 0.7 — 2026-11-01. Lean models for appeal/remedy, public-benefits responsibility, high-stakes timing, and appeal obligations under narrow/broad readings, oversight coverage/power, and participation versus final control. Repository access is connected; the version 0.6 GitHub build was independently verified. Current checks are visible in GitHub Actions.

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
13. [Target coverage and definition ceiling](docs/RESULT_COVERAGE.md)
14. [Update the existing Mac/GitHub repository](docs/UPDATE_EXISTING_REPOSITORY.md)
15. [Current user-approved build guidelines](docs/CURRENT_BUILD_GUIDELINES.md)

The machine-readable claim ledger is [claims.csv](data/claims.csv), with the same records in [JSON](data/claims.json).

## Evidence boundary

Selection is an editorial decision for this prototype, not acceptance of a claim as universally true. Formal candidates are our modeling proposals. Only small responsibility/appeal/remedy fragments and bounded case models are implemented; oversight adds an explicitly limited capacity interpretation. Source fidelity, satisfiability, formal consequences, and empirical validation are separate questions.

Local build evidence is recorded in verification/. Remote CI for version 0.6 was verified at [the successful main-branch run](https://github.com/tdarshan0917-hub/MagnificaHumanitasFormalization/actions/runs/41357071014). Check the current run for later changes. Release 1.0, novelty priority, and operational compliance certification are not claimed.

## Build and reproduce

Pinned toolchain: `leanprover/lean4:v4.35.0`. No Mathlib or third-party Lean package is needed. Install Lean following the [official instructions](https://lean-lang.org/install/manual/), then run these commands inside the extracted project directory:

```bash
lake build
lake env lean Audit.lean
python3 scripts/audit_sources.py
```

An official Lean binary distribution also works when its `bin` directory is on PATH. The recourse example separates appeal from correction capacity. The public-benefits example distinguishes general staffing, identifiable assignment, and correction power. The high-stakes example compares the same events in different orders and proves conditional invariants over all finite modeled continuations. The oversight example separates the existence of an independent board from its remit and intervention capacity for a specific denial. The participation example records and amends community input with demonstrated outcome influence while separating it from a binding final decision rule. These are limited capacity/procedure interpretations, not complete definitions of effective oversight or subsidiarity. Explicit satisfying cases accompany the separation examples. See the public PDF and technical result map for the scope of those claims.

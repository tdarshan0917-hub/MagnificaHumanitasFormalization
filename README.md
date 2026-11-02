# Magnifica Humanitas Formalization

Research prototype 0.14 — 2026-11-01. Lean models for selected AI-governance requirements in the three agreed cases. This checkpoint consolidates the original positive targets and checks an explicit interpretation family, including incomparable appeal/remedy extensions and a shared eight-combination witness. The version 0.13 GitHub build was independently verified; current checks are visible in GitHub Actions.

Question: what governance conclusions follow from explicit formal interpretations, and what additional assumptions do other conclusions need?

Actual code-to-question map: [What the Lean code checks](docs/LEAN_WORK_MAP.md). Active sequence: [Original V1 execution plan](docs/EXECUTION_PLAN.md). The project is still in its formal research phase.

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
16. [Active target tracker](docs/V1_COMPLETION_MATRIX.md)
17. [Scope and significance audit](docs/SCOPE_AUDIT_0_9.md)

The machine-readable claim ledger is [claims.csv](data/claims.csv), with the same records in [JSON](data/claims.json).

## Evidence boundary

Selection is an editorial decision for this prototype, not acceptance of a claim as universally true. Formal candidates are our modeling proposals. Only small responsibility/appeal/remedy fragments and bounded case models are implemented; oversight adds an explicitly limited capacity interpretation. Source fidelity, satisfiability, formal consequences, and empirical validation are separate questions.

Local build evidence is recorded in verification/. Remote CI for version 0.13 was verified at [the successful main-branch run](https://github.com/tdarshan0917-hub/MagnificaHumanitasFormalization/actions/runs/41371666341). Check the current run for later changes. Release 1.0, novelty priority, and operational compliance certification are not claimed.

## Build and reproduce

Pinned toolchain: `leanprover/lean4:v4.35.0`. No Mathlib or third-party Lean package is needed. Install Lean following the [official instructions](https://lean-lang.org/install/manual/), then run these commands inside the extracted project directory:

```bash
lake build
lake env lean Audit.lean
python3 scripts/audit_sources.py
```

An official Lean binary distribution also works when its `bin` directory is on PATH. The recourse example separates appeal from correction capacity. The public-benefits example distinguishes general staffing, identifiable assignment, and correction power. The high-stakes example compares the same events in different orders and proves conditional invariants over all finite modeled continuations. The oversight example separates the existence of an independent board from its remit and intervention capacity for a specific denial. The participation example records and amends community input with demonstrated outcome influence while separating it from a binding final decision rule. These are limited capacity/procedure interpretations, not complete definitions of effective oversight or subsidiarity. The developer example checks how design-stage responsibility differs from assignment for a later denial; it does not determine legal liability or complete ethical design. The authority case distinguishes operational control from institutional recognition; it does not define full legitimacy. Explicit satisfying cases accompany the separation examples. The premature 0.9 freeze is withdrawn. The delegation example changes the producer to AI, preserves the existing rules and compares retaining/removing the human officer. The disclosure example publishes actual commitments and numerical reasons while separating the service contact from the actual case assignee. T10/C1 are now checked in that bounded interpretation; C4 now has the adopted case-policy test and C5 the composed distributed-pause comparison; the remaining original positive questions are active before final writing and release. See the public PDF and technical result map for the scope of those claims.

Checkpoint 0.12 adds [Fairness.lean](MagnificaHumanitas/Fairness.lean): a truthful channel-penalty explanation can coexist with failure of the adopted equal-eligibility tests, even while the existing safeguard checklists hold. Removing the penalty supplies both tests. See [scope and assumptions](docs/SCOPE_AUDIT_0_12.md). C5 now has a composed pause comparison; incomplete positive-target questions remain active before final writing/release.

Checkpoint 0.13 adds [DistributedControl.lean](MagnificaHumanitas/DistributedControl.lean): separate operator and independent-board holds each pause the contested denial, while initially the recorded community request has no effect under any external setting. Enabling the local pause retains both external powers. See [scope and assumptions](docs/SCOPE_AUDIT_0_13.md). All six C questions have bounded witnesses; step 5 of the original plan reviews and attempts incomplete positive targets before final writing/release.

Checkpoint 0.14: [positive target evidence map](docs/POSITIVE_TARGET_CONSOLIDATION.md), [interpretation robustness matrix](docs/INTERPRETATION_ROBUSTNESS_MATRIX.md), and [actual synthesis proofs](MagnificaHumanitas/InterpretationRobustness.lean). No new case or principal definition is added. T7/T8 governing-criteria and T3/T6 review/correction connections remain active before final writing/release.

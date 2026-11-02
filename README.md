# Magnifica Humanitas Formalization

**Version 1.0 documents and reproducible source package — November 2, 2026.**

This project examines what selected AI-governance principles require when put into explicit procedures. Its Lean examples distinguish an actual assignee from a service contact, appeal from correction power, review from applied correction, consultation from control, explanation from an adopted fairness test, and a requested stop from a timely stop.

The formal suite covers the three agreed domains—employment, public benefits/services and bounded high-stakes autonomy—with examined dispositions for ten target questions and six countermodel questions. The final papers explain both the checked results and the assumptions that make them hold.

## Read the findings

- [Public report 1.3, six pages](output/pdf/MagnificaHumanitas_Plain_Language_Progress_Report.pdf): **Who can challenge, correct and decide?** The filename retains the earlier report path for existing links; the current document is the integrated six-page revision 1.3, with the credited header, seven key findings, source analysis, checked examples, institutional execution blueprint and acknowledgment. The original 22 body paragraphs are retained, with four additional execution paragraphs. The original V1 package retains its historical six-page report.
- [Technical paper, sixteen pages](output/pdf/MagnificaHumanitas_Technical_Paper.pdf): **From Principles to Working Safeguards**.
- [Editable public report](docs/PUBLIC_REPORT.md) and [public manuscript](paper/public_report.json).
- [Editable technical text](docs/TECHNICAL_PAPER.md) and [structured manuscript](paper/manuscript.json).
- [V1 release notes](docs/RELEASE_NOTES_V1.md), [reproduction instructions](docs/REPRODUCE_V1.md) and [completion audit](docs/V1_COMPLETION_AUDIT.md).

## Evidence behind the findings

- [Research contract](docs/V1_RESEARCH_CONTRACT.md), [execution plan](docs/EXECUTION_PLAN.md) and [public report requirements](docs/PUBLIC_REPORT_REQUIREMENTS.md).
- [Source scope](docs/SOURCE_SCOPE.md), [source version fingerprints](data/source_version.json), [claim ledger](docs/CLAIM_LEDGER.md), [JSON](data/claims.json) and [CSV](data/claims.csv): 40 candidates, 28 selected, 12 deferred.
- [Interpretation ledger](docs/INTERPRETATION_LEDGER.md) and [assumption ledger](docs/ASSUMPTION_LEDGER.md).
- [Code-to-question map](docs/LEAN_WORK_MAP.md), [positive-target evidence](docs/POSITIVE_TARGET_CONSOLIDATION.md) and [interpretation robustness matrix](docs/INTERPRETATION_ROBUSTNESS_MATRIX.md).
- [Proof dependency audit](docs/THEOREM_DEPENDENCY_AUDIT.md), [build evidence](docs/BUILD_VERIFICATION.md), [source manifest](verification/lean_source_manifest.json) and [document manifest](verification/document_manifest.json).

## Reproduce

Pinned toolchain: `leanprover/lean4:v4.35.0`. No Mathlib or third-party Lean dependency is required. Inside this repository, run:

```bash
lake build
lake env lean Audit.lean
python3 scripts/audit_sources.py
python3 scripts/verify_release.py
```

The mathematical sources are byte-identical to verified formal checkpoint `0b938e373dbf538fe0853f6282e4d9502e67ea01`. Its [GitHub verification run](https://github.com/tdarshan0917-hub/MagnificaHumanitasFormalization/actions/runs/41394350840) passed build, proof audit and source checks. The final document commit has its own GitHub Actions run. The downloadable package records that exact packaging commit, checksums and CI evidence.

The library has 2,789 Lean lines in 21 files; Audit.lean reports dependencies for 106 selected declarations. These counts are proof inventory, not a count of independent discoveries. The original goal of 10–15 independently substantive positive results is not claimed met; the completion audit documents the mixed outcome of the fixed suite. No additional theorem families were invented to fill that quota.

## Interpretation boundary

The official English source scope is §§97–111. Source principles, operational definitions, hypothetical facts and checked consequences remain distinguishable. The repaired models demonstrate compatibility and specific working mechanisms. They do not certify actual institutions, the entire encyclical, complete moral legitimacy or sole legal liability. The three policies and eight-combination witness have their exact scope stated in the technical paper and matrix.

Earlier checkpoint documents are retained as dated development records; the V1 completion audit and final paper state the final status. The source corpus is not redistributed. No outside consultation or approval of this research is a completion requirement. A GitHub V1 tag/release is not implied by the presence of the final documents; publication of a tag is a separate repository action.

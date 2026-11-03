# Magnifica Humanitas Formalization

**Release 1.1 - November 3, 2026.** Public report 1.5, technical paper 1.2 and one-page summary 1.0 share this publication release.

This project examines what selected AI-governance principles require when put into explicit procedures. Its Lean examples distinguish an actual assignee from a service contact, appeal from correction power, review from applied correction, consultation from control, explanation from an adopted fairness test, and a requested stop from a timely stop.

The formal suite covers the three agreed domains—employment, public benefits/services and bounded high-stakes autonomy—with examined dispositions for ten target questions and six countermodel questions. The final papers explain both the checked results and the assumptions that make them hold.

## Read the findings

- [One-page illustrated summary](output/pdf/MagnificaHumanitas_One_Page_Summary.pdf): start here for the purpose, Lean explanation, example, correction-route diagram and institutional checks.
- [Public report 1.5, six pages](output/pdf/MagnificaHumanitas_Plain_Language_Progress_Report.pdf): the close reading, seven findings and practical blueprint, rewritten in plain speech.
- [Technical paper 1.2, seventeen pages](output/pdf/MagnificaHumanitas_Technical_Paper.pdf): definitions, exact evidence, what Lean adds, assumptions and the sourced EU legal comparison.
- [Reusable diagram](output/figures/decision_to_correction.svg) and [PNG](output/figures/decision_to_correction.png).
- [Current revision record](docs/PLAIN_LANGUAGE_REVISION_2026-11-03.md) and [earlier corrections](docs/REPORT_REVISION_2026-11-02.md).
- [Zenodo deposit guide](publication/ZENODO_DEPOSIT_GUIDE.md), [publication metadata](publication/zenodo_metadata.json), [release identity](publication/release.json) and [reader-check sheet](publication/READER_CHECK.md).
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

The mathematical sources are byte-identical to verified formal checkpoint `0b938e373dbf538fe0853f6282e4d9502e67ea01`. Its [GitHub verification run](https://github.com/tdarshan0917-hub/MagnificaHumanitasFormalization/actions/runs/41394350840) passed build, proof audit and source checks. The final document commit has its own GitHub Actions run. The companion source package records that exact packaging commit, checksums and CI evidence. It can be circulated with the reports and reproduced without GitHub access; the repository remains private. Its root includes RELEASE_COMMIT.txt, RELEASE_VERIFICATION.json and MANIFEST.sha256.

The library has 2,789 Lean lines in 21 files; Audit.lean reports dependencies for 106 selected declarations. These counts are proof inventory, not a count of independent discoveries. The original goal of 10–15 independently substantive positive results is not claimed met; the completion audit documents the mixed outcome of the fixed suite. No additional theorem families were invented to fill that quota.

## Interpretation boundary

The official English source scope is §§97–111. Source principles, operational definitions, hypothetical facts and checked consequences remain distinguishable. The repaired models demonstrate compatibility and specific working mechanisms. They do not certify actual institutions, the entire encyclical, complete moral legitimacy or sole legal liability. The three policies and eight-combination witness have their exact scope stated in the technical paper and matrix. The legal discussion is an implementation comparison, not a formalization or certification of the cited laws.

Earlier checkpoint documents are retained as dated development records; the V1 completion audit and final paper state the final status. The source corpus is not redistributed. No outside consultation or approval of this research is a completion requirement. A GitHub V1 tag/release is not implied by the presence of the final documents; publication of a tag is a separate repository action.

## Publication status

Release 1.1 is prepared for Zenodo; no DOI has been reserved or registered here. Cite the title, author and release version until the published DOI is available. Copyright remains with the author; this preparation grants no additional reuse license. The source ZIP contains all three current PDFs and is reproducible without GitHub access. No independent nontechnical-reader study has been performed; the supplied reader-check sheet supports that editorial step.

# Reproduce the Version 1.0 artifact

Current release: **1.1**. Components: public report 1.5 (six pages), technical paper 1.2 (seventeen pages) and one-page summary 1.0. See [current revision record](PLAIN_LANGUAGE_REVISION_2026-11-03.md).

## Two exact revisions

The formal checkpoint is `0b938e373dbf538fe0853f6282e4d9502e67ea01` (0.16). All 21 delivered Lean sources match that revision byte for byte; `verification/lean_source_manifest.json` records SHA-256 and Git blob identities. The final documentation commit adds the papers, source-version evidence and release scripts. The downloadable ZIP records its exact packaging commit in `RELEASE_COMMIT.txt` and has a `MANIFEST.sha256` for its payload. No uncreated GitHub tag is needed to identify either revision.

Clone the repository and check out the packaging commit recorded in the ZIP, or extract the ZIP and enter `MagnificaHumanitas_V1/`. The repository is private, so cloning requires authorized GitHub access; the source ZIP is self-contained apart from the pinned compiler and document-rendering dependencies.

## Check the Lean results

Install `leanprover/lean4:v4.35.0` using Lean's official distribution or elan. The supplied `lean-toolchain` pins the version. No Mathlib or other Lean package is required.

```bash
lake build
lake env lean Audit.lean
python3 scripts/audit_sources.py
python3 scripts/verify_release.py
```

`lake build` checks the imported formal modules. `Audit.lean` compiles selected declarations and reports their logical dependencies. The source audit checks ledger consistency and prohibited proof shortcuts. The release verifier checks delivered source/PDF hashes, declared document lengths and the manuscript's theorem references. Python 3 with `pypdf` is required for the PDF checks; it is not needed for the Lean proof check.

The original container's optional Linux proc-self compatibility shim is described in BUILD_VERIFICATION.md. Ordinary macOS/Linux builds and GitHub Actions use the unmodified pinned compiler. Existing verification logs record the formal checkpoint; the package's `RELEASE_VERIFICATION.json` records the independently inspected final-commit CI result.

## Regenerate the reports and diagram

Document generation requires Python 3, `reportlab`, `pypdf`, `pymupdf` (for the PNG export), and the DejaVu Sans fonts. The scripts use `/usr/share/fonts/truetype/dejavu` by default; adjust that font location on other systems without changing the manuscript.

```bash
python3 scripts/make_technical_paper.py
python3 scripts/make_public_report.py
python3 scripts/make_one_page_summary.py
```

The structured technical source is `paper/manuscript.json`; the script also emits `docs/TECHNICAL_PAPER.md`. Public prose is in `paper/public_report.json`, summary prose is in `paper/one_page_summary.json`, and the shared vector diagram is in `scripts/report_graphics.py`. The renderers emit editable Markdown and the public extracted text at `output/pdf/report_text.txt`. The delivered PDFs were generated with ReportLab 4.4.9 and verified with pypdf 6.10.0. All PDF builds fix their internal creation metadata for reproducibility; byte identity also depends on using the same ReportLab/font versions. Run the release verifier against the delivered PDFs before regeneration. If regenerating with different rendering dependencies, compare extracted content and layout rather than assuming the existing PDF checksum will match.

## Check the source version

`data/source_version.json` gives the official English URL, access time, response-body SHA-256 and the normalization used for the selected-scope checksum. The full source HTML is not redistributed. A later download may differ because of webpage changes; the recorded fingerprint is evidence of the accessed representation, not a retained immutable full-text archive.

## Rebuild the release ZIP

From the final checked-out Git revision:

```bash
python3 scripts/package_v1.py --verification /path/to/RELEASE_VERIFICATION.json
```

The packager reads tracked files from the current commit, adds exact revision/verification records, and constructs a sorted, fixed-timestamp ZIP and payload checksums. It excludes Git internals, temporary downloads and build caches. The external verification record must name the same commit and a successful GitHub run. Its output is `dist/MagnificaHumanitas_V1_Source_and_Reports.zip`.

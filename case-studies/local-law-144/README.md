# Local Law 144: from published safeguards to an actionable challenge

Travis Darshan · Documentary build 0.2 · 5 November 2026

**Status: five-employer documentary build, not Release 1.2.** Five deep reviews have been reconciled under Codebook 0.2. The 25-employer corpus, new Lean results and final case-study report are not complete.

Question: when an employer publishes AI hiring safeguards, what do the applicable requirements and the available documents establish about a candidate's route to reconsideration and correction?

## Start here

- [Plain-language build summary](BUILD_SUMMARY_0_2.md).
- [Protocol](PROTOCOL.md): fixed sample, selection method, evidence boundaries and stopping point.
- [Coding rules](CODEBOOK.md): reproducible distinctions for the three scan questions and six deep-review checks.
- [Primary-source register](data/sources.json) and [legal source ledger](data/legal_claims.json).
- [First employer: Citizens](employers/E001-citizens.md) and [structured evidence](data/employers.json).
- [Discovery log](data/discovery_log.json): includes pilot-first selection and unsuccessful searches; no retrospective preregistration claim.
- [Formal target map](FORMAL_TARGETS.md): proposed targets and reuse of the existing Lean suite.
- [Review kit](review-kit/README.md): five starter instruments, ready for completing against institution-specific evidence.
- [Milestones](STATUS.md): exact completed and pending work.

## Reproduce the documentary checks

From the repository root:

```sh
python3 case-studies/local-law-144/scripts/validate_study.py
```

This checks evidence references, coverage and coding consistency. It does not validate legal interpretations, test a live employer workflow or replace Lean proof checking. It refuses to report a final sample rate before the corpus and second-pass reviews are complete.

## Relationship to the original release

Base commit: `50ec7e0fcce32ce7cf9a85a718b7b4a9feebb5c9` (Release 1.1 documents; formal checkpoint 0.16).
Branch: `case-study/local-law-144`. The original source, PDFs and publication identifiers are unchanged by this build.

The existing framework supplies responsibility, appeal and correction distinctions. New York law is a separate source of requirements. N/B/H are interpretation policies, not legal compliance certificates. Recommendations carry their own normative label. Employer statements are evidence of disclosure, not verified performance.

The eventual deliverable is one law-level analysis, a scan of 25 employers with five deep reviews, a bounded Lean extension, a 3–4-page case-study report and an evidence appendix/review kit. An authorized operational pilot may follow; it is not required to publish the documentary study. Release numbering and a separate case-study DOI will be finalized when the deliverables are ready.

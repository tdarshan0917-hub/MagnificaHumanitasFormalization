# Who Can Challenge an Automated Hiring Decision?

NYC Local Law 144 · Travis Darshan · Report v1.0 · 9 November 2026

**Status: documentary corpus closed at 20 employer groups, including five deep reviews.** The bounded search finished five groups short of target. The two Lean modules implement the five formal targets.

Question: when an employer publishes AI hiring safeguards, what do the applicable requirements and the available documents establish about a candidate's route to reconsideration and correction?

## Start here

- [Read the case-study report](REPORT.md).
- [Follow the worked case from challenge to correction](review-kit/WORKED_EXAMPLE.md).

- [Documentary results and scope](DOCUMENTARY_RESULTS.md).
- [Discovery build summary](BUILD_SUMMARY_0_3.md).
- [Protocol](PROTOCOL.md): fixed sample, selection method, evidence boundaries and stopping point.
- [Coding rules](CODEBOOK.md): reproducible distinctions for the three scan questions and six deep-review checks.
- [Primary-source register](data/sources.json) and [legal source ledger](data/legal_claims.json).
- [First employer: Citizens](employers/E001-citizens.md) and [structured evidence](data/employers.json).
- [Discovery log](data/discovery_log.json): includes pilot-first selection and unsuccessful searches; no retrospective preregistration claim.
- [Formal results and model ledger](FORMAL_RESULTS.md).
- [Formal target map](FORMAL_TARGETS.md): original targets and reuse of the existing Lean suite.
- [Review kit](review-kit/README.md): five reusable instruments for institution-specific evidence.
- [Milestones](STATUS.md): exact completed and pending work.

## Reproduce the study

Check out the [verified evidence and code revision](https://github.com/tdarshan0917-hub/MagnificaHumanitasFormalization/tree/c23d919694222a6cab7b7da6d9b0639f9cf97ef6) and run these commands from the repository root with the pinned toolchain.

```sh
lake build MagnificaHumanitas LocalLaw144Study
lake env lean LocalLaw144Study/Audit.lean
python3 case-studies/local-law-144/scripts/validate_study.py
```

Lake checks the formal models. The documentary validator checks the frozen evidence records, coding consistency and sample counts.

## Relationship to the original release

Base commit: `50ec7e0fcce32ce7cf9a85a718b7b4a9feebb5c9` (Release 1.1 documents; formal checkpoint 0.16).
Branch: `case-study/local-law-144`. The original source, PDFs and publication identifiers are unchanged by this build.

The existing framework supplies responsibility, appeal and correction distinctions. New York law is a separate source of requirements. N/B/H are interpretation policies, not legal compliance certificates. Recommendations carry their own normative label. Employer statements are evidence of disclosure, not verified performance.

The report uses the frozen documentary sample and verified model. The kit includes a synthetic example. Institution-specific performance requires separate operational evidence.

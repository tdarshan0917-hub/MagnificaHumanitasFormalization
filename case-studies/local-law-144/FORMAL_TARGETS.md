# Bounded formal target map

The implementation and field-level scope are recorded in [formal results](FORMAL_RESULTS.md).

## Reuse

- `MagnificaHumanitas/Model.lean`, `Theory.lean`: provision/requirement separation and N/B/H policy interfaces.
- `PublicBenefits.lean`, `Responsibility.lean`: contact versus actual assigned, identifiable, empowered actor. Reuse the distinction; do not treat the benefits case as an employment instance.
- `AppealReview.lean`, `InterpretationRobustness.lean`: compare named policies without equating them to statutes.
- `RuleCorrection.lean`: actual change to an operative rule differs from recorded objection.
- `AppealCorrection.lean`: `completed_path_iff`, `static_safeguards_do_not_supply_handoff`, `ordered_path_corrects_existing_denial` and `handoff_repair_preserves_submission_and_review`. Adapt the scenario and outputs explicitly; do not relabel existing theorems as new empirical findings.

## Implementation files

`LocalLaw144Study/LocalLaw144.lean` and `LocalLaw144Study/EmploymentWorkflow.lean`. The dedicated Lake library gives the case study its own proof audit.
Use a dedicated case-study audit file and build target at implementation time; existing release source manifests stay intact.

## Fixed questions

| ID | Target | Required evidence/semantic work |
|---|---|---|
| F1 | Give a satisfiable representation of selected audit/publication/notice duties and their applicability conditions. | L01–L04, L07–L10; explain omitted statutory duties, exceptions, dates, auditor independence and retained outside remedies. Never call it full LL144 compliance. |
| F2 | Decide which of N/B/H follows from that fragment; give a non-vacuous witness or explicit bridge where it does not. | Inspect actual policy definitions; preserve affected/high-impact facts and record legal versus interpretive premises separately. |
| F3 | Exhibit an encoded-duty-satisfying workflow with a warranted review finding but an unchanged assessment when the correction connection is missing. | New hiring dataflow; no assumption that actual Citizens procedures lack a connection. |
| F4 | Change only the identified routing/authority connection and compute the different final assessment on the same supported request and finding. | Transition functions must implement repair; prove preservation of encoded duties and unrelated channels. Case owner fixes separately if needed for a policy. |
| F5 | Characterize completion conditions and show missing-authority, missing-delivery and premature-application cases. | State necessary exercise/delivery assumptions, same-case and authorized-role linkage; do not assume final correction as a premise. |

The repaired path may correct applicant data and cause reassessment; a job offer is not the defined success criterion. A rule-level fairness change requires a separate adopted standard: LL144 impact-ratio calculations are not our earlier channel-invariance fairness test.

## Avoiding circularity

Start from a candidate record and an independently computed justified finding; define review and application functions. Derive the resulting record by evaluating the functions. For a claimed guarantee over all allowed executions, explicitly model required execution/delivery or show why an execution can stall. Existence of a successful trace is not universal eventual completion. Do not assume employment or correction happened and re-prove the assumption.

An evidence-to-model ledger must label every Boolean/field as a legal premise, hypothetical design choice, or supported case fact. `not_described` and `unclear` produce unknowns, not negative facts. Publish exact scoped conclusions even if a proposed separation fails.

## Implementation handoff — 9 November 2026

The documentary corpus is closed at 20 and the counts are reproducible. Begin the Lean implementation on the existing case-study branch. The project already has the required Lake package, a Lean 4.35.0 pin and the reusable governance interfaces. The extension can have its own build entry and dependency audit within this repository.

### First module

1. In `LocalLaw144.lean`, define a hiring-use input with distinct facts for covered NYC use and candidate NYC residence. Represent the reliance categories from L07 separately from tool identity. For F1, encode the selected audit, publication and notice conditions with an explicit before-use ordering, an audit freshness predicate and a business-day notice interval. Keep independence and technical audit adequacy as declared predicates with traceable meanings until their criteria are modeled. List the status of L04 and L08–L10 individually, including each abstraction or omission. Preserve outside-remedy scope from L05–L06 in the ledger.
2. Check a witness with covered use and an NYC resident candidate so the triggered obligations are exercised. Check a failed notice boundary and a failed audit condition. Then evaluate the actual N, B and H definitions using `CompliantAt`. An excluded, affected candidate in a high-impact screening example triggers appeal and responsibility questions. An additional harmed case tests H's remedy-capacity requirement. Use a witness for each failed implication and name each added premise for any positive implication.

### Second module

3. In `EmploymentWorkflow.lean`, use a small, hypothetical hiring assessment. A submitted qualification is incorrectly recorded as absent, so the initial screen produces an adverse result. Review compares the stored field with independently supported evidence and produces a case-linked finding.
4. Hold the candidate, finding, rule and selected audit/notice conditions fixed. Evaluate a trace where the finding is recorded but lacks a route to the case's authorized implementer. Add that connection and evaluate a trace where the finding is delivered, applied to the same case and followed by reassessment. Check the revised result and prove preservation of the audit/notice conditions and unrelated channels.
5. State the conditions for a completed correction in the modeled trace. Check missing authority, missing delivery, wrong case and application attempted before review. Separate available capacity from actual exercise of it. If the transition system permits an actor to stop early, characterize successful completion under its stated execution conditions.

The evidence-to-model ledger must trace each field to a selected legal premise, a hypothetical design choice or a sourced documentary fact. Employer counts remain in the documentary layer. Unknown disclosures cannot set a modeled employer safeguard to false.

For acceptance, build the new modules with the pinned toolchain, audit proof dependencies, and run the existing release and documentary verification. Keep the case-specific proof audit separate from the original release audit.

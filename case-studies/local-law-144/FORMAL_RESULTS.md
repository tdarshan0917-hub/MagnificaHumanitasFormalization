# Local Law 144 formal build

The hypothetical hiring case exercises selected audit, publication and notice requirements. Lean checks that a workflow can satisfy those requirements while an excluded candidate lacks an appeal. In a second hypothetical workflow, a reviewer finds a qualification was recorded incorrectly. The adverse screen remains in place when the finding has no delivery route. The same finding changes the assessment after delivery to an actor authorized for that case.

| Target | Checked result | Lean entry |
| --- | --- | --- |
| F1 | A covered use involving a NYC resident satisfies the selected duties. Nine business days of notice and an expired audit each fail in separate variations. | `example_selected_duties`, `nine_business_days_fails`, `expired_audit_fails` |
| F2 | A covered example can satisfy the duties and fail all three interpretation policies. Supplying appeal and identifiable responsibility without remedy capacity satisfies N and B in this harmed example, and fails H. | `selected_duties_allow_screen_without_appeal`, `review_without_remedy_separates_policies` |
| F3 | A review can produce a case-linked finding while a missing route leaves the adverse screen in place. | `review_without_delivery_leaves_adverse_screen` |
| F4 | Changing the route alone changes the outcome in the example. The audit and notice conditions and the accommodation channel persist. | `routing_repair_changes_assessment`, `repaired_trace_preserves_selected_duties_and_accommodation` |
| F5 | In the executed trace from an adverse assessment, advancement requires a request, evidence supporting the qualification, delivery and authority for the case. Missing authority, missing delivery, wrong-case application and application before review leave the record as it was. | `advances_iff_completed_path` and the application failure lemmas |

## Evidence-to-model ledger

| Fields or parameters | Basis and boundary |
| --- | --- |
| `inNYC`, `qualifyingTool`, `reliance`, `resident` | L03 and L07. The model takes NYC use and tool qualification as supplied facts for one hiring screen. `greatestWeight` means strictly more weight than any other criterion. Statutory definitions outside those inputs remain external. |
| `useDay`, `auditDay`, `auditValidThrough`, `independentAuditor`, `auditAdequate` | L01 and L08. The caller supplies the calendar-derived validity deadline, independence and technical adequacy. The model checks strict earlier-day ordering and the deadline inclusively. Audit metrics and data-source criteria remain inside the adequacy abstraction. |
| `publicationDay`, `latestSummaryPosted`, `distributionDatePosted` | L02. The booleans attest to public posting on the employer or agency website. L09's additional content and six-month retention duties are outside this model. |
| `noticeDay`, `noticeBusinessDays`, `toolDisclosed`, `criteriaDisclosed`, `allowsAlternativeOrAccommodationRequest` | L03 and §20-871(b)(1). The interval is a supplied business-day calculation, with a separate earlier-day check. The model does not validate delivery methods or compute calendars. |
| `alternativeAvailable`, `accommodationAvailable`, `alternativeInstructions`, `accommodationInstructions` | L10. The corresponding instructions are required in the model when a route is available. These fields do not encode a duty to grant a request. |
| Remaining legal scope | L04's data disclosure, written requests and exceptions are outside the selected duties. L05–L06 record enforcement and preserved outside remedies. Those remedies are not resolved by the workflow model. |
| `screeningGovernance` fields | Hypothetical inputs to the existing N, B and H interpretation policies. The case stipulates affected status, exclusion, harm, high impact and identifiable assignment. Appeal and remedy capacity vary separately. Human review and explanation are stipulated and direct AI production takes the existing false default. |
| `caseId`, `recordedQualification`, `use`, `accommodationChannel`, `Finding.caseId` | Hypothetical workflow state. The one-field screening rule derives its outcome from the stored qualification. The case ID links the finding to the assessment, and the accommodation field checks preservation of an unrelated channel. |
| `request`, `supportedQualification`, `route`, `authority`, `delivered` | Hypothetical execution inputs or derived values. Evidence supporting the qualification is an external premise. The authorized actor's remit is represented by the case ID. The full trace generates its finding through review and passes it through delivery. The lower-level application function assumes findings from that trusted workflow. |

The model evaluates an ordered execution. It makes no eventual-delivery guarantee about a system whose actors may stop. Advancing means passing the modeled screen. Employer-document observations stay in the documentary ledger, where an unknown procedure remains unknown.

Primary legal sources are [NYC Administrative Code §20-871](https://codelibrary.amlegal.com/codes/newyorkcity/latest/NYCadmin/0-0-0-135843) and the [DCWP adopted rules](https://rules.cityofnewyork.us/wp-content/uploads/2023/04/DCWP-NOA-for-Use-of-Automated-Employment-Decisionmaking-Tools-2.pdf). The [legal claim ledger](data/legal_claims.json) gives the clause-level scope.

## Reproduce

From the repository root with the pinned toolchain:

```sh
lake build MagnificaHumanitas LocalLaw144Study
lake env lean LocalLaw144Study/Audit.lean
lake env lean Audit.lean
python3 case-studies/local-law-144/scripts/validate_study.py
python3 scripts/audit_sources.py
python3 scripts/verify_release.py
```

The local Lean 4.35.0 build and both proof audits passed. The 15 audited case-study theorems use at most `propext` and `Quot.sound`. The original release inventory and documentary validation also passed.

# Who Can Challenge an Automated Hiring Decision?

**A NYC Local Law 144 case study**
Travis Darshan · Report v1.0 · November 9, 2026

An automated hiring screen stops an applicant because the system marks a required qualification as absent. The applicant challenges the result. A reviewer checks the submission and finds that the qualification was there all along. The finding is recorded, but it never reaches the person authorized to change the assessment. The applicant still does not advance.

Now change one step. Send the same finding to the person authorized to correct that case. The qualification is recorded correctly, the same screening rule runs again, and the applicant advances past the screen. Both versions are hypothetical. Lean, a proof checker, verifies the difference in the encoded workflow. Passing the modeled screen leaves the rest of the hiring decision open. [Worked example](review-kit/WORKED_EXAMPLE.md)

This follow-on to the Magnifica Humanitas study asks what a candidate can learn from public hiring documents about how to challenge a decision and get a supported correction applied. It combines a documentary review with two small Lean models. The documentary review records what was publicly described. The models check which steps can succeed or fail under stated conditions.

## What the law and public documents establish

For covered use, NYC Administrative Code §20-871 requires a bias audit within the preceding year and pre-use publication of the latest audit summary and the tool's distribution date. For candidates who reside in the city, the notice provisions specify at least ten business days' lead time for notice of tool use and the qualifications or characteristics assessed, and require the notice to allow a request for an alternative selection process or accommodation. These duties concern the use, audit and notice of a tool. The study separately asks whether a candidate can challenge an assessment after it has been made and whether an authorized person can apply a correction. [Administrative Code §20-871](https://codelibrary.amlegal.com/codes/newyorkcity/latest/NYCadmin/0-0-0-135843) · [Adopted DCWP rules](https://rules.cityofnewyork.us/wp-content/uploads/2023/04/DCWP-NOA-for-Use-of-Automated-Employment-Decisionmaking-Tools-2.pdf) · [Legal claim ledger](data/legal_claims.json)

We reviewed documents for 20 distinct employer groups, with five reviewed in greater depth. A bounded search fell five groups short of the original target of 25. The review used a fixed coding scheme and a same-reviewer second pass. It favors employers with discoverable notices or audits. Some documents were historical, tool-specific or limited to particular applicants. The counts describe this sample of documents, and actual workflow performance was not observed. [Protocol](PROTOCOL.md) · [Documentary results](DOCUMENTARY_RESULTS.md)

| What we looked for | Documented | Not described | Unclear |
| --- | ---: | ---: | ---: |
| Candidate contact | 18 | 2 | 0 |
| Review role | 12 | 8 | 0 |
| Assignee for a specific case | 0 | 20 | 0 |
| Scoped post-decision or assessment-result review route | 2 | 12 | 6 |
| Instructions to request alternative selection | 7 | 11 | 2 |
| Instructions to request accommodation | 14 | 4 | 2 |

Each row covers 20 groups. “Not described” means we found no scoped description in the reviewed documents. “Unclear” means the evidence was ambiguous, conditional or inaccessible. Neither count establishes that the procedure is absent.

The two documented review routes differ. Instacart describes review of a CodeSignal score or proctoring result for the applicable population. NBCUniversal's March 2026 candidate policy describes a way to request further human review of a recruitment decision. The latter description does not name the primary tool from the earlier NYC notice. Neither source specifically documents a distinct final-rejection procedure. A request for alternative selection or accommodation addresses a separate question from reconsidering a result. [Documentary results and source locators](DOCUMENTARY_RESULTS.md)

## What Lean checked

**Selected audit and notice duties can hold in a model where an excluded applicant lacks an appeal route.** The first model checks a hypothetical covered use involving a NYC resident. It encodes selected audit, publication and notice conditions. Variants with an expired audit or nine business days of notice fail the corresponding conditions. The model takes audit adequacy, independence and calendar calculations as supplied facts. Other legal duties and remedies remain outside the checked fragment. [Formal results and model ledger](FORMAL_RESULTS.md)

**A review finding can be correct and still leave the assessment unchanged.** The second model checks the opening example. Both runs have the same request, evidence, reviewer finding and authorized owner. Only delivery changes. Lean also checks that a finding for the wrong case, missing authority and application attempted before review leave the assessment unchanged. In this ordered trace from an adverse assessment, advancing requires a request, evidence supporting the qualification, delivery and authority for that case. The proof assumes execution of the modeled steps. It leaves open whether a real process actually runs them. [Workflow code at the verified revision](https://github.com/tdarshan0917-hub/MagnificaHumanitasFormalization/blob/c23d919694222a6cab7b7da6d9b0639f9cf97ef6/LocalLaw144Study/EmploymentWorkflow.lean)

## What to check in a hiring workflow

Ask for a case identifier, an acknowledged challenge, a reasoned finding, the authorized recipient and a receipt. If the finding warrants a correction, compare the before and after records and check that the same case was reassessed. Record the disposition sent to the candidate and any remaining hiring steps. When delivery or authority is missing, document where the case stalled and who owns escalation.

These are proposed review controls. The worked example shows how to test them against one baseline and a repaired version. An employer or auditor can use the blank instruments to document its own authority, evidence, deadlines and test outcomes. [Institutional review kit](review-kit/README.md)

## Review the evidence and code

- [Case-study landing page](README.md) brings together this report, the worked example and reproduction commands.
- [Verified source snapshot](https://github.com/tdarshan0917-hub/MagnificaHumanitasFormalization/tree/c23d919694222a6cab7b7da6d9b0639f9cf97ef6) pins the evidence and Lean code used for this report.
- [Frozen employer records and source register](https://github.com/tdarshan0917-hub/MagnificaHumanitasFormalization/tree/c23d919694222a6cab7b7da6d9b0639f9cf97ef6/case-studies/local-law-144/data) contain the documentary inputs and provenance. The freeze hashes the study ledgers. Original source bytes were not archived.
- [Pinned verification run](https://github.com/tdarshan0917-hub/MagnificaHumanitasFormalization/actions/runs/42726581841) records the passing Lean build and proof audits.

Research, formalization and drafting supported by ChatGPT (OpenAI).

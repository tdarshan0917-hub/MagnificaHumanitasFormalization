# Worked example: case 7

A hypothetical applicant submitted a qualification that the screening record marks as absent. A reviewer checks the submission, confirms the discrepancy and records a finding for case 7. The two runs below start from the same adverse assessment. They differ only in whether the finding reaches the authorized decision owner.

The record IDs below are synthetic examples of what an institution could retain. Entries marked “Lean” describe the checked model. Entries marked “kit” describe evidence an actual process would need to produce. No employer or applicant participated in this exercise.

## 1. Evidence worksheet

| Check | Synthetic record | Run A: missing delivery | Run B: delivery restored |
| --- | --- | --- | --- |
| Identify responsibility | AUTH-7, the scope of the owner's authority | Case 7 owner has authority. | Same owner and authority. |
| Examine the assessment | IN-7, submitted qualification and initial record | Submission supports the qualification. The stored field says absent. | Same evidence and rule. |
| Accept challenge | REQ-7, request tied to case 7 | Request enters review. An acknowledgement is a kit record. | Same request. |
| Deliver finding | FIND-7, case-linked finding, and RCPT-7, recipient receipt | Lean generates FIND-7. The delivery step produces no delivered finding. In a live workflow, the missing receipt would trigger escalation. | Lean passes FIND-7 to the application step. The kit calls for a receipt naming the recipient and case. |
| Apply correction | CHANGE-7, before/after field and reassessment | Lean leaves the qualification absent. | Lean sets the qualification to present and evaluates the same screening rule. |
| Check result | RESULT-7, outcome check, and NOTICE-7, candidate communication | Lean returns an adverse screen. The kit leaves the correction open and records the stall. | Lean returns advancement past this screen. The kit requires the revised disposition and a separate notification record. |

## 2. Authority table

| Role | Assigned scope | Evidence to retain |
| --- | --- | --- |
| Candidate support | Receive and acknowledge a challenge. Forward it to the case owner or reviewer. | REQ-7 and the acknowledgement. |
| Assessment reviewer | Examine the source submission and issue FIND-7. | The review assignment, evidence relied on and reasoned finding. |
| Authorized decision owner | Apply the supported correction and reassess case 7. | AUTH-7, effective at the time of action, and CHANGE-7. |
| Candidate communications | Convey the recorded disposition to the applicant. | NOTICE-7 and its delivery status. |

The role names are illustrative. The Lean model represents authority as permission to act on a particular case. The kit separates reviewing, applying a change and notifying the applicant so each action can be checked.

## 3. Correction procedure

Register REQ-7, compare the source submission with IN-7, and issue FIND-7. Deliver the finding to the authorized owner and capture RCPT-7. Match the case identifiers and check AUTH-7 before applying the correction. Record the changed field, reassess with the same rule, verify RESULT-7 and notify the applicant. When the receipt is missing, record a stall and assign escalation to the case owner. Notification and escalation are kit steps outside the Lean trace.

## 4. Test script and outcomes

| Test | Model input or action | Checked result |
| --- | --- | --- |
| A. Finding recorded, route missing | Request and evidence present. Authority covers case 7. Route disabled. | Review produces the finding. The adverse assessment stands. |
| B. Same finding, route enabled | Change only the route from A. | Qualification changes to present and the applicant advances past the screen. |
| Wrong case | Apply a finding for a different case. | The assessment stays as it was. |
| No authority | Apply a delivered finding with no correction authority. | The assessment stays as it was. |
| Too early | Attempt application with no delivered finding. | The assessment stays as it was. |

The results correspond to the [formal results](../FORMAL_RESULTS.md) and the pinned [employment workflow code](https://github.com/tdarshan0917-hub/MagnificaHumanitasFormalization/blob/c23d919694222a6cab7b7da6d9b0639f9cf97ef6/LocalLaw144Study/EmploymentWorkflow.lean).

## 5. Findings and repairs log

| Finding | Owner for the repair | Proposed change | Retest and disposition |
| --- | --- | --- | --- |
| FIND-7 exists in run A, but the workflow has no delivery route to the actor who can act. | Hiring workflow owner, with the authorized decision owner. | Route the finding by case ID and record recipient receipt. | Run B passes in Lean. An operational retest would need RCPT-7, AUTH-7, CHANGE-7, RESULT-7 and NOTICE-7 from the institution's actual workflow. |

Use the [blank instruments](README.md) for an institution-specific review. Keep the original result, revised result and any remaining hiring steps separately visible.

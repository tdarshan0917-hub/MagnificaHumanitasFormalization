# What the Lean code actually checks

Checkpoint 0.10. These are hypothetical models and proofs about explicit rules. They do not establish the truth of the source, legal compliance or facts about a real institution.

## One complete example

In Examples.lean, an applicant is rejected and harmed. A named officer is assigned. An appeal desk accepts the applicant and can review the decision, but initially cannot correct it. The chosen responsibility-and-appeal policy requires a named assignee and an appeal; the stronger policy also requires correction capacity after harm.

`Prototype.responsibility_appeal_not_remedy` proves that the first case satisfies the smaller checklist while lacking correction capacity. `Prototype.uncorrectable_not_stronger_compliant` proves it fails the stronger checklist. `Prototype.prototype_satisfiable_nonvacuously` supplies a case that meets the stronger requirements. Those are actual checked Lean statements, not a claim that the real world has been audited.

## Current code-to-question map

| Plain question | Lean file and actual declaration | What is checked |
|---|---|---|
| Can an appeal exist without correction power? | Examples.lean: `Prototype.responsibility_appeal_not_remedy` | Yes, with a named responsible officer and an accessible review desk |
| Does a known public contact identify the actual case officer? | PublicBenefits.lean: `staffing_and_allocation_do_not_identify_the_assignee` | No; the public contact and the denial's assignee can be different people |
| Does assignment give correction power? | PublicBenefits.lean: `named_responsibility_does_not_supply_power` | No; naming and empowerment are separate facts |
| Can identical final control flags hide different harm? | HighStakes.lean: `same_final_control_flags_different_outcomes` | Yes; stop delivery before/after execution changes the physical outcome |
| Does internal review give the affected person an appeal? | AppealReview.lean: `internal_review_without_appeal` | No; person access can be closed despite internal review |
| Do two appeal-trigger readings accept the same cases? | AppealReview.lean: `narrow_accepts_broad_rejects` | No; an affected, high-impact, non-excluded person separates the readings |
| Does an oversight board cover this denial? | Oversight.lean: `regime_and_internal_review_do_not_cover_denial` | A recognized board can exist with the denial outside its remit |
| Does meaningful input give final control? | Participation.lean: `consultation_and_revision_without_final_control` | Recorded, amendable input can affect an outcome while an institutional override retains control |
| Does naming a developer cover later use? | DeveloperResponsibility.lean: `design_compliance_leaves_downstream_gap` | The later denial still violates its assignment duty if nobody is assigned to it |
| Does technical control supply institutional recognition? | Authority.lean: `technical_control_without_mandate` | No in the stated proxy; this does not settle moral legitimacy |
| Does using AI remove an already established responsibility requirement? | Delegation.lean: `ai_handoff_retains_human_responsibility` and `removing_officer_after_handoff_violates_all_three` | A producer-only handoff preserves the officer and compliance; additionally deleting the officer's assignment violates the unchanged duty |

The theorem names inside each namespace are shown in full in TECHNICAL_RESULTS.md and Audit.lean. The main library imports each file, and the compiler checks their proof terms.

## What was added for delegation

Governance now records `producedByAI` separately from assignment. The producer-only transition is the explicit record update `{ g with producedByAI := usesAI }`. The generic statement `producer_change_preserves_fixed_policy` proves compliance with a fixed checklist is unchanged by this update. A second statement checks that the three existing policy interpretations retain exactly their prior requirements after that update.

The concrete employment comparison then changes production to AI and checks two outcomes: keeping the named officer satisfies the rules; deleting that assignment violates the rules while appeal and correction capacity remain. This is a conditional model of the specified handoff, not a theorem that every real deployment preserves accountability.

## Still active

T10, C1, C4, C5 and incomplete portions of the original positive targets remain work to do. They were not proved impossible by checkpoint 0.9. EXECUTION_PLAN.md restores their place before final writing and release. V1 is not complete.

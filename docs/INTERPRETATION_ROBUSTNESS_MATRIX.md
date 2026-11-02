# Interpretation robustness matrix — checkpoint 0.14

## Meaning of the columns

N = responsibility plus appeal after exclusion (`responsibilityAppealPolicy`). B = retain N and additionally require appeal for an affected person in a high-impact decision (`broadAppealPolicy`). H = retain N and additionally require remedy capacity after stipulated harm (`harmRemedyPolicy`). B does not add H's remedy duty, and H does not add B's pre-exclusion appeal duty. B and H are incomparable: the checked existing examples below separate them in both directions.

The institutional/individual responsibility and regime/decision oversight comparisons use different, explicitly linked structures. They are not silently inserted into a Governance record. In the joint benefits witness, its assigned and identifiable fields are proved equal to the fields of the same ResponsibilityAllocation. Institution-only answerability and regime-only provision are weaker comparison fragments; neither is presented as all source compliance.

“Yes” and “No” concern the stated model/specification only. A dash means that row does not instantiate the corresponding structure; it is not evidence of absence. There are no probabilities or empirical compliance scores.

## Checked existing-case matrix

| Existing case | N | B | H | Institution / actual human assignee | Regime / actionable decision oversight | Lean evidence |
|---|---|---|---|---|---|---|
| Repaired benefits notice; covered and empowered board | Yes | Yes | Yes | Yes / Yes | Yes / Yes | `InterpretationRobustness.joint_repaired_case_all_eight_combinations` |
| Benefits service contact named; actual assignee unidentified | No | No | No | Yes / No | — | `InterpretationRobustness.missing_assignee_fails_all_three_policies` |
| Affected high-impact applicant before exclusion, no accessible appeal, no stipulated harm | Yes | No | Yes | — | — | `AppealReview.nonexcluded_closed_case_satisfies_narrow`; `InterpretationRobustness.appeal_and_remedy_extensions_are_incomparable` |
| Rejected/harmed applicant with appeal but no correction capacity | Yes | Yes | No | — | — | `Prototype.fragment_compliant`; `InterpretationRobustness.appeal_and_remedy_extensions_are_incomparable` |
| Repaired benefits notice, board outside denial remit | Yes | Yes | Yes | Yes / Yes | Yes / No | Joint allocation witness plus `InterpretationRobustness.oversight_gap_survives_all_three_policies` at covered=false, powered=true |
| Repaired benefits notice, covered board without intervention power | Yes | Yes | Yes | Yes / Yes | Yes / No | Joint allocation witness plus the same oversight theorem at covered=true, powered=false |

The two oversight-gap rows reuse the same benefits Governance/allocation as the joint row and vary only the separate oversight instance. No extra case constructor is added.

## Conclusions that survive, and conclusions that depend on the interpretation

| Conclusion | Tested interpretation range | Result and reason |
|---|---|---|
| A high-impact decision needs an identifiable actual assignee under these policies | N/B/H | Shared requirement; missing-assignee case fails all three |
| An excluded person must have appeal | N/B/H | Shared exclusion trigger; uniform criterion displays it explicitly |
| An affected high-impact person must have appeal before exclusion | N/B/H | Depends on B; N/H accept the stated no-harm, pre-exclusion case without appeal |
| Stipulated harm triggers a correction-capacity requirement | N/B/H | Depends on H; N/B accept the no-correction case |
| Wider appeal access supplies correction capacity | B versus H | No; B passes and H fails in an existing harmed-applicant case |
| Correction-capacity policy supplies pre-exclusion appeal | H versus B | No; H passes and B fails in an existing pre-exclusion case |
| The independent-coverage/intervention gaps remain despite safeguard compliance | N/B/H | Yes; all three pass while decision oversight fails. This is a comparison across incomparable policies, not ordinary inheritance alone |
| Responsibility, appeal and oversight choices can coexist non-vacuously | 2 responsibility x 2 appeal x 2 oversight choices; H retained | One shared repaired witness satisfies every combination; theorem parameters range over all three Bool choices |
| Split design/use assignees remain compatible | N/B/H and extra developer assignment on/off | Existing finite stage record satisfies all three; no actor-specific sole-liability claim |
| Passing the adopted base-score rule audit protects equal treatment of the two equally eligible applicants | Existing repaired/unrepaired scoring family | Yes with the explicit assessment premise; truthful explanation alone does not supply it |
| Technical capability supplies authority requiring a scoped institutional mandate | Every authority predicate satisfying the displayed necessary-condition hypothesis | No in the capable/unrecognized operator case; the necessary condition is explicit normative input, not inferred for all authority theories |

## Limits that affect how to read this matrix

This is a declared, checked family. It is not an enumeration of every source interpretation, a proof that the full philosophical concepts are interchangeable with these formulas, or a score for real institutions. Mathematical joint satisfaction and textual justification are separately documented. Clear source commitments remain requirements; the distinctions concern implementations, trigger choices and provided evidence.

I29/A38 record the family and alignment rules. `POSITIVE_TARGET_CONSOLIDATION.md` maps every original target to source passages, exact evidence and concrete remaining obligations. T7/T8 criteria-setting and T3/T6 review/correction action connections remain active before final writing/release.


## Checkpoint 0.15: operative criteria comparison in the same scoring case

The original N/B/H and eight-combination matrix remains as checked at 0.14. RuleCorrection.lean adds this explicit implementation-path comparison. The design actor is the existing developer/design reviewer; a separate deployment actor handles the denial. A candidate assessment compares actual computed awards with the adopted base-score cutoff.

| Rule-revision setting | Objection recorded? | Actor empowered for criteria? | Candidate passes adopted assessment? | Operative result / assisted calculation | Evidence |
|---|---|---|---|---|---|
| Initial penalty rule; assigned design actor lacks criteria power | Yes | No | Yes | Penalty remains; 45/deny | `RuleCorrection.recorded_objection_leaves_penalty_operative` |
| Initial penalty rule; deployment actor acts | Yes | No for this context | Yes | Penalty remains; 45/deny | `RuleCorrection.denial_assignment_does_not_authorize_criteria_revision` |
| Initial penalty rule; assigned design actor has criteria power | Yes | Yes | Yes | Corrected rule becomes operative; 60/grant | `RuleCorrection.authorized_correction_changes_rule_and_awards` |
| Corrected rule; criteria-empowered actor proposes restoring the penalty | Yes | Yes | No | Corrected rule retained; 60/grant | `RuleCorrection.valid_rule_is_preserved` |

The corrected rule survives every finite sequence of these modeled revision attempts (`RuleCorrection.valid_rule_survives_all_finite_revision_attempts`). Existing assignment, identity and appeal/correction channels remain fixed across the successful comparison. This is the declared two-rule family, not a robustness claim for every possible rule change, and recomputation does not reopen old case records automatically. T3/T6's contested-decision appeal/review/correction action path is next.


## Checkpoint 0.16: capacity, connected review and applied correction

AppealCorrection.lean gives the following ordered-path comparison for the existing issued denial after the operative scoring criterion has been corrected. Submission is admitted at the independent board, review produces a finding from that submission and the reassessment, and the implementation office applies the finding. The table concerns this composed path, not arbitrary supplied finding bits.

| Setting | Static appeal/correction capacities | Completed review? | Working handoff and applied update? | Stored award | Evidence |
|---|---|---|---|---|---|
| Request admitted/reviewed; handoff absent | Both available | Yes | No handoff | Deny | `AppealCorrection.static_safeguards_do_not_supply_handoff` |
| Review done; no application action | Both available | Yes | No applied update | Deny | `AppealCorrection.review_without_application_keeps_denial` |
| Update attempted before review | Both available | No | Required finding absent | Deny | `AppealCorrection.application_before_review_keeps_denial` |
| Complete admitted/reviewed/handed-off/applied path | Both available | Yes | Yes | Reassessed grant | `AppealCorrection.ordered_path_corrects_existing_denial` |
| Available powers left unexercised | Both available | No | No | Deny | `AppealCorrection.available_powers_without_exercise_keep_denial` |

`AppealCorrection.completed_path_iff` checks every access/power/handoff/request/review/target combination. N/B/H hold in the same original snapshot even with the missing handoff; these capacity-based policies do not themselves assert completed action. `actionable_board_iff_path_available` derives the board's intervention capacity from the usable ordered correction path, rather than an independent capability flag. This remains administrative correction with explicit dataflow/enforcement assumptions. The original completion audit and writing/release are next.

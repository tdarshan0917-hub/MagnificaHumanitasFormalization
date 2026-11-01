# Prototype results and their limits

Current checkpoint: prototype 0.6. Earlier recourse, public-benefits, high-stakes and appeal-comparison results remain. The oversight comparison is added at the end.

Scope: two expressly chosen requirement sets concerning responsibility, appeal, and prospective remedy capacity. This is a small fragment of the selected source claims. It is not an implementation of all 28 claims or the complete encyclical.

## Models

One person, decision, responsible officer, and appeal desk. Facts are hypothetical. The decision is high-impact, excludes the person, and causes harm. There is explanation and human review. The officer is assigned and identifiable. Access to the desk and its power to review remain fixed. Its power to correct is the only parameter changed.

Actual appeal is existence of an accessible review channel. Actual remedy capacity is existence of an accessible correction channel. These are separate relations. Correction power is an institutional capability stipulated in the example, not a claim that software can create such power or that all harm can be repaired.

## Requirement sets

- `responsibilityAppealPolicy`: impact triggers an identifiable-responsibility duty; exclusion triggers appeal; no remedy-capacity requirement is in this fragment.
- `harmRemedyPolicy`: the same duties, plus harm triggering prospective remedy capacity. This is the optional I04 operational interpretation of MH-023, not the unique possible reading of remedy.

The individual officer reading is I01/A03. It is chosen explicitly for the prototype. No result establishes that every institution has an individual bearer without an allocation premise.

## Result map

| Plain-language finding | Lean declaration | Classification |
|---|---|---|
| Appeal and identified responsibility can coexist with no correction capacity | `Prototype.responsibility_appeal_not_remedy` | Finite separation witness, C3 |
| The same situation fails the policy that additionally requires correction capacity | `Prototype.uncorrectable_not_stronger_compliant` | Scoped violation |
| An obligation can exist without actual provision | `Prototype.obligation_without_provision` | Violation witness; duty/fact separation |
| Changing the desk's correction power leaves access and review fixed | `Prototype.correction_changes_only_procedure_power` | Paired-model comparison |
| A high-impact, harmful decision can satisfy the stronger prototype policy | `Prototype.prototype_satisfiable_nonvacuously` | Explicit non-vacuous satisfaction witness |
| Additional conditional remedy capacity exactly characterizes extension to this stronger policy | `stronger_compliance_iff` | Structural characterization/interface result |

The structural result is not counted as a surprising policy discovery. The small separation example is intuitive; its value is validating a transparent method and checking that the stronger duty is not silently assumed in the weaker theory. Publishable novelty remains unestablished.

## Source and interpretation dependencies

Editorial motivation: MH-015/020/021 for responsibility; MH-017 for appeal; MH-023 for remedy. Interpretations: I01, I02, I03, I04, I05, I10, I11. Case facts are A10-like stipulations, not source assertions. SourceRef data records provenance but cannot certify semantic fidelity.

## Verification boundary

Compilation and axiom output must be checked in verification/build.log and verification/axioms.log. A zero-axiom report refers to the listed theorem declarations, not the philosophical truth of their definitions. Local build success is separate from remote CI success.

## MH-004: public-benefits responsibility

Question: do a responsible agency, identifiable staff, and internal case allocation guarantee an identifiable person responsible for a particular denial?

The model has one agency, two officers, and two decisions. A public contact handles a routine inquiry. Another employee handles a benefit denial. The agency and public contact are identifiable in every comparison. Case assignment is held fixed. Naming the case officer and empowering that officer are independent parameters.

| Result | Declaration | Assumptions and scope |
|---|---|---|
| General staffing plus decision allocation does not identify the actual assignee | `PublicBenefits.staffing_and_allocation_do_not_identify_the_assignee` | Finite witness satisfying InstitutionalReading, HasIdentifiableStaff, and HasDecisionAllocation, with a high-impact denial |
| Allocation coverage and identifiability of assignees suffice for individual answerability | `institution_to_human_with_allocation_and_identification` | Explicit sufficient bridge; not claimed minimal; no staffing-only shortcut |
| Named responsibility does not confer correction authority | `PublicBenefits.named_responsibility_does_not_supply_power` | Named, assigned case officer; no correction power for that denial |
| Same-person correction power suffices for actionable responsibility | `human_to_actionable_with_power` | Named assignment plus an explicit power-coverage premise for the decision |
| Both responsibility interpretations and action capacity can hold together | `PublicBenefits.public_benefits_satisfying_instance` | Non-vacuous witness with a high-impact benefit denial |
| Agency, membership and assignment are unchanged in the comparisons | `PublicBenefits.comparison_preserves_institution_and_assignments` | Definitional equality across the naming/power parameters |

This illustrates a mismatch between existential witnesses: the identifiable staff member and the person assigned to the denial need not be the same employee. A bridge must connect the actual assignee to identification. Action authority then requires its own connection to that person and decision.

Source motivation remains MH-020/021 (the selected responsibility and identifiability candidates). Additional interpretations: I01, I15, I16. Optional bridges: A03, A13, A14. Case facts: A15. Correction authority is an operational modeling choice; no legal entitlement or actual correction is established. The public-benefits case is a bounded responsibility study, not a complete source-compliance assessment.

The existence of these understandable examples does not establish priority or publishable novelty. They support the method and expose explicit missing links for further testing.

## MH-005: timing, record correction, and irreversible physical loss

The state records four distinct facts: physical loss, stop requested, stop delivered, and record corrected. Five available events request a stop, deliver it, execute the hazardous action, correct the administrative record, or review. Every unblocked execution in this hypothetical hazardous instance produces loss. A delivered stop prevents that execution from introducing loss. No available event reverses loss. These are explicit case dynamics, not source theorems or engineering measurements.

Two runs use the same events. Timely run: request, deliver, execute, correct. Late run: request, execute, deliver, correct. Final request, delivery, and record-correction flags are identical; loss occurs only in the late run.

| Finding | Declaration | Scope |
|---|---|---|
| A requested stop is not yet an effective stop | `HighStakes.requested_stop_without_delivery_does_not_prevent_loss` | Explicit finite trace |
| Identical final administrative flags can accompany different physical outcomes | `HighStakes.same_final_control_flags_different_outcomes` | Paired traces differing in delivery/execution order |
| Late control and record correction leave the modeled physical loss unrestored | `HighStakes.late_control_corrects_record_without_restoring` | Trace plus invariant over every finite available continuation |
| Named record-correction authority does not provide physical restoration | `HighStakes.responsibility_and_record_correction_do_not_restore` | Uses the existing responsibility schema with correction scope explicitly restricted to records |
| Loss persists through all modeled finite action sequences | `HighStakes.loss_persists_run` and `HighStakes.loss_not_restorable` | Inductive consequence of A18, not a discovery that real-world harm is always irreversible |
| A loss-free state with an already-delivered stop remains loss-free | `HighStakes.timely_stop_protects_all_continuations` | Conditional on A16/A17 and the bounded event alphabet |
| The preventive configuration and the accountability facts can hold together | `HighStakes.timely_case_satisfying_instance` | Non-vacuous finite witness; does not certify the full source theory |

The central analytical distinction is temporal: observing that a stop eventually arrived does not establish that it arrived before the irreversible action. This is not captured by a static checklist of final flags. No theorem says human intervention is the only possible preventive mechanism, that an actual controller will react promptly, or that all harm is irreversible.

Source motivation: MH-001 (human guidance) and MH-023 (remedy), together with the existing responsibility candidates. Interpretations I14/I17/I18/I19 and assumptions A11/A16/A17/A18/A19 carry the additional operational commitments. The new finite cases do not silently extend the source scope or establish a categorical weapons prohibition.

## MH-006A: appeal and human review across two readings

The existing narrow policy requires appeal for exclusion. The broader policy retains that duty and adds appeal for high impact plus affectedness. Both retain the same responsibility trigger; neither changes remedy-capacity duties. Source candidates MH-017 and MH-022 motivate appeal; MH-013 motivates the impact distinction. Interpretation I03 and optional assumption A04 specify the broader reading. Textual fidelity remains editorial.

| Finding | Declaration | Status and scope |
|---|---|---|
| Exclusion without appeal fails both named policies | `exclusion_without_appeal_fails_both` | T4 baseline consequence of the explicit shared rule; not a flagship discovery |
| Internal review can coexist with closed person access | `AppealReview.internal_review_without_appeal` | C2 under the human-review factual fragment; this excluded witness violates both full appeal policies |
| A high-impact, affected, non-excluded person may lack appeal while narrow compliance holds | `AppealReview.narrow_accepts_broad_rejects` | C2 witness compatible with the narrow fragment and a precise interpretation-sensitive separation |
| Broader compliance adds exactly the provision of appeal to affected high-impact persons | `broad_compliance_iff_narrow_and_affected_appeal` | Structural characterization for the two specified policies, not a universal minimal-premise result |
| Opening person access satisfies both appeal policies | `AppealReview.accessible_appeal_satisfies_both` | Non-vacuous repaired instances, including actual exclusion when parameter is true |
| Opening access preserves review, assignment, and exclusion | `AppealReview.opening_preserves_other_facts` | Paired-model comparison; the altered access relation is explicit |

No new case domain is added: both witnesses are employment-style decisions. The procedure permits internal review while access by the affected person is an independent relation. Actual harm is false, so the high-impact classification is not confused with proven damage.

Do not describe the excluded closed-access witness as satisfying a policy that already requires its appeal. Do not describe narrow compliance as full compliance with the source or with law. Do not describe appeal provision alone as successful remedy or complete meaningful recourse. These distinctions are stated in the public report.


## MH-006B1: regime oversight, decision coverage and intervention capacity

T6 asks whether regime-level independent oversight suffices for actionable independent oversight of an important decision. The answer is no in the declared factual fragment. A second separation shows that independent review coverage alone does not provide intervention capacity. These are jointly one bounded oversight dependency package, not a new domain or a substitute for the remaining fixed countermodels.

New data: OversightSystem stores recognized reviewers, independence, decision remit, review capability and decision-specific intervention capacity. ActionableIndependentOversight requires all five facts for the same reviewer and decision. It is a capacity proxy, not a complete definition of effective oversight. The regime fragment is exactly `∃ r, recognized r ∧ independent r ∧ canReview r`; no requirement is inferred to be fulfilled without actual evidence.

The finite case reuses PublicBenefits.Decision: routineInquiry and benefitDenial. Bool denotes internal staff (false) and an independent board (true). Both can review; the board always covers routine inquiries, and internal staff cover the denial. Board coverage of the denial and its intervention power vary separately. A single fixed Governance record supplies an affected, harmed, excluded person, a high-impact denial, a named assignee, explanation, human review, accessible appeal and accessible correction capacity.

| Finding | Declaration | Named fragment and scope |
|---|---|---|
| The board exists, has nonempty remit and can review, while the denial has internal review but no independent coverage | `Oversight.regime_and_internal_review_do_not_cover_denial` | Regime provision plus both broad-appeal and harm-remedy compliance; also narrow-appeal compliance by refinement. Not full oversight compliance |
| Independent review coverage of every modeled decision can coexist with no intervention power for the denial | `Oversight.coverage_without_intervention_is_insufficient` | Decision-coverage fragment; fails the stronger actionable condition. The same person-facing governance remains fixed |
| Actionable oversight of the denial holds exactly when coverage and intervention power are both supplied | `Oversight.denial_oversight_iff` | Exact characterization of this two-parameter finite family, not universal weakest-premise or policy-necessity claim |
| An actual regime body plus decision-coverage and same-reviewer intervention bridges suffices | `regime_to_decision_with_bridges` | Structural sufficient bridge, not a flagship result; its universal coverage hypotheses are not claimed minimal |
| Both oversight levels and the person-facing fragments can be satisfied together | `Oversight.repaired_case_satisfies_both_levels` | Explicit high-impact, affected-person witness; actionable independent oversight for both decisions |
| Each repair preserves the other oversight provisions | `Oversight.paired_repairs_preserve_other_provisions` | Coverage repair preserves independence/review/power; power repair preserves remit/independence/review; the governance record is identical |

The general regime-to-decision implication therefore needs extra premises. The conclusion survives the narrow/broad appeal choice in this paired family because the fixed governance satisfies even the broad fragment, as well as harm-remedy compliance. We do not infer full source compliance for any combination from that fact.

Provenance: MH-025 (§106), MH-031 (§108), I06/I20, A07/A20/A21. The official source was rechecked on 2026-11-01. It motivates independent and effective oversight without specifying this exact reviewer architecture. Criteria, participation, independence safeguards, competence, resources, actual exercise, timeliness and successful correction are not all modeled. In particular, the source's effective-oversight claim is not equated with our capacity proxy. No theorem infers an oversight duty from opacity alone. The T6 disposition is the checked non-implication and explicit sufficient bridge under these named semantics, with the broader source ambiguity documented.

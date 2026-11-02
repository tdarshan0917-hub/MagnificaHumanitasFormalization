# Prototype results and their limits

Current checkpoint: prototype 0.11. Earlier checked results remain. The planned T10/C1 notice comparison is now implemented. The original remaining suite stays active in EXECUTION_PLAN.md.

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


## MH-006B2: recorded participation, local revision and final control

T7/C6 asks whether contribution and local correction entail final control or a veto. Under our explicit small participation fragment, they do not. This is a bounded non-implication test and a source-ambiguity disposition, not a complete theory of subsidiarity.

ConsultationProcess has four factual operations: accepts, record, revise and decide. The example has one local community, reuses the original public-benefit denial under review, and uses deny/grant recommendations and outcomes (Bool). An institutional override is absent, deny or grant (Option Bool). Both recommendations are accepted and faithfully recorded; the community can amend its own recorded recommendation to either value. That operation does not correct the institution's standards, establish the truth of the recommendation, or guarantee correction of the benefit outcome.

The central rule is `override.getD recorded`: with no override, the recommendation determines the outcome; either explicit override replaces it. The binding-local rule always returns the recorded recommendation. An amendment from deny to grant changes the result when no override is used in both procedures. The contribution therefore has operational influence, not merely a participation label. Yet in the central procedure the institution can select either outcome for every local recommendation, so the community cannot block a grant absolutely or impose every desired outcome.

Operational final control is displayed in full in the theorem statements: for each desired outcome, an accepted proposal makes the final rule return that outcome against every institutional override. It is decision control in this protocol, not legal authority or normative legitimacy. No unconstrained Authority field is introduced.

| Finding | Declaration | Classification and scope |
|---|---|---|
| Both rules accept and record input, allow amendment and demonstrate outcome influence | `Participation.participation_fragment_satisfied` | Satisfaction of the displayed participation fragment for either rule, not the whole source |
| Consultation plus own-record amendment can coexist with no final control and no blocking veto | `Participation.consultation_and_revision_without_final_control` | C6 finite countermodel; institution can select either outcome for every proposal |
| Final control in this pair holds exactly with the binding-local rule | `Participation.final_control_iff_binding` | Exact finite-family characterization, not a universal weakest-premise claim |
| Accepted outcome reachability and a binding record rule suffice for final control | `final_control_from_reachability_and_binding` | General sufficient interface bridge with explicit premises; not a flagship discovery |
| The binding comparison preserves acceptance, recording and amendment while changing the final result under an override | `Participation.binding_comparison_preserves_participation` | Paired rules isolate the extra final-control premise; neither rule is endorsed |
| Either participation rule is compatible with the previously satisfied safeguard fragments | `Participation.joint_case_satisfying_instance` | High-impact denial, affected person, broad appeal/harm-remedy compliance and actionable independent oversight remain present |

The Governance record concerns the original denial and its safeguards, not the later computed review outcome. An amended recommendation may therefore lead to approval on review without contradicting the original exclusion fact. The prior person-facing and oversight facts are identical through the comparison; by refinement, the narrow appeal fragment is also satisfied. This demonstrates compatibility of these limited fragments, not the fidelity of every possible source-interpretation combination.

Provenance: MH-029 (§107), MH-032 (§108), MH-036 (§109), I07/I21 and A22/A23/A24. Own-record amendment and optional binding authority are explicit operational choices. The source does not uniquely prescribe this small protocol, and our result must not be reported as proving that subsidiarity needs no stronger community powers. T7 records that interpretation limit; C6 receives the checked non-implication disposition. C5 (multiple controllers versus local agency) remains unfinished.


## MH-006B3: developer responsibility and later-use assignment

T8 has a bounded checked stage-allocation result and an explicit missing-interpretation disposition for the broader design-duty bundle. The case reuses Governance and the existing policies over Sum Unit PublicBenefits.Decision: one consequential design-review context, the existing benefit denial and the routine inquiry. Bool actors are the developer (false) and deployer (true). The design context and denial are classified as high-impact; the person is affected, excluded and harmed by the denial. These are stipulated case facts A25, not an assertion that every design choice is high-impact.

The developer is assigned to the design context in all comparisons. The deployer's assignment to the denial and an optional additional developer assignment are varied explicitly. Person-accessible review/correction channels, identification, explanation and human review are fixed. Neither an explained flag nor a reviewed flag is treated as satisfaction of the source's full design-ethics requirements.

| Finding | Declaration | Named scope and limit |
|---|---|---|
| Design compliance can coexist with an uncovered downstream responsibility duty | `DeveloperResponsibility.design_compliance_leaves_downstream_gap` | Narrow responsibility/appeal compliance at design; the consequential denial still requires an identifiable assignee and violates that requirement |
| A named deployer supplies coverage of the denial while the developer remains assigned to design | `DeveloperResponsibility.shared_stages_without_universal_developer_assignment` | High-impact design and denial, affected person, and broad appeal/harm-remedy compliance at every context in this finite carrier; developer need not be assigned to the denial under these fragments |
| Additional developer assignment at deployment is also compatible | `DeveloperResponsibility.additional_developer_assignment_is_compatible` | Developer and deployer are both assigned to the denial; same full finite-fragment compliance, no exclusivity or legal-liability finding |
| All finite contexts can satisfy the two existing policy interpretations with either optional assignment | `DeveloperResponsibility.covered_stages_satisfy_existing_fragments` | Non-vacuous satisfaction family; narrow appeal follows by refinement |
| The assignment comparison preserves earlier design assignment and all encoded policy triggers | `DeveloperResponsibility.extra_assignment_preserves_duties_and_design` | Paired cases differ in an actual downstream assignment; existing obligations, appeal and remedy capacity are unchanged |
| The design-only context satisfies its existing checklist | `DeveloperResponsibility.design_fragment_satisfied` | Interface/satisfaction helper, not a flagship discovery |

The uncovered denial is a violation, not evidence that its responsibility duty disappeared. Conversely, satisfying a requirement for some identifiable assignee is not the same formula as requiring a particular developer to answer for every later decision. The paired satisfying cases show that the existing fragments do not settle that additional allocation. No established actor-specific duty is deleted or shown to terminate.

Provenance: MH-020 (§105 lifecycle responsibility), with MH-040 (§111 developer responsibility) motivating the scope question; I01/I02/I09/I22, A25/A26. MH-019 design scrutiny, MH-038 justice assessment and the fuller MH-040 transparency/community-responsibility bundle are not implemented by these formulas. A justified assessment criterion and affected-community specification would be needed to translate those parts. The result therefore must not be described as formalizing all developer ethics or proving absence of downstream liability. T8 records the remaining interpretation explicitly. T2 remains distinct: this module does not model production or delegation to AI.

These new stage models satisfy only the specified responsibility/appeal/remedy fragments. They do not automatically compose with the separate oversight and participation models; no joint full-source consistency claim follows. Exactly three application domains and 30 principal definitions remain.


## MH-006B4: technical control and scoped institutional recognition

T9 is tested with a deliberately bounded mandate proxy: an existing institution recognizes a role and its remit covers the denial. This is not defined to be moral or legal legitimacy. The wider right-to-govern question remains an interpretation gap. MH-039 (§110) motivates the distinction; I13/I23 and A12/A27/A28 carry the exact operational and institutional commitments.

Authority.lean reuses OversightSystem and the existing binding Participation.process instance. Technical control is a quantified capability: for either desired outcome, a proposal makes the review rule return that outcome against every institutional override. Bool roles denote the platform operator and independent board. Both have this modeled technical capability; the board is recognized, independent and covers the denial. The operator's institutional recognition is varied with the technical rule and remit unchanged. Each role's capability is assessed separately; concurrent control and real-system enforcement are not modeled.

| Finding | Declaration | Scope |
|---|---|---|
| The bounded rule supplies actual outcome control | `Authority.actual_control_available` | Operational capability, not a Power=True label; helper, not a research discovery |
| A capable operator can lack a recognized mandate | `Authority.technical_control_without_mandate` | Countermodel to capability implying recognized-plus-covered; original high-impact denial, affected person, broad appeal/harm-remedy compliance and an actionable independent board remain present |
| A capable recognized operator is also compatible | `Authority.granted_mandate_is_compatible` | Non-vacuous satisfying comparison under the same named fragments; avoids claiming every capable role lacks a mandate |
| The operator's proxy mandate depends exactly on recognition in this family | `Authority.operator_mandate_iff_granted` | Finite-family characterization; not a universal legitimacy criterion |
| Changing recognition preserves technical capability, review, remit and independence | `Authority.granting_preserves_technical_facts` | Paired institutional-fact change with identical technical behavior |

The gap is intentionally between technical behavior and independent institutional evidence. Recognition is stipulated, not justified from a moral theory. This elementary specification-independence check is not a flagship discovery, does not prove the truth of the source, and does not solve legitimate government. Its value is keeping the normative question from disappearing into a technical-control flag.

## Correction of the premature checkpoint-0.9 closeout

The assistant's decision to stop formal work and finalize missing models as V1 limitations was premature. The user directed adherence to the original plan. That freeze is withdrawn. The remaining targets are active in EXECUTION_PLAN.md; V1_COMPLETION_MATRIX.md is a working tracker. Technical limitations and novelty cautions remain, but an unattempted target is not thereby a demonstrated ambiguity or failed theorem.

## MH-007: delegation, preserved duties and removed assignment

The existing Governance structure now has a factual producedByAI field. A producer-only handoff is the displayed update `{ g with producedByAI := usesAI }`. No new principal definition or application domain is introduced. For any fixed policy, compliance is unchanged by that update because its safeguard provisions are unchanged. The three existing policy constructors also retain exactly their prior requirement relations when reevaluated after the update. This is conditional producer-independence, not a claim about all possible policies or real handoff processes.

| Plain question | Actual Lean declaration | Checked result |
|---|---|---|
| Does a producer-only update change fixed-checklist compliance? | `producer_change_preserves_fixed_policy` | No; structural interface check for the exact displayed update |
| Do the three current interpretations remove duties after that update? | `producer_change_preserves_existing_requirements` | No; all three requirement relations are unchanged |
| Can an AI-produced decision retain its human officer and meet the rules? | `Delegation.ai_handoff_retains_human_responsibility` | Yes; direct production changes, while a high-impact, excluded and harmed applicant and named human assignee remain; all three policies are satisfied |
| What if the institution additionally removes the officer's assignment? | `Delegation.removing_officer_after_handoff_violates_all_three` | The duty remains, identifiable responsibility is absent and all three policies fail, despite appeal and correction capacity |
| What else differs in that paired comparison? | `Delegation.officer_removal_preserves_other_safeguards` | AI production, impact, exclusion, harm, human review, appeal and correction capacity remain fixed |
| Is there an explicit satisfying case? | `Delegation.retained_assignment_satisfies_all_three` | The AI handoff with the retained officer satisfies all three named checklists |

The applicant/officer/decision/desk come from the existing employment case. The producer fact is direct production, separate from possible AI assistance. The bad comparison changes assignment in addition to production; the proof does not conceal that extra action. The example therefore checks the planned T2 distinction without assuming that a real institution always preserves assignment. No moral-agency exclusion premise is used.

Provenance: MH-015 (§103), MH-020 (§105), I24 and A29/A30, alongside the existing I01/I03/I04 policy interpretations. Structural lemmas are not additional discoveries. The original remaining suite and 2,000–5,000-line target remain active; no completed-project claim is made.


## MH-008: public commitments, disclosure and case answerability

This build addresses the next fixed step, T10/C1, in the existing public-benefits case. Disclosure.notice is a retrievable public artifact: an Option-valued record containing the concrete safeguard commitments, score 47, cutoff 50, the denial computed by `decide (50 ≤ 47)`, and public contacts. The routine inquiry has no denial notice. Disclosure.office reuses the prior public-benefits allocation and appeal/correction channels. Its explained field is derived from the numerical notice, not set to True.

The chosen minimal disclosure fragment is explicit: the notice can be retrieved; its score/cutoff calculation gives the reported result; the service contact is present; every listed contact really is identifiable. The published commitments exactly match the existing harm-remedy policy for the high-impact, excluding and harmful denial. These commitments are normative promises, not assertions that they have already been fulfilled.

The initial notice lists the public contact, who handles inquiries. The actual denial assignee is a different, unidentified employee. The institution itself is identifiable, and internal case allocation exists; the countermodel does not rely on an empty office or a fictitious contact. It satisfies the displayed disclosure fragment but lacks the identified individual assignee required by the chosen policy.

| Question | Actual declaration | Evidence and limit |
|---|---|---|
| Are the published promises substantive? | `Disclosure.commitments_match_existing_policy` | List membership matches every safeguard requirement of the harm-remedy policy for this denial |
| Is disclosure more than a flag? | `Disclosure.truthful_disclosure_available` | Retrievable score/cutoff/computed result and genuinely identified contacts, with exact policy commitments |
| Can that declaration and explanation coexist with no identifiable case owner? | `Disclosure.published_ethics_and_explanation_without_answerability` | C1 under the stated minimal-disclosure fragment and a bounded T10 counterexample; known institution/internal allocation, real affected person and failed harm-remedy compliance |
| What extra connection is sufficient? | `disclosed_assignee_supplies_answerability` | The listed, identified person must belong to the responsible institution and actually be assigned to this decision; sufficient interface bridge, not claimed minimal |
| Does the repaired case meet the current rules? | `Disclosure.named_office_satisfies_three` | Published case officer is the actual assignee; human answerability and all three encoded policy checklists hold |
| Does the same public commitment determine compliance? | `Disclosure.same_commitment_different_compliance` | No: identical promises, score, cutoff and result occur in failing and repaired cases; the repaired notice also names the case officer |
| Which facts stay fixed during repair? | `Disclosure.disclosure_repair_preserves_assignment_and_channels` | Internal assignment, impact, appeal, remedy capacity and policy requirements remain identical |

The remaining audit helper, `Disclosure.unnamed_office_lacks_identifiable_assignee`, ties the new office record to the previously checked actual-assignee separation. The proof uses the same member/assignment/identification semantics; it does not create a new arbitrary Accountability=False field.

Provenance: MH-021 (§105) for identifiable answerability; the §106 context of MH-024 motivates the declaration-versus-effective-provision question. Interpretations I08/I25/I26 and assumptions A31/A32/A33 state the exact information/publication conventions. The legal-framework candidate MH-024 is not implemented as a full legal theory. The threshold calculation is a stipulated decision rule, not an adopted fairness criterion or proof of data quality. This does not complete C4.

C1 does not refute a stronger definition of transparency that already requires publication of the actual assignee. Under that stronger requirement, the initial notice is inadequate. The bounded T10 result concerns the concrete enumerated promises; general user comprehension, complete institutional governance, all ethics declarations and full source compliance are not established. The countermodel intentionally violates the chosen responsibility requirement; it is not presented as fully compliant. C4/C5 and the remaining positive-target review remain active.


## MH-009: explanation and adopted case-level fairness (C4)

Fairness.lean reuses Governance and the existing policies with two finite Bool-indexed applications in the public-benefits domain. False denotes online intake and true assisted intake. Both records have verified eligibility score 60 and cutoff 50. The initial rule subtracts 15 for assisted intake and discloses that deduction; the repaired rule removes it. Arithmetic results are computed by the rule, not stipulated as fair/unfair labels.

The adopted case policy independently declares intake channel irrelevant. Two tests are displayed directly in the theorem statements: all channel-indexed awards are equal, and each award follows the cutoff applied to the verified base score. This exact formula is our local interpretation (I27/A34/A35), motivated by MH-016/019 (§104) and MH-038 (§109), not quoted or uniquely entailed by those passages.

| Checked content | Actual declaration | Dependency and boundary |
|---|---|---|
| A common cutoff on equal relevant scores gives equal results | `equal_scores_and_common_cutoff_give_equal_results` | Explicit rule and equal-score hypotheses; helper, not flagship |
| Both notices reveal the base, deduction, cutoff and truthful result | `Fairness.truthful_rule_explanations` | Actual four-field numerical records, not an unconstrained explained=True flag |
| Both versions meet the three existing safeguard checklists with actual triggers and assignee | `Fairness.existing_safeguards_satisfied` | Checklist does not include the separate fairness test; no full-source compliance claim |
| Same verified score, unequal deductions, computed grant/denial and an excluded affected applicant | `Fairness.explained_channel_penalty_changes_award` | Concrete 60/15/50 example |
| Truthful explanation and safeguard compliance coexist with failure of both adopted tests | `Fairness.explanation_and_safeguards_do_not_ensure_adopted_fairness` | C4 under the stated fragment; not failure of every possible fairness definition |
| Removing the penalty supplies both tests, truthful explanation and existing checklists | `Fairness.penalty_removal_satisfies_both_tests` | Non-vacuous satisfying comparison, using the common-rule bridge |
| Relevant scores, cutoff, affectedness and safeguard channels are unchanged | `Fairness.repair_preserves_inputs_and_safeguard_channels` | Assignment and identification persist; award-dependent exclusion/harm may change |

The practical issue is feature selection: an exact explanation can reveal a rule that violates the independently adopted entitlement policy. This is one bounded separation/repair package, not seven substantive findings. The case does not measure real unfairness, establish all social justice, infer successful correction from a channel, or refute an explanation standard already requiring normative justification. C5 and incomplete positive-target questions remain active in EXECUTION_PLAN.md.

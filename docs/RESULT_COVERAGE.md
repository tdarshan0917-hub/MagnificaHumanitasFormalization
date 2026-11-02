# Result coverage after prototype 0.12

This inventory prevents helper-lemma counts from being confused with completion of the research contract. All findings are about declared models. Textual fidelity and external significance remain separate assessments.

## Original positive targets

| Target | Current disposition |
|---|---|
| T1 Human responsibility | Partial: explicit institutional-to-individual sufficient bridge and a witness showing why general staffing is insufficient |
| T2 Delegation does not terminate responsibility | Producer-only handoff invariance checked for a fixed policy and all three existing interpretations; non-vacuous AI handoff retains the human officer; additionally deleting the assignment violates all three checklists. Transition assumptions are explicit |
| T3 High-impact recourse | Partial: two appeal-trigger readings are compared with an exact policy-extension characterization and separating witness; full meaningful recourse and remedy remain distinct |
| T4 Unappealable exclusion | Proved for the two explicit appeal policies; baseline shared-rule consequence, not a novel moral theorem |
| T5 Responsibility and identifiability | Case-level separation and sufficient conditions implemented; no universal implication without an identification premise |
| T6 Independent oversight | Disposed for the fixed question: regime-level provision does not ensure decision coverage; covered review does not ensure intervention capacity. Paired countermodels, sufficient bridges and a joint satisfying witness are checked. Full effectiveness and a unique source reading are not established |
| T7 Participation/subsidiarity | Bounded non-implication/source-ambiguity disposition: recorded and amendable community input with demonstrated outcome influence does not imply final control or veto; a binding decision rule changes that conclusion. Full subsidiarity and stronger standards-setting powers are not established |
| T8 Developer duties | Bounded stage-allocation result checked: design compliance can coexist with an uncovered denial; distinct developer/deployer assignments or an additional downstream developer assignee satisfy the same fragments. Wider ethical-design/transparency/community duties need a justified interpretation; no legal-liability conclusion |
| T9 Technical power and authority | Bounded technical-control/recognition countermodel and a capable recognized witness checked. Full moral/legal legitimacy needs a justified interpretation; institutional recognition is only a proxy |
| T10 Ethics-only insufficiency | Checked for a concrete published commitment list matching the existing policy: truthful numerical disclosure and promises coexist with missing identifiable assignment and failed compliance; identical promises also occur in the repaired compliant case. No claim covers all ethics statements or the full legal-framework requirements |

## Countermodels and cases

Fixed countermodel C3 (responsibility does not supply remedy capacity) is implemented in the recourse fragment. C2 is implemented for the declared human-review interpretation: an excluded witness violates both appeal policies, while a non-excluded, affected high-impact witness satisfies the narrow policy and lacks appeal. C6 is implemented under I21 with operational contribution, own-record amendment, actual conditional outcome influence and an explicit central override rule; no arbitrary Authority flag is used. C1 is checked under a declared minimal-disclosure fragment using a retrievable, arithmetically consistent notice and genuine named contacts; the actual case assignee remains unidentified in the countermodel. C4 is checked in Fairness.lean for the independently adopted channel-invariance and base-score-cutoff tests: a disclosed channel penalty causes unequal awards for equally eligible applications; removing it supplies both tests. C5 remains unfinished. Public-benefits and high-stakes witnesses remain additional bounded case results, not replacements for those targets.

All three agreed case domains now have initial formal examples: employment-style recourse, public-benefits responsibility, and high-stakes autonomy. They remain bounded slices, not complete compliance assessments.

## Principal-domain definition ceiling

There are 30 principal definitions at this checkpoint, counting structures, inductives, and named domain/policy predicates or operations. Source bookkeeping and concrete example constructors are excluded transparently:

- Model.lean: 8 (Governance, Safeguard, Policy, Provided, CompliantAt, ProcedureSystem, HasAppeal, HasRemedyCapacity).
- Theory.lean: 2 (the two policy interpretations).
- Responsibility.lean: 9 (allocation structure and its eight named conditions).
- PublicBenefits.lean: 2 (Officer and Decision).
- HighStakes.lean: 5 (State, Event, step, run, RestorationPossible).
- AppealReview.lean: 1 (broadAppealPolicy).
- Oversight.lean: 2 (OversightSystem and ActionableIndependentOversight).
- Participation.lean: 1 (ConsultationProcess).

Excluded: source-reference structure/list and concrete witness constructors in Examples, PublicBenefits, HighStakes, AppealReview, Oversight, Participation, DeveloperResponsibility, Authority, Delegation, Disclosure and Fairness. The latter uses two closed finite notice/office constructors; its fairness tests are displayed directly in theorem statements, with no new named domain predicates or general-purpose adjudicator. The exclusion does not authorize new unused ontology. The 30-definition ceiling is reached; SCOPE_AUDIT_0_7.md records the last principal-definition extension; SCOPE_AUDIT_0_8.md through SCOPE_AUDIT_0_12.md record the later reuse audits and the correction of the premature freeze. Any further principal abstraction requires an explicit contract revision; predicates must not be relabeled bookkeeping to avoid the ceiling.

## Next research move

The checkpoint-0.9 freeze was premature and is withdrawn following the user's correction. EXECUTION_PLAN.md restores the original unfinished suite. T2 now has the explicit handoff comparison in Delegation.lean. T10/C1 now have the bounded concrete-notice comparison. C4 now has the bounded channel-penalty comparison. Next are C5 and the incomplete positive-target questions. LEAN_WORK_MAP.md links each actual result to its file and theorem. Missing semantics identify active work; they are not final failures merely because the model is absent. The original 2,000–5,000-line target, 30-definition ceiling, three case domains and final deliverables remain. V1 is unfinished.

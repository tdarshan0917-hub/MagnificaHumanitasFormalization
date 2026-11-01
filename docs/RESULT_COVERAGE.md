# Result coverage after prototype 0.9

This inventory prevents helper-lemma counts from being confused with completion of the research contract. All findings are about declared models. Textual fidelity and external significance remain separate assessments.

## Original positive targets

| Target | Current disposition |
|---|---|
| T1 Human responsibility | Partial: explicit institutional-to-individual sufficient bridge and a witness showing why general staffing is insufficient |
| T2 Delegation does not terminate responsibility | Not implemented: production/delegation semantics still needed; do not count T1 twice |
| T3 High-impact recourse | Partial: two appeal-trigger readings are compared with an exact policy-extension characterization and separating witness; full meaningful recourse and remedy remain distinct |
| T4 Unappealable exclusion | Proved for the two explicit appeal policies; baseline shared-rule consequence, not a novel moral theorem |
| T5 Responsibility and identifiability | Case-level separation and sufficient conditions implemented; no universal implication without an identification premise |
| T6 Independent oversight | Disposed for the fixed question: regime-level provision does not ensure decision coverage; covered review does not ensure intervention capacity. Paired countermodels, sufficient bridges and a joint satisfying witness are checked. Full effectiveness and a unique source reading are not established |
| T7 Participation/subsidiarity | Bounded non-implication/source-ambiguity disposition: recorded and amendable community input with demonstrated outcome influence does not imply final control or veto; a binding decision rule changes that conclusion. Full subsidiarity and stronger standards-setting powers are not established |
| T8 Developer duties | Bounded stage-allocation result checked: design compliance can coexist with an uncovered denial; distinct developer/deployer assignments or an additional downstream developer assignee satisfy the same fragments. Wider ethical-design/transparency/community duties need a justified interpretation; no legal-liability conclusion |
| T9 Technical power and authority | Bounded technical-control/recognition countermodel and a capable recognized witness checked. Full moral/legal legitimacy needs a justified interpretation; institutional recognition is only a proxy |
| T10 Ethics-only insufficiency | Not implemented |

## Countermodels and cases

Fixed countermodel C3 (responsibility does not supply remedy capacity) is implemented in the recourse fragment. C2 is implemented for the declared human-review interpretation: an excluded witness violates both appeal policies, while a non-excluded, affected high-impact witness satisfies the narrow policy and lacks appeal. C6 is implemented under I21 with operational contribution, own-record amendment, actual conditional outcome influence and an explicit central override rule; no arbitrary Authority flag is used. C1/C4/C5 remain unfinished. Public-benefits and high-stakes witnesses remain additional bounded case results, not replacements for those targets.

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

Excluded: source-reference structure/list and concrete witness constructors in Examples, PublicBenefits, HighStakes, AppealReview, Oversight, Participation, DeveloperResponsibility and Authority. The exclusion does not authorize new unused ontology. The 30-definition ceiling is reached; SCOPE_AUDIT_0_7.md records the last principal-definition extension; SCOPE_AUDIT_0_8.md and SCOPE_AUDIT_0_9.md record the subsequent reuse/significance audits. Any further principal abstraction requires an explicit contract revision; predicates must not be relabeled bookkeeping to avoid the ceiling.

## Next research move

MH-006A completed appeal and review. MH-006B1 has now disposed of the fixed oversight implication question with a bounded capacity interpretation. MH-006B2 now tests participation versus final control under a deliberately limited record-amendment interpretation, completing C6 and documenting the broader T7 ambiguity. MH-006B3 checks developer/deployer responsibility by stage and records the missing semantics for the wider design-duty bundle. MH-006B4 checks operational control versus scoped institutional recognition and records the broader legitimacy gap. V1_COMPLETION_MATRIX.md completes the fixed-target disposition audit: delegation, ethics declarations and C1/C4/C5 remain unestablished with their missing semantics documented. The numerical positive-result and fixed-countermodel aspirations are not met. Final writing and reproducible release are next; no further rolling example campaign is planned. Use the existing ontology wherever possible and identify justified missing semantics before adding definitions. The final public report and technical companion paper remain required; passing builds alone do not complete V1. CURRENT_BUILD_GUIDELINES.md records the user's accepted sequencing and endpoint.

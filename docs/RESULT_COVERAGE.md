# Result coverage after prototype 0.4

This inventory prevents helper-lemma counts from being confused with completion of the research contract. All findings are about declared models. Textual fidelity and external significance remain separate assessments.

## Original positive targets

| Target | Current disposition |
|---|---|
| T1 Human responsibility | Partial: explicit institutional-to-individual sufficient bridge and a witness showing why general staffing is insufficient |
| T2 Delegation does not terminate responsibility | Not implemented: production/delegation semantics still needed; do not count T1 twice |
| T3 High-impact recourse | Partial: appeal/remedy policy extension is characterized; universal high-impact person-specific recourse remains an interpretive strengthening |
| T4 Unappealable exclusion | Planned; no dedicated general theorem yet |
| T5 Responsibility and identifiability | Case-level separation and sufficient conditions implemented; no universal implication without an identification premise |
| T6 Independent oversight | Not implemented; human review is not identified with independent oversight |
| T7 Participation/subsidiarity | Not implemented |
| T8 Developer duties | Not implemented |
| T9 Technical power and authority | Not implemented |
| T10 Ethics-only insufficiency | Not implemented |

## Countermodels and cases

Fixed countermodel C3 (responsibility does not supply remedy capacity) is implemented in the recourse fragment. C1/C2/C4/C5/C6 are not yet established by their intended semantics. Public-benefits and high-stakes separation witnesses are additional bounded case results; do not silently relabel them as completion of those targets.

All three agreed case domains now have initial formal examples: employment-style recourse, public-benefits responsibility, and high-stakes autonomy. They remain bounded slices, not complete compliance assessments.

## Principal-domain definition ceiling

There are 26 principal definitions at this checkpoint, counting structures, inductives, and named domain/policy predicates or operations. Source bookkeeping and concrete example constructors are excluded transparently:

- Model.lean: 8 (Governance, Safeguard, Policy, Provided, CompliantAt, ProcedureSystem, HasAppeal, HasRemedyCapacity).
- Theory.lean: 2 (the two policy interpretations).
- Responsibility.lean: 9 (allocation structure and its eight named conditions).
- PublicBenefits.lean: 2 (Officer and Decision).
- HighStakes.lean: 5 (State, Event, step, run, RestorationPossible).

Excluded: source-reference structure/list and the concrete witness constructors in Examples, PublicBenefits, and HighStakes. The exclusion does not authorize new unused ontology. Four principal slots remain before the V1 ceiling; a scope audit is required before introducing additional abstractions.

## Next research move

MH-006 should close and audit the agreed target suite using the existing ontology wherever possible, beginning with a common context connecting the three cases and a careful source-to-code map. It must also identify which planned claims need new justified semantics and which should remain unresolved. The final public report and technical companion paper are still required; passing builds alone do not complete V1.

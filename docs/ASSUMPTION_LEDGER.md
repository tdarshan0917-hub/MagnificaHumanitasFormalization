# Assumption ledger

These entries record modeling assumptions and boundaries, not global Lean axioms. Some are now explicit hypotheses or definitions in the prototype; their conditional consequences are separate from the truth or textual authority of the assumptions.

| ID | Kind | Proposed commitment | Status / dependency |
|---|---|---|---|
| A01 | Modeling | Required and provided safeguards are different relations | Adopt for prototype; I11 |
| A02 | Modeling | Compliance is indexed by a finite declared requirement set and context | Adopt for prototype; I10 |
| A03 | Interpretation | Every responsible institution has an identifiable natural person assigned for this decision | Optional strengthening only; I01; do not infer from ontology |
| A04 | Interpretation | High-impact implies an obligation of individual appeal | Optional strengthening; I02/I03 |
| A05 | Interpretation | An affected person has actual harm | Rejected as a general rule; harm is separate evidence |
| A06 | Interpretation | Every harmed person can be fully restored | Rejected; distinguish remedy capacity, remedy attempt, and restoration |
| A07 | Interpretation | Regime oversight covers every particular decision | Optional coverage bridge; I06 |
| A08 | Interpretation | Consultation entails final authority or veto | Rejected as a general rule; I07 |
| A09 | Source-relative | AI is not the bearer of moral responsibility in the selected reading | Optional source premise; MH-007; not a theorem obtained by disjoint types |
| A10 | Case fact | Selected employment/public-benefit decisions exclude an affected person and affect opportunity | To be stipulated case by case; not an empirical finding about an actual organization |
| A11 | Case fact | A harmful irreversible action has no complete post-event restoration | Hypothetical stress test; specify restoration semantics before use |
| A12 | Modeling | Technical capability and legitimate authority have independent interpretations absent a linking premise | For power-only fragment; I13; check compatibility with any full theory used |
| A13 | Interpretation | People assigned to decisions are individually identifiable | Optional factual bridge, I15; separate from general staffing and case allocation |
| A14 | Interpretation | People assigned to the decision have correction authority for that decision | Optional sufficient power-coverage bridge, I16; not inferred from responsibility |
| A15 | Case fact | A public contact handles a routine inquiry while another officer handles a benefit denial | Hypothetical paired case; no actual agency investigated |
| A16 | Case dynamics | The modeled hazardous execution causes physical loss unless a stop has already been delivered | Hypothetical hazardous instance; not a claim about every AI execution |
| A17 | Case dynamics | The execution guard honors delivered stops, and stop delivery remains effective | Explicit perfect-guard assumption; no real-world reliability claim |
| A18 | Case dynamics | None of the five available actions reverses the physical loss | Models an irreversible component; proofs quantify only over these actions, not unknown recovery technologies |
| A19 | Interpretation | The named officer's correction authority in the high-stakes instance is authority over the decision record | I17; the correctRecord transition implements this limited operation |

## Avoiding circular results

If `Compliant` includes `Provided appeal`, then extracting appeal is a projection. It may support a user interface but is not a substantive theorem. An informative dependency result instead compares theories, identifies a necessary bridge, or supplies paired models differing in one provision while preserving their other stipulated facts.

Every formal theorem must report its explicit theory parameters and named premises. Lean's axiom report alone does not reveal all substantive hypotheses hidden inside structure fields. Both logical-axiom and premise-dependency audits are required.

Explicit finite witnesses now exist for the limited prototype policies and the responsibility-only public-benefits interpretations. They establish satisfaction and separations for those named fragments. No full-theory consistency proof, real-world compliance guarantee, or unique interpretation of the source is claimed.

The high-stakes case adds explicit transition-system witnesses and conditional invariants. Its irreversibility is represented in the transition rules and then proved invariant; it is not derived from the encyclical. Record correction remains possible after loss. No conclusion requires pretending that a possible remedy has already been delivered.

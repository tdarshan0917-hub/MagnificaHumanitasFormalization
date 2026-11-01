# MH-001 — source claim ledger

Date: 2026-11-01. Editorial first pass: 40 candidates, 28 selected for modeling, 12 deferred. No source claim is a Lean axiom yet. Full records are in [claims.csv](../data/claims.csv).

Source: [official English text](https://www.vatican.va/content/leo-xiv/en/encyclicals/documents/20260515-magnifica-humanitas.html), §§97–111, accessed 2026-11-01. Labels are compressed subject locators. Formulas below are our proposed operational readings, not quotations or faithful embeddings already established by proof.

Selection includes core requirements, optional background, contextual positions, an impact-classification candidate, and one metatheoretical question. It does **not** mean 28 independent axioms. Context rows do not authorize extra ontology or theorem targets. Deferred rows remain visible. No candidate is rejected merely for being difficult; none currently needs a permanent reject disposition.

Formalizability means suitability for an explicit model, not objective truth. Ambiguity concerns the operational translation. Every selected interpretation is provisional until the first concrete models make its commitments inspectable. Source-mapping confidence is tentative: medium for direct institutional candidates; low for high-ambiguity operational proxies. All formulas inherit the indicated interpretation entry and must be rechecked before implementation.

Codes: NP = NormativePrinciple; IR = InstitutionalRequirement; AP = AnthropologicalPremise; EC = EmpiricalClaim. No independent TheologicalPremise is needed by the present selection. Interpretive choices are kept in their own ledger; DerivedClaim is reserved for actual results.

| ID | § | Source locator label | Type | Formalizability / ambiguity | Disposition / role | Targets |
|---|---|---|---|---|---|---|
| MH-001 | 97 | Human primacy | NP | High / Medium | Select / core | T1,T2 |
| MH-002 | 97 | Human limits | IR | High / Medium | Select / core | T2 |
| MH-003 | 98 | Rapid obsolescence | EC | Low / Low | Defer / context | — |
| MH-004 | 98 | Limited understanding | EC | Medium / Medium | Defer / context | T6 |
| MH-005 | 98 | Research discernment | NP | Medium / Medium | Select / context | — |
| MH-006 | 99 | Intelligence distinction | AP | Low / High | Defer / context | — |
| MH-007 | 99 | Machine nonresponsibility | AP | High / High | Select / optional | T2 |
| MH-008 | 100 | Reliance risks | EC | Low / Medium | Defer / context | — |
| MH-009 | 100 | Apparent objectivity | EC | Medium / Medium | Defer / context | C4 |
| MH-010 | 100 | Relationship simulation | EC | Low / High | Defer / context | — |
| MH-011 | 101 | Resource burdens | EC | Medium / Medium | Defer / context | — |
| MH-012 | 101 | Sustainability duty | NP | Medium / High | Select / context | — |
| MH-013 | 102 | Consequential domains | EC | High / Medium | Select / trigger | T1,T3,T4 |
| MH-014 | 102 | Bias risks | EC | Medium / Medium | Defer / context | C4 |
| MH-015 | 103 | Unassigned judgment | NP | High / Medium | Select / core | T1,T2 |
| MH-016 | 104 | Embedded priorities | AP | Medium / High | Select / context | T8 |
| MH-017 | 104 | Exclusion appeal | NP | High / Medium | Select / core | T3,T4 |
| MH-018 | 104 | Unequal worth | NP | High / Medium | Select / core | T4 |
| MH-019 | 104 | Design scrutiny | NP | High / Medium | Select / core | T8 |
| MH-020 | 105 | Lifecycle responsibility | IR | High / Medium | Select / core | T1,T2,T5,T8 |
| MH-021 | 105 | Identifiable answerability | IR | High / Medium | Select / core | T1,T5,C1,C3 |
| MH-022 | 105 | Conditional challenge | IR | High / High | Select / core | T3,C2 |
| MH-023 | 105 | Harm remedy | IR | High / High | Select / core | T3,C3 |
| MH-024 | 106 | Legal framework | IR | High / Medium | Select / core | T10 |
| MH-025 | 106 | Independent oversight | IR | High / Medium | Select / core | T6,T10 |
| MH-026 | 106 | Informed users | IR | High / Medium | Select / core | T10 |
| MH-027 | 106 | Political responsibility | IR | High / Medium | Select / core | T10 |
| MH-028 | 107 | Framework debate | IR | High / Medium | Select / core | T7,C6 |
| MH-029 | 107 | Community participation | IR | High / Medium | Select / core | T7,C6 |
| MH-030 | 108 | Power concentration | EC | Medium / Medium | Defer / context | T9 |
| MH-031 | 108 | Effective safeguards | IR | High / Medium | Select / core | T6 |
| MH-032 | 108 | Intermediary contribution | IR | High / Medium | Select / core | T7,C6 |
| MH-033 | 108 | Data regulation | IR | Medium / High | Select / context | — |
| MH-034 | 108 | Shared data | NP | Medium / High | Defer / reserve | — |
| MH-035 | 109 | Access education | NP | Medium / High | Defer / reserve | — |
| MH-036 | 109 | Community correction | IR | High / Medium | Select / core | T7,C5,C6 |
| MH-037 | 109 | Hidden workers | NP | Medium / High | Defer / reserve | — |
| MH-038 | 109 | Justice by design | NP | Medium / High | Select / core | T8,C4 |
| MH-039 | 110 | Power authority | NP | High / Medium | Select / metatheory | T9 |
| MH-040 | 111 | Developer duties | NP | High / Medium | Select / core | T8,C1 |

## Formal candidates and interpretation dependencies

`Required` is a duty, not evidence of actual provision. Variables range over scoped contexts; units such as person, decision, regime, and developer must be typed in the prototype. These deliberately schematic formulas are not compilable Lean.

### MH-001

- Candidate: `Use(c) ⇒ Required(c,humanGuidance)`.
- Interpretation: I01.
- Modeling note: Define guidance behaviorally; it does not yet allocate each outcome.

### MH-002

- Candidate: `Use(c) ⇒ Required(c,humanLimitSetting)`.
- Interpretation: I01.
- Modeling note: Model who can set limits; do not infer operational control from a title.

### MH-003

- Candidate: `TimeSensitive(AIClaim)`.
- Interpretation: I12.
- Modeling note: Do not create an enduring axiom from a time-indexed observation.

### MH-004

- Candidate: `OpaqueAt(s,t)`.
- Interpretation: I08.
- Modeling note: No assumption that every system or decision is opaque.

### MH-005

- Candidate: `Use(c) ⇒ Required(c,researchAndDiscernment)`.
- Interpretation: I10.
- Modeling note: Contextual selection; no implementation predicate until a fixed question needs it.

### MH-006

- Candidate: `HumanIntelligence ≠ ArtificialFunction`.
- Interpretation: I12.
- Modeling note: A name distinction proves no substantive conclusion about minds.

### MH-007

- Candidate: `AI(s) ⇒ ¬MoralBearer(s)`.
- Interpretation: I12.
- Modeling note: Optional source-relative premise, not empirical certification or type-level discovery.

### MH-008

- Candidate: `MayWeakenJudgment(s,u)`.
- Interpretation: I12.
- Modeling note: A risk is neither a universal outcome nor a precise probability.

### MH-009

- Candidate: `ApparentNeutrality(s) ≠ EvidenceOfNeutrality(s)`.
- Interpretation: I08.
- Modeling note: Needs a substantive bias model if used later.

### MH-010

- Candidate: `SimulatedCare(s,u)`.
- Interpretation: I12.
- Modeling note: Outside the fixed governance case suite.

### MH-011

- Candidate: `ResourceUse(s,t)`.
- Interpretation: I10.
- Modeling note: Quantitative empirical verification is outside this prototype.

### MH-012

- Candidate: `Deployment(c) ⇒ Required(c,sustainabilityAssessment)`.
- Interpretation: I10.
- Modeling note: Assessment is a proposed operational proxy, not a complete sustainability obligation.

### MH-013

- Candidate: `EvidenceOfImpact(d) ⇒ HighImpact(d)`.
- Interpretation: I02.
- Modeling note: The evidence classifier is ours; do not classify an entire domain automatically.

### MH-014

- Candidate: `MayReinforceBias(s)`.
- Interpretation: I08.
- Modeling note: Risk language does not license asserting every system is discriminatory.

### MH-015

- Candidate: `Exclusion(c) ⇒ Required(c,assignedResponsibility)`.
- Interpretation: I01.
- Modeling note: This is a normative reconstruction of a critical passage, not a literal conditional.

### MH-016

- Candidate: `Design(s) ⇒ HasValueChoices(s)`.
- Interpretation: I08.
- Modeling note: Keep the conceptual stance distinct from operational bias and injustice.

### MH-017

- Candidate: `Excludes(c,p) ⇒ Required(c,appeal(p))`.
- Interpretation: I03.
- Modeling note: Applicability and what constitutes an available appeal remain explicit.

### MH-018

- Candidate: `Use(c) ⇒ Required(c,noWorthDevaluation)`.
- Interpretation: I03.
- Modeling note: Operational criterion still needed; do not infer all inequalities violate dignity.

### MH-019

- Candidate: `Assessment(c) ⇒ Required(c,designReview)`.
- Interpretation: I09.
- Modeling note: Review evaluates design assumptions; it does not guarantee desirable outcomes.

### MH-020

- Candidate: `Stage(c,k) ⇒ Required(c,allocatedResponsibility(k))`.
- Interpretation: I01.
- Modeling note: Responsibility bearer and allocation coverage require interpretation.

### MH-021

- Candidate: `Decision(c) ⇒ Required(c,identifiableAnswerability)`.
- Interpretation: I05.
- Modeling note: Separate assigned, identifiable, and able to answer.

### MH-022

- Candidate: `ChallengeTrigger(c,p) ⇒ Required(c,challenge(p))`.
- Interpretation: I03.
- Modeling note: Necessity trigger and person-level scope are interpretation parameters.

### MH-023

- Candidate: `Harmed(c,p) ⇒ Required(c,remedy(p))`.
- Interpretation: I04.
- Modeling note: No automatic full restoration; distinguish duty, capacity, and result.

### MH-024

- Candidate: `Regime(g) ⇒ Required(g,legalFramework)`.
- Interpretation: I06.
- Modeling note: Regime-level requirement; legal applicability is not resolved here.

### MH-025

- Candidate: `Regime(g) ⇒ Required(g,independentOversight)`.
- Interpretation: I06.
- Modeling note: Do not silently turn a regime requirement into one reviewer per decision.

### MH-026

- Candidate: `Regime(g) ⇒ Required(g,informedUsers)`.
- Interpretation: I10.
- Modeling note: Operational standard for informedness must be declared.

### MH-027

- Candidate: `Regime(g) ⇒ Required(g,activePublicResponsibility)`.
- Interpretation: I01.
- Modeling note: Institutional function differs from a named individual's liability.

### MH-028

- Candidate: `Regime(g) ⇒ Required(g,contestableEthicalFramework)`.
- Interpretation: I07.
- Modeling note: A debate channel does not by itself confer authority.

### MH-029

- Candidate: `Regime(g) ⇒ Required(g,communityParticipation)`.
- Interpretation: I07.
- Modeling note: Specify a meaningful channel instead of a Boolean label.

### MH-030

- Candidate: `MayAmplifyPower(s)`.
- Interpretation: I13.
- Modeling note: Empirical tendency does not entail universal concentration or illegitimacy.

### MH-031

- Candidate: `PublicRightsUse(c) ⇒ Required(c,criteriaAndEffectiveOversight)`.
- Interpretation: I06.
- Modeling note: Separate criteria, effectiveness, and coverage in implementation.

### MH-032

- Candidate: `PublicRightsUse(c) ⇒ Required(c,communityContribution)`.
- Interpretation: I07.
- Modeling note: Contribution is not a veto; define what action can affect deliberation.

### MH-033

- Candidate: `DataRegime(g) ⇒ Required(g,ownershipRegulation)`.
- Interpretation: I10.
- Modeling note: Do not infer a particular ownership architecture.

### MH-034

- Candidate: `DataRegime(g) ⇒ Required(g,sharedGoodManagement)`.
- Interpretation: I10.
- Modeling note: Several institutional realizations; no fixed theorem currently needs one.

### MH-035

- Candidate: `Required(g,technologyAndEducationAccess)`.
- Interpretation: I10.
- Modeling note: Important candidate for later scope, not a hidden expansion of V1.

### MH-036

- Candidate: `LocalAgency(c) ⇒ Required(c,choiceAndCorrectionCapacity)`.
- Interpretation: I07.
- Modeling note: The LocalAgency trigger is a proposed applicability device; no final veto inferred.

### MH-037

- Candidate: `Required(g,workerRecognition)`.
- Interpretation: I10.
- Modeling note: Concrete labor obligations would require additional operational choices.

### MH-038

- Candidate: `Design(c) ⇒ Required(c,justiceAssessmentAtDesign)`.
- Interpretation: I09.
- Modeling note: Assessment is a proxy; an actual fairness criterion must be separately justified.

### MH-039

- Candidate: `Tpower ⊭ ∀x(Power(x) → Authority(x))`.
- Interpretation: I13.
- Modeling note: This is a model-level research question, not an ordinary source axiom.

### MH-040

- Candidate: `Developer(a,s) ⇒ Required(a,transparentCommunityResponsibleDesign(s))`.
- Interpretation: I09.
- Modeling note: A proposed bundle; separate duties as needed without increasing independent claim counts.

## Selected set

MH-001, MH-002, MH-005, MH-007, MH-012, MH-013, MH-015, MH-016, MH-017, MH-018, MH-019, MH-020, MH-021, MH-022, MH-023, MH-024, MH-025, MH-026, MH-027, MH-028, MH-029, MH-031, MH-032, MH-033, MH-036, MH-038, MH-039, MH-040.

Before any axiom or theory field is added, its code must point to this ledger, the relevant interpretation, and the exact hypothesis scope. Same-source clauses are related components, not independent discoveries.


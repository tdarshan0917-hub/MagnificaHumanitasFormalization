# MH-002 — theorem dependency audit

Status: paper-level candidate analysis, not machine-checked proof. IDs preserve the supplied handoff's target numbering; revisions prevent accidental strengthening or duplicate results.

Prototype 0.3 update: selected T1/T5-related responsibility distinctions are now implemented in Responsibility.lean and PublicBenefits.lean. The table remains a planning audit; it must not be read as claiming all ten targets proved. Generic staffing plus internal allocation is insufficient; explicit case allocation together with identifiability of assignees gives a sufficient bridge. No weakest-premise result is claimed.

Notation: `Required(c,r)` is an encoded duty; `Provided(c,r)` is a factual safeguard. `Satisfies(m,T)` means model m satisfies theory T. These are specification sketches, not compilable Lean declarations.

| Target | Revised research question | Source candidates | Additional commitments | Conservative status | Countermodel or check |
|---|---|---|---|---|---|
| T1 | Under what conditions does a decision require an identifiable human responsibility bearer? | MH-001,002,015,020,021 | I01/I02; A03 if the basic bearer may be an institution | Institutional answerability plausible; individual allocation unresolved | Institutional bearer without designated person; test in institutional variant |
| T2 | Can delegating production to AI remove an independently established human allocation duty? | MH-007,015,020 | A09 is optional; explicit delegation rule and preservation of assignments needed | Rewrite as delegation-invariance; original statement duplicates T1 | Keep allocation invariant while changing producer; compare a variant allowing termination |
| T3 | Which persons must receive appeal or conditional remedy duties? | MH-017,022,023 | I03/I04; A04 for universal high-impact appeal; explicit compliance for actual provision | Exclusion-specific appeal candidate; broad meaningful recourse unresolved | Affected high-impact non-excluded person with no appeal in narrow variant; or no harm so no triggered remedy |
| T4 | Can exclusion without an available appeal satisfy the encoded dignity-related requirement? | MH-017,018 | I03/I10/I11; scope membership and accurate absence evidence | Strong prototype target for scoped non-compliance | Construct satisfying repaired case differing only in appeal |
| T5 | Is assigned responsibility enough to establish identifiable answerability? | MH-020,021 | I01/I05; assignment and identifiability separate | Expected extra requirement; not a universal implication | Assigned but unidentified bearer; compare repaired model |
| T6 | Does a decision receive effective independent oversight from regime-level oversight? | MH-025,031 | I06; A07 coverage and reviewer-independence conditions | Regime rule alone insufficient for decision coverage | Oversight body exists but decision is outside its remit |
| T7 | What local powers follow from participation and correction requirements? | MH-029,032,036 | I07; avoid defining subsidiarity as the desired conclusion | Contribution/correction candidates; veto not established | Participatory process with local correction channel but no final veto |
| T8 | Which duties attach to developer choices and survive institutional deployment? | MH-019,020,038,040 | I09; scope of design choice and who is a developer | Design-duty candidate; sole liability not established | Shared obligations with institution controlling deployment |
| T9 | Does technical capability entail governing authority in a power-only fragment? | MH-039 | I13/A12; model quantification, not object-level `P → ¬(P → Q)` | Non-entailment candidate | Witness m,x with `Satisfies(m,Tpower) ∧ Power(m,x) ∧ ¬Authority(m,x)`; also permit a legitimate capable actor |
| T10 | Which concrete requirements remain unmet by abstract ethics declarations alone? | MH-024,025,026,027 | I10/I11; ethics declaration is independent of provided safeguards | Non-sufficiency candidate, not automatically a theorem about every ethics-labeled system | Same declaration, distinct actual safeguards; name absent requirements explicitly |

Prototype 0.6 update: T6 now has a checked regime-to-decision countermodel, a covered-review/no-intervention countermodel, paired repairs and explicit sufficient bridges in Oversight.lean. This is a disposition under a documented operational capacity proxy, not a proof of full source effectiveness. See TECHNICAL_RESULTS.md and I06/I20.

Prototype 0.7 update: the bounded T7/C6 comparison is checked in Participation.lean. Recorded contribution, own-record amendment and demonstrated outcome influence coexist with a central override rule and no final control. A binding-local comparison isolates an extra premise. Full subsidiarity and legitimate authority remain outside this protocol; the broader source ambiguity is explicit in I21 and TECHNICAL_RESULTS.md.

Prototype 0.8 update: the T8 stage-allocation slice is checked in DeveloperResponsibility.lean using existing Governance/policies. Design compliance does not fill a missing downstream assignee; developer/deployer split and additional shared downstream assignment both satisfy the same fragments. The wider ethical-design bundle needs justified semantics and is not claimed proved. Production/delegation remains a separate T2 gap. See I22 and TECHNICAL_RESULTS.md.

Prototype 0.9 update: T9 has a bounded technical-control/recognition comparison in Authority.lean; full legitimacy is not encoded. The later decision to freeze unfinished work was premature and is withdrawn at 0.10. V1_COMPLETION_MATRIX.md is now an active tracker.

Prototype 0.10 update: T2 now has explicit direct-producer information, a producer-only invariance check and a retained/removed-assignee comparison in Delegation.lean. The original remaining targets are active in EXECUTION_PLAN.md before final writing/release.

## Recommended first result package

Use the appeal/remedy distinction to test an actual dependency:

1. A narrow interpretation produces an appeal duty for an excluding decision.
2. A stronger interpretation adds a prospective remedy-capacity duty under a separately specified trigger.
3. Two finite governance records agree on explanation, oversight, assignment, and appeal, but differ on remedy capacity.
4. Verify which requirement sets each record satisfies. A record can satisfy a fragment while failing the full compliance specification.
5. Construct a third record satisfying every requirement encoded in the prototype, with an actual high-impact decision and affected person.

Any bridge lemma that merely extracts an appeal field is labeled an interface lemma. The research result is the precisely scoped separation and the minimal added requirement that changes the conclusion.

## Gate result

MH-002 has exposed distinct decisions about bearer type, obligation triggers, oversight coverage, and remedy semantics. At the historical MH-002 checkpoint the model remained unbuilt. Later sections and the completion matrix record the implemented evidence and remaining failures. The original gate alone does not establish V1 completion.

Reserve T11–T15 remain empty. Data, sustainability, education, and labor must not expand the theorem suite without a specific analytical question and a corresponding scope decision.

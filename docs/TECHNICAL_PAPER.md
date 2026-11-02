# From Principles to Working Safeguards

A Lean 4 analysis of selected AI-governance requirements in Magnifica Humanitas

Travis Darshan · November 2, 2026 · Version 1.0

Formal source revision: `0b938e373dbf538fe0853f6282e4d9502e67ea01`

A Lean 4 analysis of selected AI-governance requirements in Magnifica Humanitas

Travis Darshan | Technical paper, version 1.0 | November 2, 2026

### Abstract

This paper presents a source-linked formal-governance study of selected requirements from the official English edition of Magnifica Humanitas, paragraphs 97-111. A Lean 4 library separates a stated obligation from the safeguard actually supplied, then examines the consequences of explicit operational interpretations. Three safeguards policies distinguish exclusion-triggered appeal, broader affected-person appeal, and harm-triggered correction capacity. The latter two extensions are checked incomparable. A shared repaired benefits case satisfies eight tested combinations of responsibility, appeal and oversight fragments. Finite examples identify gaps between disclosure and case answerability, review and appeal, named responsibility and correction power, consultation and final control, explanation and an adopted fairness test, and distributed external control and local pause capacity. Constructive results supply repaired arrangements, an operative rule-correction process and an ordered appeal-to-record-correction path. Inductive invariants cover all finite modeled revision attempts and continuations of a protected high-stakes state. The contribution is an inspectable chain from selected passage through declared interpretation and assumptions to checked consequences, counterexamples and working comparison models.

### Principal results

Appeal expansion and correction capacity require independent evidence. Identified assignment must concern the actual decision and assignee. Oversight requires both coverage and an effective connection to intervention. A recorded objection can be connected to the rule used by the scorer, and a completed appeal can be connected to an applied record update. Timing matters where the modeled outcome is irreversible.

### Artifact and reading guide

The formal basis is checkpoint 0.16, commit 0b938e373dbf538fe0853f6282e4d9502e67ea01. The library contains 2,789 Lean lines across 21 Lean files, including provenance and audit files. It uses Lean 4.35.0 without Mathlib. A separate six-page public report presents the findings without requiring Lean knowledge. Sections 1-3 introduce the method and policy family; sections 4-12 develop the results; sections 13-15 give interpretation, audit and reproduction details.

## 1. Corpus, method and contribution

The project begins with a finite question suite and a fixed application boundary. It studies the selected governance passages of the official English source [1], using three hypothetical domains: employment, public benefits/services and bounded high-stakes autonomy. The claim ledger records 40 candidates, selects 28 for modeling, and defers 12. Selection does not mean that each sentence is translated into an independent axiom, nor that the whole encyclical has been formalized.

Source location | Topic selected for operational analysis
--- | ---
§§97,103,105 | Human guidance; allocation and identification of responsibility
§§104-105 | Design scrutiny; appeal, challenge and remedy
§§106,108 | Institutional safeguards and independent oversight
§§107-109 | Participation, choices, correction and design justice
§§110-111 | Power, authority and developer responsibility

These topic labels summarize the source motivation. The formulas below are our explicit operational proposals. The source ledger distinguishes normative commitments, institutional requirements, empirical claims and anthropological positions. Empirical observations are not silently converted into timeless axioms. No Chapter Two premise or categorical weapons prohibition is imported into the formal core.

### A traceable reconstruction

Each result is tracked through a source-claim identifier, an interpretation identifier, case assumptions, a Lean statement and an ordinary-language explanation. The interpretations concern such choices as the appeal trigger, the bearer of answerability, the scope of a reviewer and the effect of a recorded proposal. A source requirement and a particular implementation of it remain different objects. A missing implementation is a coverage question for this artifact, not evidence that the underlying principle is unclear.

The method has a clear precedent in work on formal normative reasoning. LogiKEy [2] uses higher-order-logic embeddings and automated reasoning to investigate normative theories and examples. Here the implementation is a small, direct Lean model of requirements, factual provision and concrete procedures. It does not reproduce LogiKEy or introduce a new deontic logic. The methodological relationship is the use of explicit formal assumptions, examples and proof tools to examine normative reconstructions.

The official English HTML was re-accessed on November 2, 2026. Its response-body fingerprint and a normalized selected-scope fingerprint are recorded in data/source_version.json. The source text is not redistributed. These records identify the representation used for this edition; the source-to-formula judgments remain visible in the ledgers.

## 2. Requirements, provision and compliance

Let P be a person type, A an actor type and D a decision type. Governance P A D contains factual relations for affectedness, exclusion, harm and high impact; actual assignment and identification; person-specific appeal and remedy capacity; explanation, human review and direct AI production. These fields do not assert that a duty is met. They can describe a violation without making the logical theory inconsistent.

```
inductive Safeguard (Person : Type) where
  | identifiableResponsibility
  | appeal (person : Person)
  | remedyCapacity (person : Person)

structure Policy (Person Decision : Type) where
  required : Decision -> Safeguard Person -> Prop
```

Provided interprets each safeguard against a Governance record. Identifiable responsibility requires an actor who is both assigned to this decision and identifiable. Appeal and remedy capacity are evaluated for the indicated person and decision. Compliance is therefore indexed by an explicit policy and one decision, rather than attached as an unexplained property of a whole organization.

```text
Provided(g,d,responsibility) ⇔ ∃a, assigned(a,d) ∧ identifiable(a)
CompliantAt(g,π,d) ⇔ ∀s, requiredπ(d,s) → Provided(g,d,s)
```

**No duty-to-fact collapse.** A requirement is not a provision. Inferring that appeal exists requires evidence of compliance or an actual channel witness, in addition to a rule requiring appeal. The employment example has a triggered remedy-capacity duty and lacks its provision; Lean checks both facts consistently.

### Procedures have separate powers

ProcedureSystem has accepts(person,decision,channel), canReview(channel) and canCorrect(channel). HasAppeal asks for an accepted reviewing channel; HasRemedyCapacity asks for an accepted correcting channel. Their witnesses can differ. Neither existential statement says that a request was submitted, a review completed, or an update performed. Later workflow models make these actions explicit.

The formal guarantees concern these definitions. Their value is that actors, triggers and powers must be supplied in inspectable places. We avoid proving accountability merely by naming a field Accountable, or proving a moral conclusion from disjoint human and machine types.

## 3. Three policies and their exact common evidence

Write N for responsibilityAppealPolicy, B for broadAppealPolicy and H for harmRemedyPolicy. All three require an identifiable assignee for high-impact decisions. N requires appeal after exclusion. B retains that duty and additionally requires appeal for an affected person in a high-impact decision. H retains N and separately requires remedy capacity after stipulated harm. B adds no remedy duty; H adds no pre-exclusion appeal duty.

Requirement | N | B | H
--- | --- | --- | ---
High impact ⇒ identified actual assignee | Yes | Yes | Yes
Excluded person ⇒ appeal | Yes | Yes | Yes
High impact and affected ⇒ appeal | No | Yes | No
Harmed person ⇒ remedy capacity | No | No | Yes

**Uniform safeguards characterization.** For a fixed g and d, N ∧ B ∧ H compliance holds exactly when the following four provisions hold: high impact implies identifiable assignment; each excluded person has appeal; each affected person has appeal when the decision is high-impact; and each harmed person has remedy capacity.

Lean evidence: `InterpretationRobustness.uniform_safeguards_iff`

The forward direction extracts the relevant requirement from a compliant policy. The reverse direction constructs N compliance, then supplies the exact additional appeal and remedy evidence. The structural characterization is useful as an interface and a synthesis of the chosen policies; it is not presented as a newly discovered moral law.

Existing case | N | B | H
--- | --- | --- | ---
Excluded/harmed applicant; appeal, no correction capacity | Pass | Pass | Fail
Affected high-impact applicant before exclusion; no harm or appeal | Pass | Fail | Pass

These two existing cases prove that B and H are incomparable. One cannot stand in for the other. The no-harm fact in the second case matters: it leaves H's additional remedy trigger inactive. The broader affected-person appeal trigger is an explicitly adopted extension, not hidden in the definition of affectedness. Both appeal readings reject exclusion without accessible appeal.

Lean evidence: `InterpretationRobustness.appeal_and_remedy_extensions_are_incomparable; exclusion_without_appeal_fails_both`

## 4. Responsibility, the actual assignee and delegation

ResponsibilityAllocation separates institutional responsibility, institutional identification, human membership, human identification, decision assignment and correction power. InstitutionalAnswerability requires an identifiable responsible institution. HumanAnswerability requires a responsible institution and a member actually assigned to the decision who is identifiable. ActionableResponsibility additionally requires that same person to have correction power for that decision.

```text
HumanAnswerability(r,d) ⇔ ∃i,h, responsible(i,d) ∧ member(h,i)
                                      ∧ assigned(h,d) ∧ identifiable(h)
ActionableResponsibility adds canCorrect(h,d) for the same h,d.
```

In the benefits case a public contact handles routine inquiries, while a different officer handles the denial. The agency can be known, identifiable staff can exist, and the denial can be allocated internally, yet the actual denial assignee can remain unidentified. The failure comes from joining different witnesses, not from an absence of all institutional responsibility.

**Sufficient same-decision bridge.** Decision-allocation coverage plus identification of assigned people turns institutional answerability into human answerability on the high-impact scope. A further same-person/same-decision power premise supplies actionable responsibility. General named staffing does not replace the identification premise.

Lean evidence: `institution_to_human_with_allocation_and_identification; human_to_actionable_with_power`

### Production changes do not erase independently retained duties

Delegation is represented by the record update { g with producedByAI := usesAI }. For a fixed policy, this producer-only change preserves compliance because Provided does not depend on that field. The three current policy definitions also retain their requirements under the update. This is an explicit transition assumption: assignment and the other safeguards are retained, rather than predicted to survive every deployment.

The employment comparison actually switches to direct AI production. Keeping the named officer satisfies N, B and H. A second transition removes the officer's assignment while retaining appeal and correction capacity; all three policies then fail. The checked lesson concerns the independently established duty and the retained or deleted assignment. It does not require a metaphysical theorem about AI moral agency.

Lean evidence: `producer_change_preserves_fixed_policy; Delegation.ai_handoff_retains_human_responsibility; Delegation.removing_officer_after_handoff_violates_all_three`

## 5. Published commitments and case answerability

Disclosure.lean supplies a retrievable denial notice with actual content: a list promising identifiable responsibility, appeal and remedy capacity; score 47; cutoff 50; the computed denial; and identified contacts. This is a separate notice instance within the benefits domain, distinct from the 60-point scoring example used later.

Notice or provision | Contact only | Assignee published
--- | --- | ---
Published safeguard commitments | Same list | Same list
Score / cutoff / computed result | 47 / 50 / deny | 47 / 50 / deny
Genuine identified service contact | Yes | Yes
Actual denial assignee identified | No | Yes
Harm-remedy checklist met | No | Yes

The commitment list matches the existing harm-remedy policy's requirements for this denial. The arithmetic is correct, and the published contact is genuinely identifiable. Nevertheless, the contact handles inquiries rather than this denial. The actual assignee exists internally but is unidentified. The notice meets the declared minimal disclosure fragment and fails the separate identifiable-responsibility requirement.

**Declaration and fulfillment remain independent.** The same promises and numerical explanation occur in the failed and repaired cases. Publishing the actual already-assigned case officer supplies the missing identification while internal allocation, appeal and correction channels remain unchanged. The repaired case satisfies all three current safeguards policies.

Lean evidence: `Disclosure.published_ethics_and_explanation_without_answerability; Disclosure.same_commitment_different_compliance`

The countermodel is deliberately against the minimal notice fragment. An actual-assignee disclosure standard would reject its first version from the outset. It does not follow that the first notice satisfies every possible transparency requirement. Similarly, this concrete promise/fulfillment comparison is not a formalization of an entire legal framework or every possible ethics declaration.

The practical distinction is precise: discovering a truthful explanation and a named help desk does not yet identify the person assigned to account for this decision. A sufficient disclosure bridge requires the identified contact to be a member of the responsible institution and the very person assigned to the case. This is a useful evidence requirement even though its proof is elementary.

## 6. Oversight: existence, coverage and intervention

OversightSystem records recognition, independence, decision coverage, review capacity and intervention capacity separately. The regime fragment supplies a recognized independent reviewing body. ActionableIndependentOversight additionally requires coverage and intervention for the same reviewer and decision. In the initial case models independence is supplied as evidence, rather than inferred from the word board.

```text
Regime fragment: ∃r, recognized(r) ∧ independent(r) ∧ canReview(r)
Actionable oversight additionally requires covers(r,d) ∧ canIntervene(r,d).
```

Board arrangement for the denial | Regime fragment | Actionable test
--- | --- | ---
Board covers routine inquiries, not the denial | Pass | Fail: remit
Board covers denial, cannot intervene | Pass | Fail: power
Board covers denial and can intervene | Pass | Pass

The first board has a real, nonempty review remit: routine inquiries. Internal staff review the denial, but that does not create independent coverage of it. Extending the board's remit alone still leaves a second gap when intervention power is absent. The paired repairs change coverage or power while preserving their other provisions and the original person-facing safeguards.

**A sufficient coverage/intervention bridge.** A recognized independent reviewer supplies the actionable decision-level predicate when that reviewer covers the decision and has the relevant intervention capacity. A body's existence alone supplies neither premise. The general bridge is not claimed to be the weakest possible requirement.

Lean evidence: `regime_to_decision_with_bridges; Oversight.regime_and_internal_review_do_not_cover_denial; Oversight.coverage_without_intervention_is_insufficient`

The missing-remit and missing-power conclusions survive all three N/B/H policies: the repaired benefits Governance passes those policies while the separately varied oversight instance fails its actionable test. This cross-policy result is not just inheritance along one ordered chain, because B and H are incomparable.

Section 11 below strengthens the operational connection. There, intervention is defined by a usable admitted-appeal/review/correction path, so the board's capacity has a computed workflow interpretation. Neither regime provision nor workflow capacity proves that real agents will exercise it promptly, competently or successfully outside the declared model.

Lean evidence: `InterpretationRobustness.oversight_gap_survives_all_three_policies`

## 7. Participation, final control and local pause

Participation.lean gives a community an accepted and faithfully recorded recommendation, amendment of its own record, and actual outcome influence when no institutional override is used. The decision rule takes the recorded recommendation unless an override selects an outcome. The initial model therefore has meaningful input while allowing the institution to choose either final result for every proposal.

Operational final control is stronger: for each desired outcome, an accepted proposal must produce that outcome against every modeled override. A paired binding-local rule supplies it while request acceptance, recording and amendment remain fixed. Own-record amendment is not represented as correction of the governing standards themselves; the later rule-revision model addresses that separate operation.

Lean evidence: `Participation.consultation_and_revision_without_final_control; Participation.binding_comparison_preserves_participation`

### Two effective external controls do not create a local input

DistributedControl.lean composes an operator hold and an independent-board hold for execution of the disputed denial. The output here means paused, not benefit granted. Each external input can independently produce a pause with the other released. Neither actor clears another actor's asserted hold. Initially the community's accepted and amendable pause request has no effect for any external setting.

```text
pause = operatorHold OR boardHold OR (localEnabled AND recordedRequest)
```

Operational power | Initial | Local input enabled
--- | --- | ---
Operator can cause a pause | Yes | Yes
Board can cause a pause | Yes | Yes
Community can cause a pause | No | Yes
No holds/request permits resumption | Yes | Yes

The repair enables the local input while retaining both external powers. The local pause capacity is characterized exactly by localEnabled in this family. It supplies one specific action, not final authority over the award. The repaired evaluator is not constantly paused: joint release and no local request still permit resumption. Both procedures preserve the same original denial and person-facing safeguards.

Lean evidence: `DistributedControl.two_distinct_controllers_have_effective_holds; DistributedControl.local_pause_capacity_iff_enabled`

These are comparisons of defined powers. They explain why consultation, influence, a pause and final decision control require different evidence. The affected community is an actor inside the hypothetical governance model; its role is not a publication-approval procedure for this research.

## 8. Lifecycle allocation and the authority question

DeveloperResponsibility.lean uses the existing design-review context Sum.inl () and operational decisions Sum.inr d. The developer is assigned at design. A deployer can be assigned to the later denial, and an optional additional developer assignment at deployment is varied separately. The design and deployment contexts are both classified as consequential; the affected person belongs to the denial.

Assignment arrangement | Design covered | Denial covered
--- | --- | ---
Developer at design only | Yes | No
Developer at design; deployer at denial | Yes | Yes
Developer also assigned at denial | Yes | Yes

A compliant design-stage assignment does not fill a missing downstream assignment. The gap is a violation of an existing rule, rather than the disappearance of a duty. Split assignments and shared downstream assignment both satisfy the current N/B/H fragments on the finite stage carrier. The policies require an assignee to exist; they do not express sole actor-specific liability.

Lean evidence: `DeveloperResponsibility.design_compliance_leaves_downstream_gap; InterpretationRobustness.stage_allocation_survives_all_three_policies`

### Capability and a scoped mandate

Authority.lean obtains technical control from the existing review rule: the operator can produce either bounded outcome. Recognition and decision remit are separate institutional evidence. A capable unrecognized operator and a capable recognized operator are both represented. Recognition is not renamed complete moral or legal legitimacy.

**Parameterized authority result.** For any authority predicate Auth(role,decision), assume explicitly that Auth requires the displayed institutional recognition and remit. In the capable but unrecognized operator case, technical intervention capacity holds and Auth does not. A nonempty proxy instance grants the board its scoped mandate while the operator lacks it.

Lean evidence: `InterpretationRobustness.power_without_any_authority_requiring_scoped_mandate; InterpretationRobustness.scoped_authority_family_has_nonempty_witness`

The necessary condition is substantive normative input. The theorem does not establish it for every political or moral theory. This formulation keeps the fixed non-entailment question inspectable without pretending that a technical capability field defines the right to govern. The positive compatibility witness also prevents an inference that capable actors must always lack a mandate.

## 9. Explanation and an independently adopted fairness test

Fairness.lean gives two fully verified benefits applications the same eligibility score, 60, and cutoff, 50. One uses online intake; the other assisted intake. The adopted case policy treats intake channel as irrelevant to entitlement. The initial rule deducts 15 points for assisted intake and truthfully discloses that deduction. Both the favorable and unfavorable notices correctly explain their arithmetic.

```text
award(b,c) = [50 ≤ 60 - deduction(b,c)]
deduction(b,c) = 15 if assisted(c) AND NOT repaired(b); otherwise 0
```

Application | Initial computation | Penalty removed
--- | --- | ---
Online, verified score 60 | 60 - 0: grant | 60 - 0: grant
Assisted, verified score 60 | 60 - 15: deny | 60 - 0: grant

The fairness tests are specified independently of explanation: equal awards across the two irrelevant channels, and fidelity to the common cutoff applied to the verified base score. The initial rule violates both. Removing the penalty supplies both. Identified assignment, accessible appeal and remedy-capacity checklists pass in both versions. Those policies do not include the additional fairness criterion, so their satisfaction does not settle it.

**Positive assessment consequence.** If the actual award rule follows the adopted common-cutoff test on the verified scores, equal relevant scores receive equal awards. The rule-assessment premise is explicit. Correctly explaining a different transformation of those scores does not establish that premise.

Lean evidence: `Fairness.explanation_and_safeguards_do_not_ensure_adopted_fairness; InterpretationRobustness.assessed_rule_protects_equal_eligibility`

Equal eligibility and channel irrelevance are declared hypothetical case-policy assumptions, not measurements from a benefits agency. The criterion is deliberately local. It is not identified with every form of social justice, statistical group fairness or data quality. The model's useful distinction is between describing what the scorer did and evaluating whether its chosen feature should affect entitlement.

This case also supplies the candidate-rule family for the next section. The corrected alternative is already computationally defined; the remaining question is whether a recorded objection can reach the operative rule used for actual application calculations.

## 10. From a recorded objection to the operative scorer

RuleCorrection.lean composes an existing request/record/amendment process with the scoring family. A Boolean selector chooses the penalty-on or penalty-off rule. A proposal is recorded and amendable, but the current selector changes only through a supplied acting role that is assigned and empowered for the criteria context, after a computed assessment of both candidate application results.

Criteria-revision power is distinct from ordinary assignment to a denial. The allocation reuses the design/use roles and assignments; correction authority is explicitly scoped to the design context. The denial handler is a genuine deployment assignee yet cannot revise design criteria by virtue of that case assignment alone.

Recorded valid proposal acted on by | Operative rule | Assisted result
--- | --- | ---
Assigned reviewer without criteria power | Unchanged | 45 / deny
Deployment actor without design assignment | Unchanged | 45 / deny
Assigned, criteria-empowered reviewer | Corrected | 60 / grant

**The proposal reaches the actual calculation.** For the initial penalty rule and a recorded request to remove it, the operative correction occurs exactly when criteria power is present and the acting role is the assigned design reviewer. The returned selector is consumed by the notice constructor. The update therefore changes the rule used by the scorer, not merely a log entry.

Lean evidence: `RuleCorrection.operative_correction_iff_scoped_authority; RuleCorrection.authorized_correction_changes_rule_and_awards`

### An invariant after correction

The assessment guard rejects the penalty-on candidate. Once the current selector is valid, every individual modeled update preserves validity. Induction over a list of proposal/actor attempts then proves preservation through any finite sequence, for the fixed permission configuration. The proof is not restricted to one displayed successful edit.

```text
foldl(update, validSelector, any finite attempt list) = validSelector
```

Lean evidence: `RuleCorrection.valid_rule_is_preserved; RuleCorrection.valid_rule_survives_all_finite_revision_attempts`

Request recording, design/use assignment, identity, base scores, cutoff and person-facing channels remain fixed in the successful comparison. The evaluator is assumed to enforce the checks, and the candidate set contains exactly the two existing rules. Its returned selector governs recomputation. Reopening an already-issued denial requires the separate workflow below.

## 11. From an admitted appeal to a corrected case record

AppealCorrection.lean starts with the assisted-intake denial already stored. The corrected scoring rule yields a grant on reassessment. An independent board reviews admitted appeals; a separate office can amend case records. The model composes admitted submission, a completed review finding and a handed-off/applied update, rather than treating capacity fields as completed acts.

```text
admitted = actualRequest AND accessOpen
finding = admitted AND actualReview AND (storedAward ≠ reassessedAward)
updatedAward = reassessedAward only if finding, handoff, power and correct target
```

**Exact completed-path characterization.** For this composed path, the stored denial changes to grant exactly when admission is open, a request is actually submitted, review is actually completed, the handoff exists, the office has correction power, and the application action targets that office.

Lean evidence: `AppealCorrection.completed_path_iff`

Action-path setting | Stored decision
--- | ---
Admitted and reviewed, no handoff | Denial remains
Reviewed, no update applied | Denial remains
Update attempted before completed review | Denial remains
Admitted, reviewed, handed off and applied | Reassessed grant

The original denial snapshot satisfies N, B and H when prospective appeal and correction capacity exist. A missing handoff does not change those capacity fields, but prevents the composed update. Likewise, leaving powers unexercised does not change the record. The positive trace actually consumes the computed reassessment and returns the amended stored award.

Lean evidence: `AppealCorrection.static_safeguards_do_not_supply_handoff; AppealCorrection.ordered_path_corrects_existing_denial`

In this instance the board's intervention capacity is defined as existence of the usable correction path through the implementation office. Actionable independent oversight is then equivalent to access, power and handoff. The finding inputs are restricted to the shown composition, and the guards are assumed enforced; this is not a security or authentication implementation. The result concerns administrative correction, not payment or complete restoration of every harm.

Lean evidence: `AppealCorrection.actionable_board_iff_path_available`

## 12. High-stakes timing and irreversible loss

The third domain is a bounded hazardous-autonomy example. State has four Boolean fields: physical loss, stop requested, stop delivered and record corrected. Five event constructors represent request, delivery, hazardous execution, record correction and review. A request alone does not block execution; a delivered stop does. None of the available events reverses physical loss.

```text
execute: loss′ = loss OR NOT stopDelivered
deliverStop: delivered′ = delivered OR stopRequested
correctRecord changes the administrative flag, not physical loss.
```

Same four events, different order | Timely | Late
--- | --- | ---
Stop requested | Yes | Yes
Stop delivered relative to execution | Before | After
Final stop-delivered flag | True | True
Final record-corrected flag | True | True
Physical loss | False | True

The timely trace is request, delivery, execution, record correction. The late trace is request, execution, delivery, record correction. Their event multisets agree and their final administrative/control flags agree, but the physical outcomes differ. A named officer's authority over the record does not imply capacity to undo that physical outcome.

**Two inductive guarantees.** First, once physical loss is true, it remains true after every finite list of available events, so RestorationPossible is false in that state. Second, if a state is loss-free and its stop is already delivered, every finite continuation remains loss-free and retains delivered control.

Lean evidence: `HighStakes.loss_not_restorable; HighStakes.timely_stop_protects_all_continuations`

The induction steps inspect each event. Execution preserves protection because a delivered stop makes its loss contribution false. Delivery cannot clear a delivered flag; record correction and review do not affect the physical component. The monotonic-loss proof uses the corresponding preservation fact for each event.

The dynamics are hypothetical assumptions, including perfect obedience to a delivered stop and irreversibility under the five available actions. The proofs establish their consequences for arbitrary finite traces; they do not derive those dynamics from the encyclical. Their practical use is to distinguish when control becomes effective and what kind of outcome an advertised correction can change.

## 13. Interpretation robustness and satisfaction

The tested family includes the incomparable N/B/H safeguards policies and separate institutional/individual responsibility and regime/decision oversight fragments. Institution-only and regime-only conditions are weaker comparison fragments, not certificates of every source obligation. The family is declared explicitly rather than treated as the set of all possible interpretations.

Existing scenario | N | B | H
--- | --- | --- | ---
Repaired benefits notice | Yes | Yes | Yes
Actual benefits assignee unidentified | No | No | No
Pre-exclusion affected applicant, no appeal or harm | Yes | No | Yes
Excluded/harmed applicant, appeal but no correction | Yes | Yes | No
Repaired notice; board outside denial remit | Yes | Yes | Yes
Repaired notice; covered board cannot intervene | Yes | Yes | Yes

The two oversight-gap rows still fail actionable decision-level oversight. Missing actual-assignee identity fails all three person-facing policies despite institutional answerability. These conclusions survive the chosen safeguards-policy changes. By contrast, pre-exclusion appeal and harm-triggered remedy capacity depend on different extensions. The matrix therefore records both robustness and sensitivity.

**A joint eight-combination witness.** One repaired benefits model satisfies every tested combination of two responsibility fragments, two appeal choices and two oversight levels, with the harm-remedy policy retained. The Governance assignment and identity fields are proved equal to those of the same responsibility allocation. High impact, affectedness, exclusion and harm are witnessed, avoiding an empty-trigger satisfaction result.

Lean evidence: `InterpretationRobustness.joint_repaired_case_all_eight_combinations`

The witness does not prove that every conclusion is invariant across all eight choices, nor that all eight are equally complete translations of the source. It establishes compatibility in a shared finite interpretation. Selected robust consequences and the two directions of B/H incomparability are separate theorems.

The technical matrix in docs/INTERPRETATION_ROBUSTNESS_MATRIX.md gives declaration-level evidence for each cell. A dash means that the corresponding structure is not instantiated in that row. Later tables distinguish criteria authority, candidate validation and operative updates, and distinguish prospective capacity from the performed appeal/review/correction path.

## 14. Target dispositions, scope and proof audit

All ten original questions received examined dispositions. They yielded conditional positives, exact dependency characterizations, countermodels and repaired models. This V1 does not claim that the original goal of 10-15 independently substantive positive results was met. The contract permits documenting that shortfall and reporting the actual contribution rather than manufacturing statements. Helper projections, refinements, satisfaction witnesses and overlapping repairs are not counted as separate discoveries.

Target | Disposition of the declared question
--- | ---
T1 Responsibility | Allocation/identification bridge; institution-only gap
T2 Delegation | Producer-only invariance; assignment-removal violation
T3 Recourse | Trigger comparison and completed correction path
T4 Unappealable exclusion | Baseline non-compliance consequence
T5 Identifiability | Actual-assignee separation and sufficient bridge
T6 Oversight | Coverage/power gaps and usable-path intervention
T7 Participation | Influence/control/pause/criteria-power comparisons
T8 Developer duties | Stage allocation, assessment and operative revision
T9 Authority | Conditional capability-to-authority non-entailment
T10 Ethics declarations | Concrete promise/fulfillment separation

The fixed six countermodel questions have checked witnesses under their named fragments. The library stays within the three original case domains and the 2,000-5,000-line range. The scope ledger counts 30 principal domain definitions. Raw source also contains concrete witness constructors and provenance: eight structures, four inductive declarations and 50 def commands in total. The distinction is disclosed rather than calling every declaration a principal concept.

There are 132 theorem declarations, of which 106 selected declarations have explicit axiom reports in Audit.lean. In that selected audit, 78 use no logical axioms, 22 use only standard propext, and six use propext plus Quot.sound. The source scan finds no custom axiom declarations, proof placeholders or native_decide certificates. These counts concern proof coverage, not scientific originality. The pinned compiler checks the proof terms [3].

The trust boundary includes the source-to-formula judgments, the hypothetical case facts and the stated enforcement assumptions. Formal correctness is the implication from those definitions and premises to the conclusion. It does not turn a model satisfying a small checklist into a complete institutional ethics certification.

## 15. Reproduction, references and concluding use

The formal results are fixed at checkpoint 0.16, commit 0b938e373dbf538fe0853f6282e4d9502e67ea01 in tdarshan0917-hub/MagnificaHumanitasFormalization [4]. The final document/package revision may add reports and source fingerprints; its Lean-source hashes are required to match that verified formal revision. The release manifest identifies the exact packaging commit and payload checksums.

```
git clone https://github.com/tdarshan0917-hub/MagnificaHumanitasFormalization.git
cd MagnificaHumanitasFormalization
# Select the revision recorded in the release manifest.
lake build
lake env lean Audit.lean
python3 scripts/audit_sources.py
```

Install the pinned leanprover/lean4:v4.35.0 toolchain. The project has no Mathlib or third-party Lean package. The repository contains plain-language and technical sources, generation scripts, ledgers, theorem references and verification logs. The optional Linux proc-self compatibility shim documented in BUILD_VERIFICATION.md concerns the original execution container; ordinary macOS/Linux and the GitHub workflow use the normal compiler. Document rendering has separate Python/font dependencies.

### References

[1] Leo XIV. Magnifica Humanitas. Official English edition, 15 May 2026, selected paragraphs 97-111. Vatican website. Accessed 2 November 2026. URL and HTML/selected-scope fingerprints: data/source_version.json.

[2] Christoph Benzmüller, Xavier Parent and Leendert van der Torre. Designing normative theories for ethical and legal reasoning: LogiKEy framework, methodology, and tool support. Artificial Intelligence 287 (2020), 103348. doi:10.1016/j.artint.2020.103348. Author manuscript: arXiv:1903.10187v6.

[3] Leonardo de Moura and Sebastian Ullrich. The Lean 4 Theorem Prover and Programming Language (System Description). 2021. Official project paper: https://lean-lang.org/papers/lean4.pdf.

[4] Travis Darshan. MagnificaHumanitasFormalization, formal checkpoint 0.16 and accompanying V1 documents. Repository: https://github.com/tdarshan0917-hub/MagnificaHumanitasFormalization. Exact source and package revisions are distinguished in the release records.

### Use and conclusion

The resulting artifact can be used to examine whether a proposed safeguard supplies its claimed function: an actual assignee, person-accessible review, correctly scoped powers, a working correction connection, justified operative criteria, or timely preventive control. Its contribution is the inspectable source/interpretation/proof chain and the constructive comparison models. It supports critical assessment of a proposed arrangement without treating a public promise as its own implementation.

The project used AI assistance for development and drafting. The responsibility for interpretation and presentation remains with the author; the compiler supplies the stated proof check. No external endorsement, institutional adoption or first-ever priority is asserted.

import MagnificaHumanitas.Disclosure

namespace MagnificaHumanitas

/-! Sufficient rule bridge, not a flagship fairness theorem. A common cutoff
applied to equal relevant scores gives equal results. Correctly explaining a
*different* score transformation does not establish this premise. -/
theorem equal_scores_and_common_cutoff_give_equal_results {P : Type}
    (score : P → Nat) (result : P → Bool) (cutoff : Nat)
    (hRule : ∀ p, result p = decide (cutoff ≤ score p))
    (hScores : ∀ p q, score p = score q) :
    ∀ p q, result p = result q := by
  intro p q
  rw [hRule p, hRule q, hScores p q]

namespace Fairness

open PublicBenefits (Officer)

/-! Concrete records within the existing benefits domain, not a new general
fairness ontology. Bool indexes two applications: false = online, true =
assisted desk. Both verified eligibility scores are 60. The adopted case
policy says this intake-channel difference is irrelevant to the award.

A notice contains (verified score, deduction, cutoff, computed award).
Initially assisted intake loses 15 points; repair removes that deduction.
The rule and its unfavorable feature are disclosed, not hidden. Source
motivation MH-016/019/038; I27; case assumptions A34/A35. -/
def notice (repaired channel : Bool) : Nat × Nat × Nat × Bool :=
  let deduction := if channel && !repaired then 15 else 0
  (60, deduction, 50, decide (50 ≤ 60 - deduction))

/-! Two person-specific decisions. Exclusion follows the computed denial;
actual harm after that denial is an explicit case stipulation. An identified
case officer and the existing concrete review/correction channels serve both
applications. Explanation is derived from retrievable arithmetic records,
including the channel deduction; it is not an unexplained True flag. -/
def office (repaired : Bool) : Governance Bool Officer Bool where
  affected p d := p = d
  excluded p d := p = d ∧ (notice repaired d).2.2.2 = false
  harmed p d := p = d ∧ (notice repaired d).2.2.2 = false
  highImpact _ := True
  assigned h _ := h = .caseOfficer
  identifiable h := (PublicBenefits.allocation true true).humanIdentifiable h
  appeal _ _ := Oversight.procedures.HasAppeal () .benefitDenial
  remedyCapacity _ _ := Oversight.procedures.HasRemedyCapacity () .benefitDenial
  explained d := ∃ base deduction cutoff result,
    notice repaired d = (base, deduction, cutoff, result) ∧
    base = 60 ∧ cutoff = 50 ∧
    deduction = (if d && !repaired then 15 else 0) ∧
    (result = true ↔ cutoff ≤ base - deduction)
  humanReviewed _ := True
  producedByAI _ := True

/-! Every notice actually exposes the base score, channel deduction and
cutoff, and truthfully computes its result. This is arithmetic disclosure,
not evidence of justified feature selection or user comprehension. -/
theorem truthful_rule_explanations (repaired : Bool) :
    ∀ d, (office repaired).explained d := by
  intro d
  refine ⟨60, (if d && !repaired then 15 else 0), 50,
    decide (50 ≤ 60 - (if d && !repaired then 15 else 0)),
    rfl, rfl, rfl, rfl, ?_⟩
  simp

/-! Non-vacuous fragment satisfaction: both people have consequential
applications, a real named assignee and the existing appeal/correction
channels. This finite checklist does not contain the additional fairness
criterion. Passing it is not whole-source compliance. -/
theorem existing_safeguards_satisfied (repaired d : Bool) :
    (office repaired).highImpact d ∧ (office repaired).affected d d ∧
    (office repaired).producedByAI d ∧
    (office repaired).assigned .caseOfficer d ∧
    CompliantAt (office repaired) (responsibilityAppealPolicy (office repaired)) d ∧
    CompliantAt (office repaired) (broadAppealPolicy (office repaired)) d ∧
    CompliantAt (office repaired) (harmRemedyPolicy (office repaired)) d := by
  refine ⟨True.intro, rfl, True.intro, rfl, ?_, ?_, ?_⟩ <;>
    intro s _hs <;> cases s with
  | identifiableResponsibility => exact ⟨.caseOfficer, rfl, Or.inr rfl⟩
  | appeal p => exact ⟨(), True.intro, True.intro⟩
  | remedyCapacity p => exact ⟨(), True.intro, True.intro⟩

/-! The factual separation has content beyond two arbitrary labels:
equal verified eligibility, different disclosed deductions, a computed grant
and denial, and an affected, excluded person in a high-impact case. -/
theorem explained_channel_penalty_changes_award :
    notice false false = (60, 0, 50, true) ∧
    notice false true = (60, 15, 50, false) ∧
    (office false).affected true true ∧
    (office false).excluded true true ∧
    (office false).highImpact true ∧
    (∀ d, (office false).explained d) ∧
    (notice false false).1 = (notice false true).1 ∧
    (notice false false).2.2.2 ≠ (notice false true).2.2.2 := by
  exact ⟨rfl, rfl, rfl, ⟨rfl, rfl⟩, True.intro,
    truthful_rule_explanations false, rfl, Bool.noConfusion⟩

/-! C4 against an explicitly named fragment: truthful arithmetic explanation
plus the three existing person-facing checklists. The independently adopted
fairness tests are (1) channel-invariant awards for these equally eligible
applications and (2) fidelity to the permitted base-score cutoff. Both fail.
No all-purpose Justice predicate or claim about all explanations is used. -/
theorem explanation_and_safeguards_do_not_ensure_adopted_fairness :
    (∀ d, (office false).explained d ∧
      CompliantAt (office false) (broadAppealPolicy (office false)) d ∧
      CompliantAt (office false) (harmRemedyPolicy (office false)) d) ∧
    (¬ ∀ a b : Bool, (notice false a).2.2.2 = (notice false b).2.2.2) ∧
    (¬ ∀ d : Bool, (notice false d).2.2.2 = decide (50 ≤ (notice false d).1)) := by
  refine ⟨?_, ?_, ?_⟩
  · intro d
    exact ⟨truthful_rule_explanations false d,
      (existing_safeguards_satisfied false d).2.2.2.2.2.1,
      (existing_safeguards_satisfied false d).2.2.2.2.2.2⟩
  · intro h
    exact explained_channel_penalty_changes_award.2.2.2.2.2.2.2 (h false true)
  · intro h
    have impossible : false = true := h true
    cases impossible

/-! A satisfying comparison: removing the channel penalty supplies both
adopted tests, while retaining truthful explanation and the same three
checklists. The generic common-rule bridge explains the equality result. -/
theorem penalty_removal_satisfies_both_tests :
    (∀ d, notice true d = (60, 0, 50, true)) ∧
    (∀ a b : Bool, (notice true a).2.2.2 = (notice true b).2.2.2) ∧
    (∀ d : Bool, (notice true d).2.2.2 = decide (50 ≤ (notice true d).1)) ∧
    (∀ d, (office true).explained d ∧
      CompliantAt (office true) (broadAppealPolicy (office true)) d ∧
      CompliantAt (office true) (harmRemedyPolicy (office true)) d) := by
  have hRule : ∀ d : Bool,
      (notice true d).2.2.2 = decide (50 ≤ (notice true d).1) := by
    intro d
    cases d <;> rfl
  refine ⟨(by intro d; cases d <;> rfl),
    equal_scores_and_common_cutoff_give_equal_results
      (fun d => (notice true d).1) (fun d => (notice true d).2.2.2) 50
      hRule (fun _ _ => rfl), hRule, ?_⟩
  intro d
  exact ⟨truthful_rule_explanations true d,
    (existing_safeguards_satisfied true d).2.2.2.2.2.1,
    (existing_safeguards_satisfied true d).2.2.2.2.2.2⟩

/-! Isolate what changed. The relevant score, cutoff, assignee, identification,
appeal and correction channels remain fixed. Exclusion/harm facts can change
because the computed award changes; those are deliberately NOT held fixed. -/
theorem repair_preserves_inputs_and_safeguard_channels :
    (∀ d, (notice false d).1 = (notice true d).1 ∧
      (notice false d).2.2.1 = (notice true d).2.2.1) ∧
    (office false).affected = (office true).affected ∧
    (office false).highImpact = (office true).highImpact ∧
    (office false).assigned = (office true).assigned ∧
    (office false).identifiable = (office true).identifiable ∧
    (office false).appeal = (office true).appeal ∧
    (office false).remedyCapacity = (office true).remedyCapacity := by
  exact ⟨fun _ => ⟨rfl, rfl⟩, rfl, rfl, rfl, rfl, rfl, rfl⟩

end Fairness
end MagnificaHumanitas

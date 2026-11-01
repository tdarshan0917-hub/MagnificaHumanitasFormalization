import MagnificaHumanitas.PublicBenefits
import MagnificaHumanitas.AppealReview

namespace MagnificaHumanitas

/-! Factual oversight data, not an obligation or a claim of compliance.
Source motivation: MH-025/031, I06. Independence is supplied as evidence;
it is not inferred from a reviewer's title or from human involvement.
`covers` is remit, and `canIntervene` is decision-specific action capacity.
Neither records completed review, successful correction, or full effectiveness. -/
structure OversightSystem (Reviewer Decision : Type) where
  recognized : Reviewer → Prop
  independent : Reviewer → Prop
  covers : Reviewer → Decision → Prop
  canReview : Reviewer → Prop
  canIntervene : Reviewer → Decision → Prop

variable {R D : Type}

def ActionableIndependentOversight (o : OversightSystem R D) (d : D) : Prop :=
  ∃ r, o.recognized r ∧ o.independent r ∧ o.covers r d ∧
    o.canReview r ∧ o.canIntervene r d

/-! Sufficient bridge from an actual recognized independent review body.
A07 supplies decision coverage; A20 supplies intervention capacity for the
same reviewer and decision. These universal bridges are not claimed minimal.
This interface theorem is not a separate flagship result. -/
theorem regime_to_decision_with_bridges (o : OversightSystem R D) (d : D)
    (hRegime : ∃ r, o.recognized r ∧ o.independent r ∧ o.canReview r)
    (hCoverage : ∀ r, o.recognized r → o.independent r → o.canReview r →
      o.covers r d)
    (hIntervention : ∀ r, o.recognized r → o.independent r → o.covers r d →
      o.canReview r → o.canIntervene r d) :
    ActionableIndependentOversight o d := by
  obtain ⟨r, hr, hi, hv⟩ := hRegime
  have hc := hCoverage r hr hi hv
  exact ⟨r, hr, hi, hc, hv, hIntervention r hr hi hc hv⟩

namespace Oversight

open PublicBenefits (Decision)

/-! Existing public-benefits domain, two reviewer roles: false is internal
staff; true is an independent board. Both can review. The board always covers
routine inquiries, so its remit is nonempty even in the gap case. Internal
staff cover every decision; this does not make their review independent. -/
def office (denialCovered interventionPower : Bool) : OversightSystem Bool Decision where
  recognized _ := True
  independent r := r = true
  covers r d := r = false ∨ d = .routineInquiry ∨ denialCovered = true
  canReview _ := True
  canIntervene _ d := d = .routineInquiry ∨ interventionPower = true

/-! Person-facing safeguards remain fixed through all oversight comparisons.
This is a hypothetical denial with a named officer, appeal and correction
capacity, not an investigation of an actual agency. -/
def procedures : ProcedureSystem Unit Decision Unit where
  accepts _ _ _ := True
  canReview _ := True
  canCorrect _ := True

def governance : Governance Unit PublicBenefits.Officer Decision where
  affected _ d := d = .benefitDenial
  excluded _ d := d = .benefitDenial
  harmed _ d := d = .benefitDenial
  highImpact d := d = .benefitDenial
  assigned := (PublicBenefits.allocation true true).assigned
  identifiable _ := True
  appeal := procedures.HasAppeal
  remedyCapacity := procedures.HasRemedyCapacity
  explained _ := True
  humanReviewed _ := True

/-! Satisfaction of named fragments only: neither appeal/remedy policy
encodes independent oversight. Thus a missing oversight condition does not
contradict satisfaction of those policies. -/
theorem person_facing_fragments_satisfied :
    CompliantAt governance (broadAppealPolicy governance) .benefitDenial ∧
    CompliantAt governance (harmRemedyPolicy governance) .benefitDenial := by
  constructor <;> intro s _hs <;> cases s with
  | identifiableResponsibility =>
    exact ⟨.caseOfficer, Or.inr ⟨rfl, rfl⟩, True.intro⟩
  | appeal p => exact ⟨(), True.intro, True.intro⟩
  | remedyCapacity p => exact ⟨(), True.intro, True.intro⟩

theorem independent_body_exists (c p : Bool) :
    ∃ r, (office c p).recognized r ∧ (office c p).independent r ∧
      (office c p).canReview r ∧ (office c p).covers r .routineInquiry := by
  exact ⟨true, True.intro, rfl, True.intro, Or.inr (Or.inl rfl)⟩

/-! Exact paired-case characterization: both parameters matter. -/
theorem denial_oversight_iff (c p : Bool) :
    ActionableIndependentOversight (office c p) .benefitDenial ↔
      c = true ∧ p = true := by
  constructor
  · intro h
    obtain ⟨r, _, hi, hc, _, hp⟩ := h
    change r = true at hi
    subst r
    constructor
    · cases hc with
      | inl h => cases h
      | inr h =>
        cases h with
        | inl h => cases h
        | inr h => exact h
    · cases hp with
      | inl h => cases h
      | inr h => exact h
  · intro h
    exact ⟨true, True.intro, rfl, Or.inr (Or.inr h.1), True.intro,
      Or.inr h.2⟩

/-! T6 separation. The independent board has real, nonempty remit, but not
over this denial. Internal review and all named person-facing policies hold.
No full oversight-compliance claim is made for the violating case. -/
theorem regime_and_internal_review_do_not_cover_denial :
    governance.highImpact .benefitDenial ∧
    governance.affected () .benefitDenial ∧
    governance.humanReviewed .benefitDenial ∧
    CompliantAt governance (broadAppealPolicy governance) .benefitDenial ∧
    CompliantAt governance (harmRemedyPolicy governance) .benefitDenial ∧
    (∃ r, (office false true).recognized r ∧ (office false true).independent r ∧
      (office false true).canReview r ∧ (office false true).covers r .routineInquiry) ∧
    ((office false true).covers false .benefitDenial ∧
      (office false true).canReview false) ∧
    (¬ ∃ r, (office false true).independent r ∧
      (office false true).covers r .benefitDenial) ∧
    ¬ ActionableIndependentOversight (office false true) .benefitDenial := by
  refine ⟨rfl, rfl, True.intro, person_facing_fragments_satisfied.1,
    person_facing_fragments_satisfied.2, independent_body_exists false true,
    ⟨Or.inl rfl, True.intro⟩, ?_, ?_⟩
  · intro h
    obtain ⟨r, hi, hc⟩ := h
    change r = true at hi
    subst r
    cases hc with
    | inl h => cases h
    | inr h =>
      cases h with
      | inl h => cases h
      | inr h => cases h
  · intro h
    cases ((denial_oversight_iff false true).mp h).1

/-! Coverage is not intervention capacity. This case meets the explicit
independent-review coverage fragment but fails the actionable extension. -/
theorem coverage_without_intervention_is_insufficient :
    (∀ d : Decision, ∃ r, (office true false).recognized r ∧
      (office true false).independent r ∧ (office true false).covers r d ∧
      (office true false).canReview r) ∧
    ¬ ActionableIndependentOversight (office true false) .benefitDenial := by
  constructor
  · intro d
    exact ⟨true, True.intro, rfl, Or.inr (Or.inr rfl), True.intro⟩
  · intro h
    cases ((denial_oversight_iff true false).mp h).2

/-! Non-vacuous satisfaction witness for the declared stronger oversight
condition, together with the same person-facing safeguard fragments. -/
theorem repaired_case_satisfies_both_levels :
    governance.highImpact .benefitDenial ∧
    governance.affected () .benefitDenial ∧
    CompliantAt governance (broadAppealPolicy governance) .benefitDenial ∧
    CompliantAt governance (harmRemedyPolicy governance) .benefitDenial ∧
    (∃ r, (office true true).recognized r ∧ (office true true).independent r ∧
      (office true true).canReview r) ∧
    (∀ d : Decision, ActionableIndependentOversight (office true true) d) := by
  refine ⟨rfl, rfl, person_facing_fragments_satisfied.1,
    person_facing_fragments_satisfied.2,
    ⟨true, True.intro, rfl, True.intro⟩, ?_⟩
  intro d
  exact ⟨true, True.intro, rfl, Or.inr (Or.inr rfl), True.intro, Or.inr rfl⟩

/-! Coverage repair preserves independence, review and intervention capacity;
power repair preserves remit, independence and review. Governance is the same
record in every comparison. This isolates each missing provision. -/
theorem paired_repairs_preserve_other_provisions :
    (office false true).independent = (office true true).independent ∧
    (office false true).canReview = (office true true).canReview ∧
    (office false true).canIntervene = (office true true).canIntervene ∧
    (office true false).covers = (office true true).covers ∧
    (office true false).independent = (office true true).independent ∧
    (office true false).canReview = (office true true).canReview := by
  exact ⟨rfl, rfl, rfl, rfl, rfl, rfl⟩

end Oversight
end MagnificaHumanitas

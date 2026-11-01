import MagnificaHumanitas.Responsibility

namespace MagnificaHumanitas
namespace PublicBenefits

/-! Hypothetical public-benefit office. A public contact is identifiable,
but a different employee handles the denial. Two decisions prevent generic
staffing from being mistaken for coverage of the consequential case. -/
inductive Officer where
  | publicContact
  | caseOfficer
  deriving DecidableEq

inductive Decision where
  | routineInquiry
  | benefitDenial
  deriving DecidableEq

def allocation (officerNamed correctionPower : Bool) :
    ResponsibilityAllocation Unit Officer Decision where
  highImpact d := d = .benefitDenial
  institutionResponsible _ _ := True
  institutionIdentifiable _ := True
  member _ _ := True
  humanIdentifiable h := h = .publicContact ∨ officerNamed = true
  assigned h d :=
    (h = .publicContact ∧ d = .routineInquiry) ∨
    (h = .caseOfficer ∧ d = .benefitDenial)
  canCorrect h d := h = .caseOfficer ∧ d = .benefitDenial ∧ correctionPower = true

theorem institution_reading_holds (n p : Bool) :
    InstitutionalReading (allocation n p) := by
  intro d _
  exact ⟨(), True.intro, True.intro⟩

theorem identifiable_staff_exists (n p : Bool) :
    HasIdentifiableStaff (allocation n p) := by
  intro _ _
  exact ⟨.publicContact, True.intro, Or.inl rfl⟩

theorem every_impactful_decision_is_allocated (n p : Bool) :
    HasDecisionAllocation (allocation n p) := by
  intro i d _ hd
  change d = .benefitDenial at hd
  subst d
  exact ⟨.caseOfficer, True.intro, Or.inr ⟨rfl, rfl⟩⟩

/-! Existing identifiable staff and case allocation can have different people
as witnesses. This model has both, but no identified case-specific assignee. -/
theorem unnamed_case_has_no_human_answerability (p : Bool) :
    ¬ HumanAnswerability (allocation false p) .benefitDenial := by
  intro h
  obtain ⟨i, officer, _, _, ha, hn⟩ := h
  cases officer with
  | publicContact =>
    cases ha with
    | inl hr => cases hr.2
    | inr hr => cases hr.1
  | caseOfficer =>
    cases hn with
    | inl he => cases he
    | inr he => cases he

/-! Separation result against the named responsibility-only fragment. -/
theorem staffing_and_allocation_do_not_identify_the_assignee :
    ∃ r : ResponsibilityAllocation Unit Officer Decision,
      InstitutionalReading r ∧ HasIdentifiableStaff r ∧
      HasDecisionAllocation r ∧ r.highImpact .benefitDenial ∧
      ¬ HumanAnswerability r .benefitDenial := by
  exact ⟨allocation false true, institution_reading_holds false true,
    identifiable_staff_exists false true,
    every_impactful_decision_is_allocated false true, rfl,
    unnamed_case_has_no_human_answerability true⟩

theorem named_case_has_human_answerability (p : Bool) :
    HumanAnswerability (allocation true p) .benefitDenial := by
  exact ⟨(), .caseOfficer, True.intro, True.intro,
    Or.inr ⟨rfl, rfl⟩, Or.inr rfl⟩

theorem named_officers_identifiable (p : Bool) :
    AssignedAreIdentifiable (allocation true p) := by
  intro h d _
  exact Or.inr rfl

theorem named_case_without_power_not_actionable :
    ¬ ActionableResponsibility (allocation true false) .benefitDenial := by
  intro h
  obtain ⟨i, officer, _, _, _, _, hp⟩ := h
  cases hp.2.2

theorem named_responsibility_does_not_supply_power :
    ∃ r : ResponsibilityAllocation Unit Officer Decision,
      HumanAnswerability r .benefitDenial ∧
      ¬ ActionableResponsibility r .benefitDenial := by
  exact ⟨allocation true false, named_case_has_human_answerability false,
    named_case_without_power_not_actionable⟩

theorem identified_powered_case_is_actionable :
    ActionableResponsibility (allocation true true) .benefitDenial := by
  exact ⟨(), .caseOfficer, True.intro, True.intro,
    Or.inr ⟨rfl, rfl⟩, Or.inr rfl, rfl, rfl, rfl⟩

/-! Non-vacuous satisfying instance for both readings and action authority. -/
theorem public_benefits_satisfying_instance :
    ∃ r : ResponsibilityAllocation Unit Officer Decision,
      InstitutionalReading r ∧ IndividualReading r ∧
      r.highImpact .benefitDenial ∧ ActionableResponsibility r .benefitDenial := by
  refine ⟨allocation true true, institution_reading_holds true true, ?_,
    rfl, identified_powered_case_is_actionable⟩
  exact institutional_reading_extends_with_bridges _
    (institution_reading_holds true true)
    (every_impactful_decision_is_allocated true true)
    (named_officers_identifiable true)

/-! Naming and empowerment leave agency, staffing and assignments unchanged. -/
theorem comparison_preserves_institution_and_assignments
    (n₁ p₁ n₂ p₂ : Bool) :
    (allocation n₁ p₁).institutionResponsible =
      (allocation n₂ p₂).institutionResponsible ∧
    (allocation n₁ p₁).member = (allocation n₂ p₂).member ∧
    (allocation n₁ p₁).assigned = (allocation n₂ p₂).assigned := by
  exact ⟨rfl, rfl, rfl⟩

end PublicBenefits
end MagnificaHumanitas

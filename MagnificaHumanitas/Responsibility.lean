import MagnificaHumanitas.Model

namespace MagnificaHumanitas

/-! Factual allocation data. Institutional answerability, decision assignment,
identifiability, and correction authority are deliberately independent.
Source motivation: MH-020/021; interpretation I01; optional bridges A03/A13.
No legal liability or actual correction of harm is inferred. -/
structure ResponsibilityAllocation (Institution Human Decision : Type) where
  highImpact : Decision → Prop
  institutionResponsible : Institution → Decision → Prop
  institutionIdentifiable : Institution → Prop
  member : Human → Institution → Prop
  humanIdentifiable : Human → Prop
  assigned : Human → Decision → Prop
  canCorrect : Human → Decision → Prop

variable {I H D : Type}

def InstitutionalAnswerability (r : ResponsibilityAllocation I H D) (d : D) : Prop :=
  ∃ i, r.institutionResponsible i d ∧ r.institutionIdentifiable i

def HumanAnswerability (r : ResponsibilityAllocation I H D) (d : D) : Prop :=
  ∃ i h, r.institutionResponsible i d ∧ r.member h i ∧
    r.assigned h d ∧ r.humanIdentifiable h

def ActionableResponsibility (r : ResponsibilityAllocation I H D) (d : D) : Prop :=
  ∃ i h, r.institutionResponsible i d ∧ r.member h i ∧
    r.assigned h d ∧ r.humanIdentifiable h ∧ r.canCorrect h d

def HasIdentifiableStaff (r : ResponsibilityAllocation I H D) : Prop :=
  ∀ i, r.institutionIdentifiable i → ∃ h, r.member h i ∧ r.humanIdentifiable h

def HasDecisionAllocation (r : ResponsibilityAllocation I H D) : Prop :=
  ∀ i d, r.institutionResponsible i d → r.highImpact d →
    ∃ h, r.member h i ∧ r.assigned h d

def AssignedAreIdentifiable (r : ResponsibilityAllocation I H D) : Prop :=
  ∀ h d, r.assigned h d → r.humanIdentifiable h

/-! These are satisfaction conditions for two responsibility-only readings,
not claims that all source obligations have been met. -/
def InstitutionalReading (r : ResponsibilityAllocation I H D) : Prop :=
  ∀ d, r.highImpact d → InstitutionalAnswerability r d

def IndividualReading (r : ResponsibilityAllocation I H D) : Prop :=
  ∀ d, r.highImpact d → HumanAnswerability r d

/-! A concrete sufficient bridge, with allocation and identification separate.
Generic named staffing is not a hypothesis because it cannot identify the
particular person assigned to this decision. Not claimed to be minimal. -/
theorem institution_to_human_with_allocation_and_identification
    (r : ResponsibilityAllocation I H D)
    (hAllocation : HasDecisionAllocation r)
    (hIdentification : AssignedAreIdentifiable r)
    (d : D) (hImpact : r.highImpact d)
    (hInstitution : InstitutionalAnswerability r d) :
    HumanAnswerability r d := by
  obtain ⟨i, hi, _⟩ := hInstitution
  obtain ⟨h, hm, ha⟩ := hAllocation i d hi hImpact
  exact ⟨i, h, hi, hm, ha, hIdentification h d ha⟩

/-! Structural propagation of that sufficient bridge across the chosen scope. -/
theorem institutional_reading_extends_with_bridges
    (r : ResponsibilityAllocation I H D)
    (hInstitution : InstitutionalReading r)
    (hAllocation : HasDecisionAllocation r)
    (hIdentification : AssignedAreIdentifiable r) :
    IndividualReading r := by
  intro d hd
  exact institution_to_human_with_allocation_and_identification
    r hAllocation hIdentification d hd (hInstitution d hd)

/-! Authority must apply to the same person and decision. This is a sufficient
power-coverage premise, not an inference from a job title. -/
theorem human_to_actionable_with_power
    (r : ResponsibilityAllocation I H D) (d : D)
    (hHuman : HumanAnswerability r d)
    (hPower : ∀ h, r.assigned h d → r.canCorrect h d) :
    ActionableResponsibility r d := by
  obtain ⟨i, h, hi, hm, ha, hn⟩ := hHuman
  exact ⟨i, h, hi, hm, ha, hn, hPower h ha⟩

end MagnificaHumanitas

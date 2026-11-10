import MagnificaHumanitas.AppealReview

namespace LocalLaw144Study

open MagnificaHumanitas

/-- How the employer uses the output, independently of the identity of the tool. -/
inductive Reliance where
  | sole | greatestWeight | overrides | other
  deriving DecidableEq

structure HiringUse where
  inNYC : Bool
  qualifyingTool : Bool
  reliance : Reliance
  resident : Bool
  useDay : Nat
  auditDay : Nat
  auditValidThrough : Nat
  independentAuditor : Bool
  auditAdequate : Bool
  publicationDay : Nat
  latestSummaryPosted : Bool
  distributionDatePosted : Bool
  noticeDay : Nat
  noticeBusinessDays : Nat
  toolDisclosed : Bool
  criteriaDisclosed : Bool
  allowsAlternativeOrAccommodationRequest : Bool
  alternativeAvailable : Bool
  accommodationAvailable : Bool
  alternativeInstructions : Bool
  accommodationInstructions : Bool

def HiringUse.covered (u : HiringUse) : Prop :=
  u.inNYC = true ∧ u.qualifyingTool = true ∧ u.reliance ≠ .other

def HiringUse.auditReady (u : HiringUse) : Prop :=
  u.auditDay < u.useDay ∧ u.useDay ≤ u.auditValidThrough ∧
    u.independentAuditor = true ∧ u.auditAdequate = true

def HiringUse.publicationReady (u : HiringUse) : Prop :=
  u.publicationDay < u.useDay ∧
    u.latestSummaryPosted = true ∧ u.distributionDatePosted = true

def HiringUse.noticeReady (u : HiringUse) : Prop :=
  u.noticeDay < u.useDay ∧ 10 ≤ u.noticeBusinessDays ∧
    u.toolDisclosed = true ∧ u.criteriaDisclosed = true ∧
    u.allowsAlternativeOrAccommodationRequest = true ∧
    (u.alternativeAvailable = true → u.alternativeInstructions = true) ∧
    (u.accommodationAvailable = true → u.accommodationInstructions = true)

/-- Selected duties at a covered use. The notice trigger also requires residency. -/
def HiringUse.selectedDuties (u : HiringUse) : Prop :=
  u.covered → u.auditReady ∧ u.publicationReady ∧ (u.resident = true → u.noticeReady)

/-- Dates, intervals and attestations in a hypothetical use. -/
def exampleUse : HiringUse where
  inNYC := true
  qualifyingTool := true
  reliance := .greatestWeight
  resident := true
  useDay := 100
  auditDay := 20
  auditValidThrough := 385
  independentAuditor := true
  auditAdequate := true
  publicationDay := 30
  latestSummaryPosted := true
  distributionDatePosted := true
  noticeDay := 80
  noticeBusinessDays := 10
  toolDisclosed := true
  criteriaDisclosed := true
  allowsAlternativeOrAccommodationRequest := true
  alternativeAvailable := true
  accommodationAvailable := true
  alternativeInstructions := true
  accommodationInstructions := true

theorem example_covered : exampleUse.covered := by
  simp [HiringUse.covered, exampleUse]

theorem example_selected_duties : exampleUse.selectedDuties := by
  simp [HiringUse.selectedDuties, HiringUse.auditReady, HiringUse.publicationReady,
    HiringUse.noticeReady, exampleUse]

theorem nine_business_days_fails :
    ¬ ({ exampleUse with noticeBusinessDays := 9 } : HiringUse).selectedDuties := by
  simp [HiringUse.selectedDuties, HiringUse.covered, HiringUse.auditReady,
    HiringUse.publicationReady, HiringUse.noticeReady, exampleUse]

theorem expired_audit_fails :
    ¬ ({ exampleUse with auditValidThrough := 99 } : HiringUse).selectedDuties := by
  simp [HiringUse.selectedDuties, HiringUse.covered, HiringUse.auditReady,
    HiringUse.publicationReady, exampleUse]

/-- A single affected, excluded and harmed candidate in a high-impact screen.
The named responsibility is deliberately present to isolate the appeal failure. -/
def screeningGovernance (appeal remedy : Bool) : Governance Unit Unit Unit where
  affected := fun _ _ => True
  excluded := fun _ _ => True
  harmed := fun _ _ => True
  highImpact := fun _ => True
  assigned := fun _ _ => True
  identifiable := fun _ => True
  appeal := fun _ _ => appeal = true
  remedyCapacity := fun _ _ => remedy = true
  explained := fun _ => True
  humanReviewed := fun _ => True

theorem selected_duties_allow_screen_without_appeal :
    exampleUse.covered ∧ exampleUse.selectedDuties ∧
    (¬ CompliantAt (screeningGovernance false false)
      (responsibilityAppealPolicy (screeningGovernance false false)) ()) ∧
    (¬ CompliantAt (screeningGovernance false false)
      (broadAppealPolicy (screeningGovernance false false)) ()) ∧
    (¬ CompliantAt (screeningGovernance false false)
      (harmRemedyPolicy (screeningGovernance false false)) ()) := by
  have hn : ¬ CompliantAt (screeningGovernance false false)
      (responsibilityAppealPolicy (screeningGovernance false false)) () := by
    intro h
    have hAppeal := h (.appeal ()) (by trivial)
    simp [Provided, screeningGovernance] at hAppeal
  exact ⟨example_covered, example_selected_duties, hn,
    fun h => hn (broad_appeal_implies_narrow _ _ h),
    fun h => hn (stronger_implies_fragment _ _ h)⟩

theorem review_without_remedy_separates_policies :
    exampleUse.selectedDuties ∧
    CompliantAt (screeningGovernance true false)
      (responsibilityAppealPolicy (screeningGovernance true false)) () ∧
    CompliantAt (screeningGovernance true false)
      (broadAppealPolicy (screeningGovernance true false)) () ∧
    (¬ CompliantAt (screeningGovernance true false)
      (harmRemedyPolicy (screeningGovernance true false)) ()) := by
  have hb : CompliantAt (screeningGovernance true false)
      (broadAppealPolicy (screeningGovernance true false)) () := by
    intro r hr
    cases r <;> simp [broadAppealPolicy, Provided, screeningGovernance] at hr ⊢
  refine ⟨example_selected_duties, broad_appeal_implies_narrow _ _ hb, hb, ?_⟩
  intro h
  have hRemedy := h (.remedyCapacity ()) (by trivial)
  simp [Provided, screeningGovernance] at hRemedy

end LocalLaw144Study

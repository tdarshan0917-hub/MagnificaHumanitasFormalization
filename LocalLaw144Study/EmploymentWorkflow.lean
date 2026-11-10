import LocalLaw144Study.LocalLaw144

namespace LocalLaw144Study.EmploymentWorkflow

structure Assessment where
  caseId : Nat
  recordedQualification : Bool
  use : HiringUse
  accommodationChannel : Bool

/-- The same screening rule is used before and after a correction. -/
def Assessment.advances (a : Assessment) : Bool :=
  a.recordedQualification

structure Finding where
  caseId : Nat

/-- Evidence independently supports the qualification that the stored field lacks. -/
def review (a : Assessment) (request supportedQualification : Bool) : Option Finding :=
  if request && supportedQualification && !a.recordedQualification then
    some ⟨a.caseId⟩
  else none

def deliver (route : Bool) (finding : Option Finding) : Option Finding :=
  if route then finding else none

/-- The authorized actor's remit is identified by the case they can correct. -/
def applyFinding (a : Assessment) (authority : Option Nat)
    (delivered : Option Finding) : Assessment :=
  match delivered with
  | none => a
  | some f =>
    if f.caseId = a.caseId ∧ authority = some a.caseId then
      { a with recordedQualification := true }
    else a

def run (a : Assessment) (request supportedQualification route : Bool)
    (authority : Option Nat) : Assessment :=
  applyFinding a authority (deliver route (review a request supportedQualification))

def initial : Assessment :=
  ⟨7, false, exampleUse, true⟩

theorem review_without_delivery_leaves_adverse_screen :
    initial.use.selectedDuties ∧
    review initial true true = some ⟨7⟩ ∧
    (run initial true true false (some 7)).advances = false := by
  exact ⟨example_selected_duties, rfl, rfl⟩

theorem routing_repair_changes_assessment :
    (run initial true true true (some 7)).advances = true := rfl

theorem application_preserves_context (a : Assessment) (authority : Option Nat)
    (delivered : Option Finding) :
    (applyFinding a authority delivered).use = a.use ∧
    (applyFinding a authority delivered).accommodationChannel = a.accommodationChannel ∧
    (applyFinding a authority delivered).caseId = a.caseId := by
  cases delivered with
  | none => exact ⟨rfl, rfl, rfl⟩
  | some f =>
    by_cases h : f.caseId = a.caseId ∧ authority = some a.caseId <;> simp [applyFinding, h]

theorem repaired_trace_preserves_selected_duties_and_accommodation :
    (run initial true true true (some 7)).use.selectedDuties ∧
    (run initial true true true (some 7)).accommodationChannel =
      (run initial true true false (some 7)).accommodationChannel :=
  ⟨example_selected_duties, rfl⟩

/-- Characterizes an explicitly executed trace from an adverse initial assessment. -/
theorem advances_iff_completed_path (a : Assessment) (request supportedQualification route : Bool)
    (authority : Option Nat) (adverse : a.recordedQualification = false) :
    (run a request supportedQualification route authority).advances = true ↔
      request = true ∧ supportedQualification = true ∧ route = true ∧
        authority = some a.caseId := by
  by_cases h : authority = some a.caseId <;>
    cases request <;> cases supportedQualification <;> cases route <;>
    simp [run, review, deliver, applyFinding, Assessment.advances, adverse, h]

theorem wrong_case_finding_cannot_change_assessment (a : Assessment) (f : Finding)
    (authority : Option Nat) (wrongCase : f.caseId ≠ a.caseId) :
    applyFinding a authority (some f) = a := by
  simp [applyFinding, wrongCase]

theorem application_before_review_leaves_assessment (a : Assessment) (authority : Option Nat) :
    applyFinding a authority none = a := rfl

theorem missing_authority_leaves_assessment (a : Assessment) (delivered : Option Finding) :
    applyFinding a none delivered = a := by
  cases delivered <;> simp [applyFinding]

theorem missing_delivery_leaves_assessment (a : Assessment) (authority : Option Nat)
    (finding : Option Finding) :
    applyFinding a authority (deliver false finding) = a := rfl

end LocalLaw144Study.EmploymentWorkflow

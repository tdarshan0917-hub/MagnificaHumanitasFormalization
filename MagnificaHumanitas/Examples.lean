import MagnificaHumanitas.Theory

namespace MagnificaHumanitas
namespace Prototype

/-! A finite hypothetical example: one applicant, officer, rejection, and desk.
The parameter controls the desk's correction power; review is held fixed. -/
def procedures (correction : Bool) : ProcedureSystem Unit Unit Unit where
  accepts _ _ _ := True
  canReview _ := True
  canCorrect _ := correction = true

def governance (correction : Bool) : Governance Unit Unit Unit where
  affected _ _ := True
  excluded _ _ := True
  harmed _ _ := True
  highImpact _ := True
  assigned _ _ := True
  identifiable _ := True
  appeal := (procedures correction).HasAppeal
  remedyCapacity := (procedures correction).HasRemedyCapacity
  explained _ := True
  humanReviewed _ := True

theorem has_appeal (b : Bool) : (governance b).appeal () () := by
  exact ⟨(), True.intro, True.intro⟩

theorem lacks_capacity : ¬ (governance false).remedyCapacity () () := by
  intro h
  cases h with
  | intro c hc => exact Bool.noConfusion hc.2

theorem has_capacity : (governance true).remedyCapacity () () := by
  exact ⟨(), True.intro, rfl⟩

theorem fragment_compliant (b : Bool) :
    CompliantAt (governance b) (responsibilityAppealPolicy (governance b)) () := by
  intro r hr
  cases r with
  | identifiableResponsibility => exact ⟨(), True.intro, True.intro⟩
  | appeal p => exact ⟨(), True.intro, True.intro⟩
  | remedyCapacity p => exact False.elim hr

theorem uncorrectable_not_stronger_compliant :
    ¬ CompliantAt (governance false) (harmRemedyPolicy (governance false)) () := by
  intro h
  exact lacks_capacity (h (.remedyCapacity ()) True.intro)

/-! A satisfying model with a real trigger; the prototype is not vacuous. -/
theorem corrected_stronger_compliant :
    CompliantAt (governance true) (harmRemedyPolicy (governance true)) () := by
  intro r _
  cases r with
  | identifiableResponsibility => exact ⟨(), True.intro, True.intro⟩
  | appeal p => exact ⟨(), True.intro, True.intro⟩
  | remedyCapacity p => exact ⟨(), True.intro, rfl⟩

/-! C3 witness against the named responsibility/appeal fragment.
The same model FAILS the stronger remedy specification, explicitly. -/
theorem responsibility_appeal_not_remedy :
    ∃ g : Governance Unit Unit Unit,
      CompliantAt g (responsibilityAppealPolicy g) () ∧
      g.highImpact () ∧ g.affected () () ∧ g.excluded () () ∧ g.harmed () () ∧
      Provided g () .identifiableResponsibility ∧
      g.appeal () () ∧ g.explained () ∧ g.humanReviewed () ∧
      ¬ g.remedyCapacity () () := by
  exact ⟨governance false, fragment_compliant false,
    True.intro, True.intro, True.intro, True.intro,
    ⟨(), True.intro, True.intro⟩, has_appeal false,
    True.intro, True.intro, lacks_capacity⟩

/-! Required safeguards may be absent in a non-compliant model. -/
theorem obligation_without_provision :
    (harmRemedyPolicy (governance false)).required () (.remedyCapacity ()) ∧
    ¬ Provided (governance false) () (.remedyCapacity ()) := by
  exact ⟨True.intro, lacks_capacity⟩

/-! The two procedure systems agree on access/review and differ on correction.
This theorem describes an abstract institutional change, not software repair. -/
theorem correction_changes_only_procedure_power :
    (procedures false).accepts = (procedures true).accepts ∧
    (procedures false).canReview = (procedures true).canReview ∧
    (¬ (procedures false).canCorrect ()) ∧
    (procedures true).canCorrect () := by
  exact ⟨rfl, rfl, Bool.noConfusion, rfl⟩

theorem prototype_satisfiable_nonvacuously :
    ∃ g : Governance Unit Unit Unit,
      CompliantAt g (harmRemedyPolicy g) () ∧
      g.highImpact () ∧ g.affected () () ∧ g.harmed () () := by
  exact ⟨governance true, corrected_stronger_compliant,
    True.intro, True.intro, True.intro⟩

end Prototype
end MagnificaHumanitas

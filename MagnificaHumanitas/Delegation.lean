import MagnificaHumanitas.Examples
import MagnificaHumanitas.AppealReview

namespace MagnificaHumanitas

/-! T2: a production handoff is an explicit update of the factual producer
field. It does not silently rewrite the policy or erase actual assignments.
The update expression is displayed in the statements; no new principal
operation, producer type or policy is added. MH-015/020, I24, A29/A30.
No premise about AI's moral responsibility is assumed or derived from types. -/
theorem producer_change_preserves_fixed_policy {P A D : Type}
    (g : Governance P A D) (policy : Policy P D) (usesAI : D → Prop) (d : D) :
    CompliantAt ({ g with producedByAI := usesAI }) policy d ↔
      CompliantAt g policy d := by
  rfl

/-! These three existing policy interpretations are producer-independent.
This does not assert that every conceivable policy has that property. -/
theorem producer_change_preserves_existing_requirements {P A D : Type}
    (g : Governance P A D) (usesAI : D → Prop) :
    (responsibilityAppealPolicy ({ g with producedByAI := usesAI })).required =
      (responsibilityAppealPolicy g).required ∧
    (broadAppealPolicy ({ g with producedByAI := usesAI })).required =
      (broadAppealPolicy g).required ∧
    (harmRemedyPolicy ({ g with producedByAI := usesAI })).required =
      (harmRemedyPolicy g).required := by
  exact ⟨rfl, rfl, rfl⟩

namespace Delegation

/-! Same employment case: production is handed to AI, but the named human
officer remains assigned. The alternate handoff additionally removes the
assignment. Neither appeal nor correction capacity is removed. -/
def aiDecision : Governance Unit Unit Unit :=
  { Prototype.governance true with producedByAI := fun _ => True }

def orphanedDecision : Governance Unit Unit Unit :=
  { aiDecision with assigned := fun _ _ => False }

theorem retained_assignment_satisfies_all_three :
    CompliantAt aiDecision (responsibilityAppealPolicy aiDecision) () ∧
    CompliantAt aiDecision (broadAppealPolicy aiDecision) () ∧
    CompliantAt aiDecision (harmRemedyPolicy aiDecision) () := by
  refine ⟨?_, ?_, ?_⟩ <;> intro s _hs <;> cases s with
  | identifiableResponsibility => exact ⟨(), True.intro, True.intro⟩
  | appeal p => exact ⟨(), True.intro, True.intro⟩
  | remedyCapacity p => exact ⟨(), True.intro, rfl⟩

/-! Non-vacuous T2 witness: production actually changes from non-AI to AI,
the impacted/excluded/harmed person is present, and the same human remains
responsible. Compliance is checked, not inferred from the obligation. -/
theorem ai_handoff_retains_human_responsibility :
    (¬ (Prototype.governance true).producedByAI ()) ∧
    aiDecision.producedByAI () ∧ aiDecision.highImpact () ∧
    aiDecision.affected () () ∧ aiDecision.excluded () () ∧
    aiDecision.harmed () () ∧ aiDecision.assigned () () ∧
    aiDecision.identifiable () ∧
    CompliantAt aiDecision (responsibilityAppealPolicy aiDecision) () ∧
    CompliantAt aiDecision (broadAppealPolicy aiDecision) () ∧
    CompliantAt aiDecision (harmRemedyPolicy aiDecision) () := by
  exact ⟨fun h => h, True.intro, True.intro, True.intro, True.intro,
    True.intro, True.intro, True.intro,
    retained_assignment_satisfies_all_three.1,
    retained_assignment_satisfies_all_three.2.1,
    retained_assignment_satisfies_all_three.2.2⟩

/-! Erasing the assignment is an additional change, not a consequence of
changing the producer. The same responsibility duty remains and is violated
under all three named policies, despite available appeal/correction. -/
theorem removing_officer_after_handoff_violates_all_three :
    orphanedDecision.producedByAI () ∧
    (responsibilityAppealPolicy orphanedDecision).required () .identifiableResponsibility ∧
    orphanedDecision.appeal () () ∧ orphanedDecision.remedyCapacity () () ∧
    (¬ Provided orphanedDecision () .identifiableResponsibility) ∧
    (¬ CompliantAt orphanedDecision (responsibilityAppealPolicy orphanedDecision) ()) ∧
    (¬ CompliantAt orphanedDecision (broadAppealPolicy orphanedDecision) ()) ∧
    (¬ CompliantAt orphanedDecision (harmRemedyPolicy orphanedDecision) ()) := by
  have hMissing : ¬ Provided orphanedDecision () .identifiableResponsibility := by
    intro h
    obtain ⟨_, ha, _⟩ := h
    exact ha
  exact ⟨True.intro, True.intro, ⟨(), True.intro, True.intro⟩,
    ⟨(), True.intro, rfl⟩, hMissing,
    fun h => hMissing (h .identifiableResponsibility True.intro),
    fun h => hMissing (h .identifiableResponsibility True.intro),
    fun h => hMissing (h .identifiableResponsibility True.intro)⟩

/-! Paired comparison identifies the single failed provision. Both cases
use AI and preserve duty triggers, review, appeal and correction capacity. -/
theorem officer_removal_preserves_other_safeguards :
    aiDecision.producedByAI = orphanedDecision.producedByAI ∧
    aiDecision.highImpact = orphanedDecision.highImpact ∧
    aiDecision.excluded = orphanedDecision.excluded ∧
    aiDecision.harmed = orphanedDecision.harmed ∧
    aiDecision.humanReviewed = orphanedDecision.humanReviewed ∧
    aiDecision.appeal = orphanedDecision.appeal ∧
    aiDecision.remedyCapacity = orphanedDecision.remedyCapacity := by
  exact ⟨rfl, rfl, rfl, rfl, rfl, rfl, rfl⟩

end Delegation
end MagnificaHumanitas

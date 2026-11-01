import MagnificaHumanitas.AppealReview
import MagnificaHumanitas.PublicBenefits

namespace MagnificaHumanitas
namespace DeveloperResponsibility

/-! Existing public-benefits case, with an explicit design-review context.
Sum.inl () is that consequential design choice; Sum.inr d is the existing
operational decision d. Bool actors: false = developer, true = deployer.
This finite case reuses Governance and the existing policies; it adds no
principal domain definition. I22/A25 fixes the stage classification and role
allocation. Extra developer assignment at deployment is an optional fact A26,
not a duty derived from the developer's role or a legal-liability claim. -/
def procedures : ProcedureSystem Unit (Sum Unit PublicBenefits.Decision) Unit where
  accepts _ _ _ := True
  canReview _ := True
  canCorrect _ := True

def governance (deploymentCovered extraDeveloperAssignment : Bool) :
    Governance Unit Bool (Sum Unit PublicBenefits.Decision) where
  affected _ stage := stage = .inr .benefitDenial
  excluded _ stage := stage = .inr .benefitDenial
  harmed _ stage := stage = .inr .benefitDenial
  highImpact stage := stage = .inl () ∨ stage = .inr .benefitDenial
  assigned actor stage := match stage with
    | .inl _ => actor = false
    | .inr .routineInquiry => False
    | .inr .benefitDenial =>
      (actor = true ∧ deploymentCovered = true) ∨
      (actor = false ∧ extraDeveloperAssignment = true)
  identifiable _ := True
  appeal := procedures.HasAppeal
  remedyCapacity := procedures.HasRemedyCapacity
  explained _ := True
  humanReviewed _ := True

theorem design_fragment_satisfied (covered extra : Bool) :
    CompliantAt (governance covered extra)
      (responsibilityAppealPolicy (governance covered extra)) (.inl ()) := by
  intro s hs
  cases s with
  | identifiableResponsibility => exact ⟨false, rfl, True.intro⟩
  | appeal p => cases hs
  | remedyCapacity p => exact False.elim hs

/-! A satisfied design-stage duty is not satisfaction of the downstream duty.
The missing assignee is a violation of the existing rule, not absence of a
rule. Review, appeal and correction channels alone do not fill that gap. -/
theorem design_compliance_leaves_downstream_gap :
    ∃ g : Governance Unit Bool (Sum Unit PublicBenefits.Decision),
      g.highImpact (.inl ()) ∧ g.highImpact (.inr .benefitDenial) ∧
      g.affected () (.inr .benefitDenial) ∧
      g.assigned false (.inl ()) ∧
      CompliantAt g (responsibilityAppealPolicy g) (.inl ()) ∧
      (responsibilityAppealPolicy g).required (.inr .benefitDenial)
        .identifiableResponsibility ∧
      (¬ Provided g (.inr .benefitDenial) .identifiableResponsibility) ∧
      ¬ CompliantAt g (responsibilityAppealPolicy g) (.inr .benefitDenial) := by
  have hMissing : ¬ Provided (governance false false) (.inr .benefitDenial)
      .identifiableResponsibility := by
    intro h
    obtain ⟨_, ha, _⟩ := h
    cases ha with
    | inl h => cases h.2
    | inr h => cases h.2
  refine ⟨governance false false, Or.inl rfl, Or.inr rfl, rfl, rfl,
    design_fragment_satisfied false false, Or.inr rfl, hMissing, ?_⟩
  intro h
  exact hMissing (h .identifiableResponsibility (Or.inr rfl))

/-! Satisfaction at every context of the finite stage carrier, with a named
deployer covering the denial. The optional developer assignment can be on or
off; neither policy has a universal, actor-specific downstream duty. -/
theorem covered_stages_satisfy_existing_fragments (extra : Bool) :
    ∀ stage, CompliantAt (governance true extra)
        (broadAppealPolicy (governance true extra)) stage ∧
      CompliantAt (governance true extra)
        (harmRemedyPolicy (governance true extra)) stage := by
  intro stage
  constructor <;> intro s hs <;> cases s with
  | identifiableResponsibility =>
    cases stage with
    | inl _ => exact ⟨false, rfl, True.intro⟩
    | inr d =>
      cases d with
      | routineInquiry =>
        cases hs with
        | inl h => cases h
        | inr h => cases h
      | benefitDenial => exact ⟨true, Or.inl ⟨rfl, rfl⟩, True.intro⟩
  | appeal p => exact ⟨(), True.intro, True.intro⟩
  | remedyCapacity p => exact ⟨(), True.intro, True.intro⟩

/-! Stage-specific answerability is compatible with different actors at
design and deployment. This is the named source-relative fragment only;
it does not establish full ethical design, absence of developer liability,
or a rule ending duties when production is delegated to AI. -/
theorem shared_stages_without_universal_developer_assignment :
    ∃ g : Governance Unit Bool (Sum Unit PublicBenefits.Decision),
      g.highImpact (.inl ()) ∧ g.highImpact (.inr .benefitDenial) ∧
      g.affected () (.inr .benefitDenial) ∧
      g.assigned false (.inl ()) ∧ g.assigned true (.inr .benefitDenial) ∧
      (¬ g.assigned false (.inr .benefitDenial)) ∧
      (∀ stage, CompliantAt g (broadAppealPolicy g) stage ∧
        CompliantAt g (harmRemedyPolicy g) stage) := by
  refine ⟨governance true false, Or.inl rfl, Or.inr rfl, rfl, rfl,
    Or.inl ⟨rfl, rfl⟩, ?_, covered_stages_satisfy_existing_fragments false⟩
  intro h
  cases h with
  | inl h => cases h.1
  | inr h => cases h.2

/-! The alternative assigning BOTH developer and deployer to the denial also
satisfies the same policies. The fragment neither forces nor forbids the
developer's additional assignment. This is not exclusive responsibility. -/
theorem additional_developer_assignment_is_compatible :
    (governance true true).assigned false (.inl ()) ∧
    (governance true true).assigned false (.inr .benefitDenial) ∧
    (governance true true).assigned true (.inr .benefitDenial) ∧
    (∀ stage, CompliantAt (governance true true)
        (broadAppealPolicy (governance true true)) stage ∧
      CompliantAt (governance true true)
        (harmRemedyPolicy (governance true true)) stage) := by
  exact ⟨rfl, Or.inr ⟨rfl, rfl⟩, Or.inl ⟨rfl, rfl⟩,
    covered_stages_satisfy_existing_fragments true⟩

/-! Paired comparison: the added downstream developer assignment changes no
source-duty trigger, prior design assignment, appeal or remedy capacity.
No theorem says an actor-specific duty may be deleted by changing a fact. -/
theorem extra_assignment_preserves_duties_and_design :
    (fun actor => (governance true false).assigned actor (.inl ())) =
      (fun actor => (governance true true).assigned actor (.inl ())) ∧
    (broadAppealPolicy (governance true false)).required =
      (broadAppealPolicy (governance true true)).required ∧
    (harmRemedyPolicy (governance true false)).required =
      (harmRemedyPolicy (governance true true)).required ∧
    (governance true false).appeal = (governance true true).appeal ∧
    (governance true false).remedyCapacity = (governance true true).remedyCapacity := by
  exact ⟨rfl, rfl, rfl, rfl, rfl⟩

end DeveloperResponsibility
end MagnificaHumanitas

import MagnificaHumanitas.Participation

namespace MagnificaHumanitas
namespace Authority

/-! A bounded authorization proxy for T9, not a definition of moral or legal
legitimacy. The existing public-benefits review rule supplies technical
control. Institutional recognition and decision remit are separate evidence.
Bool roles: false = platform operator, true = independent review board.
Source motivation MH-039 (§110), I13/I23; assumptions A12/A27/A28.
No new principal domain definition or Authority := False flag is introduced. -/
def office (operatorRecognized : Bool) : OversightSystem Bool PublicBenefits.Decision where
  recognized role := role = true ∨ operatorRecognized = true
  independent role := role = true
  covers _ decision := decision = .benefitDenial
  canReview _ := True
  canIntervene _ decision :=
    ∀ outcome : Bool, ∃ proposal : Bool, ∀ override : Option Bool,
      (Participation.process true).decide decision
        ((Participation.process true).record decision proposal) override = outcome

/-! Technical control has operational content: either review result can be
produced against every institutional override in the bounded procedure.
Each role's capability is assessed separately, not as a concurrency claim. -/
theorem actual_control_available (recognized role : Bool) (d : PublicBenefits.Decision) :
    (office recognized).canIntervene role d := by
  intro outcome
  exact ⟨outcome, fun _ => rfl⟩

/-! The named fragment includes the person-facing policies and an actual
independent board covering the denial. The operator's technical control
does not supply institutional recognition. This refutes only the displayed
capability-to-recognized-remit implication, not a complete legitimacy theory. -/
theorem technical_control_without_mandate :
    ∃ o : OversightSystem Bool PublicBenefits.Decision,
      Oversight.governance.highImpact .benefitDenial ∧
      Oversight.governance.affected () .benefitDenial ∧
      CompliantAt Oversight.governance
        (broadAppealPolicy Oversight.governance) .benefitDenial ∧
      CompliantAt Oversight.governance
        (harmRemedyPolicy Oversight.governance) .benefitDenial ∧
      o.canIntervene false .benefitDenial ∧
      (¬ (o.recognized false ∧ o.covers false .benefitDenial)) ∧
      ActionableIndependentOversight o .benefitDenial := by
  refine ⟨office false, rfl, rfl, Oversight.person_facing_fragments_satisfied.1,
    Oversight.person_facing_fragments_satisfied.2,
    actual_control_available false false .benefitDenial, ?_, ?_⟩
  · intro h
    cases h.1 with
    | inl h => cases h
    | inr h => cases h
  · exact ⟨true, Or.inl rfl, rfl, rfl, True.intro,
      actual_control_available false true .benefitDenial⟩

/-! A capable recognized operator is also permitted by the same fragments.
Capability therefore does not imply absence of a scoped mandate either.
Recognition is stipulated institutional evidence, not proven legitimacy. -/
theorem granted_mandate_is_compatible :
    Oversight.governance.highImpact .benefitDenial ∧
    Oversight.governance.affected () .benefitDenial ∧
    CompliantAt Oversight.governance
      (broadAppealPolicy Oversight.governance) .benefitDenial ∧
    CompliantAt Oversight.governance
      (harmRemedyPolicy Oversight.governance) .benefitDenial ∧
    (office true).canIntervene false .benefitDenial ∧
    ((office true).recognized false ∧ (office true).covers false .benefitDenial) ∧
    ActionableIndependentOversight (office true) .benefitDenial := by
  exact ⟨rfl, rfl, Oversight.person_facing_fragments_satisfied.1,
    Oversight.person_facing_fragments_satisfied.2,
    actual_control_available true false .benefitDenial,
    ⟨Or.inr rfl, rfl⟩,
    ⟨true, Or.inl rfl, rfl, rfl, True.intro,
      actual_control_available true true .benefitDenial⟩⟩

/-! Exact recognition difference in this finite family, not a universal
criterion for rightful government or a weakest-premise policy theorem. -/
theorem operator_mandate_iff_granted (recognized : Bool) :
    ((office recognized).recognized false ∧
      (office recognized).covers false .benefitDenial) ↔ recognized = true := by
  constructor
  · intro h
    cases h.1 with
    | inl h => cases h
    | inr h => exact h
  · intro h
    exact ⟨Or.inr h, rfl⟩

/-! The paired case changes only recognition. Actual control, review,
independence and remit remain identical. Thus a new institutional fact,
not extra technical capability, accounts for the proxy-mandate difference. -/
theorem granting_preserves_technical_facts :
    (office false).canIntervene = (office true).canIntervene ∧
    (office false).canReview = (office true).canReview ∧
    (office false).covers = (office true).covers ∧
    (office false).independent = (office true).independent := by
  exact ⟨rfl, rfl, rfl, rfl⟩

end Authority
end MagnificaHumanitas

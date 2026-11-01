import MagnificaHumanitas.Oversight

namespace MagnificaHumanitas

/-! One local community participates in review of an existing decision.
Bool recommendations/outcomes mean deny (false) or grant (true). Option Bool
is the institution's override: none leaves the recommendation to decide.
The functions describe actual record/revision/decision behavior, not duties.
Source motivation: MH-029/032/036; I07/I21; A22/A23. No authority flag is used. -/
structure ConsultationProcess (Decision : Type) where
  accepts : Decision → Bool → Prop
  record : Decision → Bool → Bool
  revise : Decision → Bool → Bool → Bool
  decide : Decision → Bool → Option Bool → Bool

/-! Sufficient interface bridge. Accepted recommendations must reach each
outcome, and their recorded value must bind the final rule against every
institutional override. This is not inferred from consultation alone and
is not claimed to be a weakest-premise theorem. -/
theorem final_control_from_reachability_and_binding {D : Type}
    (p : ConsultationProcess D) (d : D)
    (hReachable : ∀ outcome : Bool, ∃ proposal : Bool,
      p.accepts d proposal ∧ p.record d proposal = outcome)
    (hBinding : ∀ proposal : Bool, p.accepts d proposal →
      ∀ override : Option Bool,
        p.decide d (p.record d proposal) override = p.record d proposal) :
    ∀ outcome : Bool, ∃ proposal : Bool, p.accepts d proposal ∧
      ∀ override : Option Bool, p.decide d (p.record d proposal) override = outcome := by
  intro outcome
  obtain ⟨proposal, ha, hr⟩ := hReachable outcome
  refine ⟨proposal, ha, ?_⟩
  intro override
  exact (hBinding proposal ha override).trans hr

namespace Participation

open PublicBenefits (Decision)

/-! Concrete paired procedures, not a new case domain. The only difference
is the final decision rule. Local record amendment is not correction of the
benefit outcome, the institution's standards, or an established factual error. -/
def process (bindingLocal : Bool) : ConsultationProcess Decision where
  accepts _ _ := True
  record _ proposal := proposal
  revise _ _ amendment := amendment
  decide _ recorded override := if bindingLocal then recorded else override.getD recorded

/-! Explicit participation fragment, with an operational final influence
witness. There is no merely stipulated Participatory or Authority predicate. -/
theorem participation_fragment_satisfied (bindingLocal : Bool) (d : Decision) :
    (∀ proposal : Bool, (process bindingLocal).accepts d proposal ∧
      (process bindingLocal).record d proposal = proposal) ∧
    (∀ old amendment : Bool, (process bindingLocal).revise d old amendment = amendment) ∧
    (process bindingLocal).record d false ≠ (process bindingLocal).record d true ∧
    (process bindingLocal).decide d ((process bindingLocal).record d false) none = false ∧
    (process bindingLocal).decide d
      ((process bindingLocal).revise d ((process bindingLocal).record d false) true) none = true := by
  cases bindingLocal <;>
    exact ⟨fun _ => ⟨True.intro, rfl⟩, fun _ _ => rfl,
      Bool.noConfusion, rfl, rfl⟩

/-! Operational final control: every desired outcome can be imposed through
an accepted proposal against every possible institutional override. The exact
characterization concerns only this paired family, not legal authority. -/
theorem final_control_iff_binding (bindingLocal : Bool) (d : Decision) :
    (∀ outcome : Bool, ∃ proposal : Bool, (process bindingLocal).accepts d proposal ∧
      ∀ override : Option Bool,
        (process bindingLocal).decide d ((process bindingLocal).record d proposal) override = outcome) ↔
      bindingLocal = true := by
  constructor
  · intro h
    cases bindingLocal with
    | false =>
      obtain ⟨_, _, hFinal⟩ := h false
      have hImpossible := hFinal (some true)
      cases hImpossible
    | true => rfl
  · intro h
    cases bindingLocal with
    | false => cases h
    | true =>
      intro outcome
      exact ⟨outcome, True.intro, fun _ => rfl⟩

/-! C6: genuine recorded and revisable input can influence the outcome, yet
the institution can choose either final outcome for every local proposal.
Thus the community has neither final control nor an absolute blocking veto
over a grant. This satisfies the displayed participation fragment, not the
whole source's requirements for subsidiarity or legitimate authority. -/
theorem consultation_and_revision_without_final_control :
    ∃ p : ConsultationProcess Decision,
      (∀ proposal : Bool, p.accepts .benefitDenial proposal ∧
        p.record .benefitDenial proposal = proposal) ∧
      (∀ old amendment : Bool, p.revise .benefitDenial old amendment = amendment) ∧
      p.record .benefitDenial false ≠ p.record .benefitDenial true ∧
      p.decide .benefitDenial (p.record .benefitDenial false) none = false ∧
      p.decide .benefitDenial
        (p.revise .benefitDenial (p.record .benefitDenial false) true) none = true ∧
      (∀ proposal : Bool, ∀ outcome : Bool, ∃ override : Option Bool,
        p.decide .benefitDenial (p.record .benefitDenial proposal) override = outcome) ∧
      ¬ (∀ outcome : Bool, ∃ proposal : Bool, p.accepts .benefitDenial proposal ∧
        ∀ override : Option Bool,
          p.decide .benefitDenial (p.record .benefitDenial proposal) override = outcome) := by
  obtain ⟨ha, hr, hd, hn, hc⟩ := participation_fragment_satisfied false .benefitDenial
  refine ⟨process false, ha, hr, hd, hn, hc, ?_, ?_⟩
  · intro _ outcome
    exact ⟨some outcome, rfl⟩
  · intro h
    cases ((final_control_iff_binding false .benefitDenial).mp h)

/-! The extra binding rule supplies final control, while all participation
operations remain identical. This is a comparison, not a policy endorsement. -/
theorem binding_comparison_preserves_participation :
    (process false).accepts = (process true).accepts ∧
    (process false).record = (process true).record ∧
    (process false).revise = (process true).revise ∧
    (process false).decide .benefitDenial true (some false) = false ∧
    (process true).decide .benefitDenial true (some false) = true ∧
    (∀ outcome : Bool, ∃ proposal : Bool, (process true).accepts .benefitDenial proposal ∧
      ∀ override : Option Bool,
        (process true).decide .benefitDenial ((process true).record .benefitDenial proposal) override = outcome) := by
  exact ⟨rfl, rfl, rfl, rfl, rfl,
    (final_control_iff_binding true .benefitDenial).mpr rfl⟩

/-! Joint non-vacuous satisfaction witness. Governance describes the original
denial under review, not the computed outcome of the subsequent review.
It is identical in both procedures. Independent oversight and the existing
person-facing fragments are retained; no complete source theory is asserted. -/
theorem joint_case_satisfying_instance (bindingLocal : Bool) :
    Oversight.governance.highImpact .benefitDenial ∧
    Oversight.governance.affected () .benefitDenial ∧
    CompliantAt Oversight.governance (broadAppealPolicy Oversight.governance) .benefitDenial ∧
    CompliantAt Oversight.governance (harmRemedyPolicy Oversight.governance) .benefitDenial ∧
    ActionableIndependentOversight (Oversight.office true true) .benefitDenial ∧
    (∀ proposal : Bool, (process bindingLocal).accepts .benefitDenial proposal ∧
      (process bindingLocal).record .benefitDenial proposal = proposal) ∧
    (process bindingLocal).revise .benefitDenial false true = true ∧
    (process bindingLocal).decide .benefitDenial true none = true := by
  refine ⟨rfl, rfl, Oversight.person_facing_fragments_satisfied.1,
    Oversight.person_facing_fragments_satisfied.2,
    (Oversight.denial_oversight_iff true true).mpr ⟨rfl, rfl⟩,
    (participation_fragment_satisfied bindingLocal .benefitDenial).1, rfl, ?_⟩
  cases bindingLocal <;> rfl

end Participation
end MagnificaHumanitas

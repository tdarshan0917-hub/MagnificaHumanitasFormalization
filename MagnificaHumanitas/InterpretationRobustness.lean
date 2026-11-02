import MagnificaHumanitas.Examples
import MagnificaHumanitas.Fairness
import MagnificaHumanitas.DistributedControl
import MagnificaHumanitas.Authority
import MagnificaHumanitas.DeveloperResponsibility

namespace MagnificaHumanitas
namespace InterpretationRobustness

/-! Checkpoint 0.14 consolidates existing targets and cases. No new domain,
policy or principal definition is introduced. The three named policies are
not all ordered by strength: broader appeal and harm-triggered correction
capacity make different demands. The additional eight-combination witness
uses the existing responsibility and oversight structures, with a shared
public-benefits assignment. I29/A38 specify this bounded interpretation set.
These are checks of modeled interpretations, not quantification over every
possible reading of the source. Helpers do not inflate the research quota. -/

/-! Exact common evidence needed to meet all THREE existing policies.
This consolidates T1/T3/T4/T5 operational conditions. In particular, the
broad-appeal and remedy-capacity additions must BOTH be supplied; neither
extension substitutes for the other. -/
theorem uniform_safeguards_iff {P A D : Type}
    (g : Governance P A D) (d : D) :
    (CompliantAt g (responsibilityAppealPolicy g) d ∧
      CompliantAt g (broadAppealPolicy g) d ∧
      CompliantAt g (harmRemedyPolicy g) d) ↔
    (g.highImpact d → Provided g d .identifiableResponsibility) ∧
    (∀ p, g.excluded p d → g.appeal p d) ∧
    (∀ p, g.highImpact d → g.affected p d → g.appeal p d) ∧
    (∀ p, g.harmed p d → g.remedyCapacity p d) := by
  constructor
  · intro h
    exact ⟨fun hi => h.1 _ hi,
      fun p he => h.1 (.appeal p) he,
      fun p hi ha => h.2.1 (.appeal p) (Or.inr ⟨hi, ha⟩),
      fun p hh => h.2.2 (.remedyCapacity p) hh⟩
  · intro h
    have hn : CompliantAt g (responsibilityAppealPolicy g) d := by
      intro s hs
      cases s with
      | identifiableResponsibility => exact h.1 hs
      | appeal p => exact h.2.1 p hs
      | remedyCapacity p => exact False.elim hs
    refine ⟨hn,
      (broad_compliance_iff_narrow_and_affected_appeal g d).mpr
        ⟨hn, h.2.2.1⟩,
      (stronger_compliance_iff g d).mpr ⟨hn, h.2.2.2⟩⟩

/-! Reuse two existing records to check incomparability, rather than assume
all interpretations form one ladder. The denied/harmed applicant has appeal
but no correction capacity. The nonexcluded affected applicant has no appeal
and no stipulated harm; the remedy policy does not demand pre-exclusion
appeal. Both retain the common named-assignment requirement. -/
theorem appeal_and_remedy_extensions_are_incomparable :
    CompliantAt (Prototype.governance false)
      (broadAppealPolicy (Prototype.governance false)) () ∧
    (¬ CompliantAt (Prototype.governance false)
      (harmRemedyPolicy (Prototype.governance false)) ()) ∧
    CompliantAt (AppealReview.reviewedDecision false false)
      (harmRemedyPolicy (AppealReview.reviewedDecision false false)) () ∧
    ¬ CompliantAt (AppealReview.reviewedDecision false false)
      (broadAppealPolicy (AppealReview.reviewedDecision false false)) () := by
  refine ⟨?_, Prototype.uncorrectable_not_stronger_compliant, ?_,
    AppealReview.nonexcluded_closed_case_fails_broad⟩
  · intro s hs
    cases s with
    | identifiableResponsibility => exact ⟨(), True.intro, True.intro⟩
    | appeal p => exact Prototype.has_appeal false
    | remedyCapacity p => exact False.elim hs
  · intro s hs
    cases s with
    | identifiableResponsibility => exact ⟨(), True.intro, True.intro⟩
    | appeal p => cases hs
    | remedyCapacity p => cases hs

/-! Shared finite satisfaction witness for the 2x2x2 tested choices:
institutional/individual answerability, narrow/broad appeal, and regime/
decision-level actionable oversight. The remedy-capacity policy also holds.
The Governance assignment and identity fields come from the SAME allocation;
we do not mix incompatible witnesses or claim all eight are whole-source
translations. The impact, affectedness, exclusion and harm triggers are real. -/
theorem joint_repaired_case_all_eight_combinations
    (individual broad decisionLevel : Bool) :
    (Disclosure.office true).assigned =
      (PublicBenefits.allocation true true).assigned ∧
    (Disclosure.office true).identifiable =
      (PublicBenefits.allocation true true).humanIdentifiable ∧
    (Disclosure.office true).highImpact .benefitDenial ∧
    (Disclosure.office true).affected () .benefitDenial ∧
    (Disclosure.office true).excluded () .benefitDenial ∧
    (Disclosure.office true).harmed () .benefitDenial ∧
    (if individual then IndividualReading (PublicBenefits.allocation true true)
      else InstitutionalReading (PublicBenefits.allocation true true)) ∧
    (if broad then CompliantAt (Disclosure.office true)
        (broadAppealPolicy (Disclosure.office true)) .benefitDenial
      else CompliantAt (Disclosure.office true)
        (responsibilityAppealPolicy (Disclosure.office true)) .benefitDenial) ∧
    CompliantAt (Disclosure.office true)
      (harmRemedyPolicy (Disclosure.office true)) .benefitDenial ∧
    (if decisionLevel then
      ActionableIndependentOversight (Oversight.office true true) .benefitDenial
      else ∃ r, (Oversight.office true true).recognized r ∧
        (Oversight.office true true).independent r ∧
        (Oversight.office true true).canReview r) := by
  have hs := Disclosure.named_office_satisfies_three.2.2.2
  refine ⟨rfl, rfl, rfl, rfl, rfl, rfl, ?_, ?_, hs.2.2, ?_⟩
  · cases individual with
    | false => exact PublicBenefits.institution_reading_holds true true
    | true =>
      exact institutional_reading_extends_with_bridges _
        (PublicBenefits.institution_reading_holds true true)
        (PublicBenefits.every_impactful_decision_is_allocated true true)
        (PublicBenefits.named_officers_identifiable true)
  · cases broad with
    | false => exact hs.1
    | true => exact hs.2.1
  · cases decisionLevel with
    | false => exact ⟨true, True.intro, rfl, True.intro⟩
    | true => exact (Oversight.denial_oversight_iff true true).mpr ⟨rfl, rfl⟩

/-! Responsibility is sensitive to actual-assignee identification under
EVERY person-facing policy, even though the institutional fragment is met.
Institution-only answerability is a weaker comparison fragment, not a
certificate that all source responsibility requirements are fulfilled. -/
theorem missing_assignee_fails_all_three_policies :
    InstitutionalReading (PublicBenefits.allocation false true) ∧
    (¬ HumanAnswerability (PublicBenefits.allocation false true) .benefitDenial) ∧
    ∀ policy : Policy Unit PublicBenefits.Decision,
      (policy = responsibilityAppealPolicy (Disclosure.office false) ∨
        policy = broadAppealPolicy (Disclosure.office false) ∨
        policy = harmRemedyPolicy (Disclosure.office false)) →
      ¬ CompliantAt (Disclosure.office false) policy .benefitDenial := by
  refine ⟨PublicBenefits.institution_reading_holds false true,
    PublicBenefits.unnamed_case_has_no_human_answerability true, ?_⟩
  intro policy hp hc
  rcases hp with h | h | h <;> subst policy
  · exact Disclosure.unnamed_office_lacks_identifiable_assignee
      (hc .identifiableResponsibility rfl)
  · exact Disclosure.unnamed_office_lacks_identifiable_assignee
      (hc .identifiableResponsibility rfl)
  · exact Disclosure.unnamed_office_lacks_identifiable_assignee
      (hc .identifiableResponsibility rfl)

/-! The oversight gaps survive choices between the INCOMPARABLE safeguards
policies: all three pass in the same original case, while either missing
remit or missing intervention rejects actionable decision-level oversight.
A recognized independent reviewing body exists in each tested setting. -/
theorem oversight_gap_survives_all_three_policies :
    (∀ policy : Policy Unit PublicBenefits.Decision,
      (policy = responsibilityAppealPolicy (Disclosure.office true) ∨
        policy = broadAppealPolicy (Disclosure.office true) ∨
        policy = harmRemedyPolicy (Disclosure.office true)) →
      CompliantAt (Disclosure.office true) policy .benefitDenial) ∧
    (∀ covered powered : Bool,
      (∃ r, (Oversight.office covered powered).recognized r ∧
        (Oversight.office covered powered).independent r ∧
        (Oversight.office covered powered).canReview r) ∧
      ((covered = false ∨ powered = false) →
        ¬ ActionableIndependentOversight (Oversight.office covered powered) .benefitDenial)) := by
  constructor
  · intro policy hp
    have hs := Disclosure.named_office_satisfies_three.2.2.2
    rcases hp with h | h | h <;> subst policy
    · exact hs.1
    · exact hs.2.1
    · exact hs.2.2
  · intro covered powered
    refine ⟨⟨true, True.intro, rfl, True.intro⟩, ?_⟩
    intro hGap hAction
    have h := (Oversight.denial_oversight_iff covered powered).mp hAction
    cases hGap with
    | inl hc => rw [hc] at h; cases h.1
    | inr hp => rw [hp] at h; cases h.2

/-! T8's already-built stage allocation is jointly satisfiable under all
three safeguards policies, with or without an additional developer assignee
at deployment. This consolidates the finite stage result, not every duty
concerning ethical design or responsibility toward communities. -/
theorem stage_allocation_survives_all_three_policies (extra : Bool) :
    ∀ stage, CompliantAt (DeveloperResponsibility.governance true extra)
        (responsibilityAppealPolicy (DeveloperResponsibility.governance true extra)) stage ∧
      CompliantAt (DeveloperResponsibility.governance true extra)
        (broadAppealPolicy (DeveloperResponsibility.governance true extra)) stage ∧
      CompliantAt (DeveloperResponsibility.governance true extra)
        (harmRemedyPolicy (DeveloperResponsibility.governance true extra)) stage := by
  intro stage
  have h := DeveloperResponsibility.covered_stages_satisfy_existing_fragments extra stage
  exact ⟨broad_appeal_implies_narrow _ _ h.1, h.1, h.2⟩

/-! Positive rule-assessment consequence within the existing fairness case.
If the actual award rule passes the independently adopted base-score audit,
equally eligible channel-indexed applications receive equal awards. Merely
explaining the channel-penalty arithmetic supplies no such audit premise.
The adopted audit is a bounded design-scrutiny test, not all social justice. -/
theorem assessed_rule_protects_equal_eligibility (repaired : Bool)
    (hAssessment : ∀ d : Bool,
      (Fairness.notice repaired d).2.2.2 =
        decide (50 ≤ (Fairness.notice repaired d).1)) :
    ∀ a b : Bool, (Fairness.notice repaired a).2.2.2 =
      (Fairness.notice repaired b).2.2.2 := by
  exact equal_scores_and_common_cutoff_give_equal_results
    (fun d => (Fairness.notice repaired d).1)
    (fun d => (Fairness.notice repaired d).2.2.2) 50 hAssessment (fun _ _ => rfl)

/-! T9 beyond simply renaming recognition as legitimacy. For ANY authority
interpretation that requires the displayed scoped institutional mandate,
the same capable but unrecognized operator lacks that authority. The necessary
condition is an explicit normative premise; it is NOT inferred from the
source for every moral/legal theory. This proves the conditional result
without defining all legitimacy or adding another case. -/
theorem power_without_any_authority_requiring_scoped_mandate
    (authority : Bool → PublicBenefits.Decision → Prop)
    (hNecessary : ∀ role d, authority role d →
      (Authority.office false).recognized role ∧
        (Authority.office false).covers role d) :
    (Authority.office false).canIntervene false .benefitDenial ∧
    ¬ authority false .benefitDenial := by
  refine ⟨Authority.actual_control_available false false .benefitDenial, ?_⟩
  intro hAuthority
  have impossible := (Authority.operator_mandate_iff_granted false).mp
    (hNecessary false .benefitDenial hAuthority)
  cases impossible

/-! Nonempty satisfaction witness for the authority necessary-condition
family. The board meets the scoped mandate while the capable operator does
not. This is an explicit proxy instance, not a proof of moral legitimacy. -/
theorem scoped_authority_family_has_nonempty_witness :
    ∃ authority : Bool → PublicBenefits.Decision → Prop,
      (∀ role d, authority role d →
        (Authority.office false).recognized role ∧
          (Authority.office false).covers role d) ∧
      authority true .benefitDenial ∧
      (Authority.office false).canIntervene false .benefitDenial ∧
      ¬ authority false .benefitDenial := by
  refine ⟨(fun role d => (Authority.office false).recognized role ∧
    (Authority.office false).covers role d), fun _ _ h => h,
    ⟨Or.inl rfl, rfl⟩, ?_⟩
  exact power_without_any_authority_requiring_scoped_mandate _ (fun _ _ h => h)

end InterpretationRobustness
end MagnificaHumanitas

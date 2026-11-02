import MagnificaHumanitas.Oversight

namespace MagnificaHumanitas

/-! Sufficient same-person bridge, not a flagship result. The disclosed,
identified person must also belong to the responsible institution and be
assigned to this decision. A named service contact alone is insufficient. -/
theorem disclosed_assignee_supplies_answerability {I H D : Type}
    (r : ResponsibilityAllocation I H D) (i : I) (d : D) (contacts : List H)
    (hResponsible : r.institutionResponsible i d)
    (hMembers : ∀ h, h ∈ contacts → r.member h i)
    (hIdentified : ∀ h, h ∈ contacts → r.humanIdentifiable h)
    (hAssignee : ∃ h, h ∈ contacts ∧ r.assigned h d) :
    HumanAnswerability r d := by
  obtain ⟨h, hc, ha⟩ := hAssignee
  exact ⟨i, h, hResponsible, hMembers h hc, ha, hIdentified h hc⟩

namespace Disclosure

open PublicBenefits (Officer Decision)

/-! Retrievable public notice, not a Transparency=True label. It contains
concrete promised safeguards, score, cutoff, computed result and contacts.
The routine inquiry has no denial notice. The named flag publishes the case
officer in addition to the help-desk contact. I25/A31/A32 are explicit.
No fairness, complete transparency or legal compliance is claimed. -/
def notice (named : Bool) (d : Decision) :
    Option (List (Safeguard Unit) × Nat × Nat × Bool × List Officer) :=
  match d with
  | .routineInquiry => none
  | .benefitDenial => some
      ([.identifiableResponsibility, .appeal (), .remedyCapacity ()],
        47, 50, decide (50 ≤ 47),
        if named then [.publicContact, .caseOfficer] else [.publicContact])

def office (named : Bool) : Governance Unit Officer Decision where
  affected _ d := d = .benefitDenial
  excluded _ d := d = .benefitDenial
  harmed _ d := d = .benefitDenial
  highImpact := (PublicBenefits.allocation named true).highImpact
  assigned := (PublicBenefits.allocation named true).assigned
  identifiable := (PublicBenefits.allocation named true).humanIdentifiable
  appeal := Oversight.procedures.HasAppeal
  remedyCapacity := Oversight.procedures.HasRemedyCapacity
  explained d := match notice named d with
    | none => False
    | some (_, score, cutoff, result, _) => (result = true ↔ cutoff ≤ score)
  humanReviewed _ := True
  producedByAI d := d = .benefitDenial

/-! The published promises have actual content and match every requirement
of the existing harm-remedy policy for this denial. This says what is promised,
not that the promise is fulfilled. -/
theorem commitments_match_existing_policy (named : Bool) (s : Safeguard Unit) :
    s ∈ ([.identifiableResponsibility, .appeal (), .remedyCapacity ()] :
      List (Safeguard Unit)) ↔
      (harmRemedyPolicy (office named)).required .benefitDenial s := by
  cases s with
  | identifiableResponsibility => simp [harmRemedyPolicy, office, PublicBenefits.allocation]
  | appeal p => cases p; simp [harmRemedyPolicy, office]
  | remedyCapacity p => cases p; simp [harmRemedyPolicy, office]

/-! Declared minimal disclosure fragment: retrievable numerical explanation,
computed result consistent with the cutoff, and genuinely identified contacts.
It deliberately does not require publication of the actual case assignee. -/
theorem truthful_disclosure_available (named : Bool) :
    ∃ commitments contacts,
      notice named .benefitDenial = some (commitments, 47, 50, false, contacts) ∧
      (false = true ↔ 50 ≤ 47) ∧
      Officer.publicContact ∈ contacts ∧
      (∀ h, h ∈ contacts → (office named).identifiable h) ∧
      (∀ s, s ∈ commitments ↔
        (harmRemedyPolicy (office named)).required .benefitDenial s) := by
  refine ⟨[.identifiableResponsibility, .appeal (), .remedyCapacity ()],
    (if named then [.publicContact, .caseOfficer] else [.publicContact]),
    rfl, by decide, ?_, ?_, commitments_match_existing_policy named⟩
  · cases named <;> simp
  · cases named <;> simp [office, PublicBenefits.allocation]

theorem unnamed_office_lacks_identifiable_assignee :
    ¬ Provided (office false) .benefitDenial .identifiableResponsibility := by
  intro h
  obtain ⟨officer, ha, hn⟩ := h
  exact PublicBenefits.unnamed_case_has_no_human_answerability true
    ⟨(), officer, True.intro, True.intro, ha, hn⟩

/-! C1 and the bounded T10 declaration test. The notice really explains the
denial and lists an identified contact; a known institution assigns the case
internally. Yet nobody assigned to the denial is identifiable. The public
commitments are requirements, so their existence does not establish compliance.
This case satisfies the displayed minimal disclosure fragment, not a full
transparency requirement that already demands an identified actual assignee. -/
theorem published_ethics_and_explanation_without_answerability :
    ∃ commitments contacts,
      notice false .benefitDenial = some (commitments, 47, 50, false, contacts) ∧
      (false = true ↔ 50 ≤ 47) ∧
      Officer.publicContact ∈ contacts ∧
      (∀ h, h ∈ contacts → (office false).identifiable h) ∧
      (∀ s, s ∈ commitments ↔
        (harmRemedyPolicy (office false)).required .benefitDenial s) ∧
      (office false).highImpact .benefitDenial ∧
      (office false).affected () .benefitDenial ∧
      (office false).excluded () .benefitDenial ∧
      (office false).explained .benefitDenial ∧
      InstitutionalReading (PublicBenefits.allocation false true) ∧
      HasDecisionAllocation (PublicBenefits.allocation false true) ∧
      (¬ HumanAnswerability (PublicBenefits.allocation false true) .benefitDenial) ∧
      (¬ Provided (office false) .benefitDenial .identifiableResponsibility) ∧
      ¬ CompliantAt (office false) (harmRemedyPolicy (office false)) .benefitDenial := by
  obtain ⟨commitments, contacts, hd, ht, hc, hi, hp⟩ := truthful_disclosure_available false
  refine ⟨commitments, contacts, hd, ht, hc, hi, hp, rfl, rfl, rfl,
    (by change (false = true ↔ 50 ≤ 47); decide), PublicBenefits.institution_reading_holds false true,
    PublicBenefits.every_impactful_decision_is_allocated false true,
    PublicBenefits.unnamed_case_has_no_human_answerability true,
    unnamed_office_lacks_identifiable_assignee, ?_⟩
  intro h
  exact unnamed_office_lacks_identifiable_assignee
    (h .identifiableResponsibility rfl)

/-! Stronger disclosure repair: the published case officer is the very person
assigned to the denial. The same-person bridge supplies answerability, and the
office satisfies all three currently encoded policies for this denial. -/
theorem named_office_satisfies_three :
    Officer.caseOfficer ∈ ([.publicContact, .caseOfficer] : List Officer) ∧
    (office true).assigned .caseOfficer .benefitDenial ∧
    HumanAnswerability (PublicBenefits.allocation true true) .benefitDenial ∧
    CompliantAt (office true) (responsibilityAppealPolicy (office true)) .benefitDenial ∧
    CompliantAt (office true) (broadAppealPolicy (office true)) .benefitDenial ∧
    CompliantAt (office true) (harmRemedyPolicy (office true)) .benefitDenial := by
  have hAnswer : HumanAnswerability (PublicBenefits.allocation true true) .benefitDenial := by
    apply disclosed_assignee_supplies_answerability _ () _ [.publicContact, .caseOfficer]
    · exact True.intro
    · intro _ _; exact True.intro
    · intro _ _; exact Or.inr rfl
    · exact ⟨.caseOfficer, by simp, Or.inr ⟨rfl, rfl⟩⟩
  refine ⟨by simp, Or.inr ⟨rfl, rfl⟩, hAnswer, ?_, ?_, ?_⟩ <;>
    intro s _hs <;> cases s with
  | identifiableResponsibility => exact ⟨.caseOfficer, Or.inr ⟨rfl, rfl⟩, Or.inr rfl⟩
  | appeal p => exact ⟨(), True.intro, True.intro⟩
  | remedyCapacity p => exact ⟨(), True.intro, True.intro⟩

/-! T10 paired test: identical promises and numerical explanation coexist
with different actual compliance. Only the published/identifiable assignee
changes, not the policy, score, cutoff, computed result or internal assignment. -/
theorem same_commitment_different_compliance :
    ∃ commitments,
      notice false .benefitDenial = some
        (commitments, 47, 50, false, [.publicContact]) ∧
      notice true .benefitDenial = some
        (commitments, 47, 50, false, [.publicContact, .caseOfficer]) ∧
      (¬ CompliantAt (office false) (harmRemedyPolicy (office false)) .benefitDenial) ∧
      CompliantAt (office true) (harmRemedyPolicy (office true)) .benefitDenial := by
  refine ⟨[.identifiableResponsibility, .appeal (), .remedyCapacity ()],
    rfl, rfl, ?_, named_office_satisfies_three.2.2.2.2.2⟩
  intro h
  exact unnamed_office_lacks_identifiable_assignee
    (h .identifiableResponsibility rfl)

theorem disclosure_repair_preserves_assignment_and_channels :
    (office false).assigned = (office true).assigned ∧
    (office false).highImpact = (office true).highImpact ∧
    (office false).appeal = (office true).appeal ∧
    (office false).remedyCapacity = (office true).remedyCapacity ∧
    (harmRemedyPolicy (office false)).required = (harmRemedyPolicy (office true)).required := by
  exact ⟨rfl, rfl, rfl, rfl, rfl⟩

end Disclosure
end MagnificaHumanitas

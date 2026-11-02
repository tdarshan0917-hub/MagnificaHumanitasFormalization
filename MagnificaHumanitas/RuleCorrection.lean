import MagnificaHumanitas.InterpretationRobustness

namespace MagnificaHumanitas
namespace RuleCorrection

/-! Existing benefits design/use contexts and roles. False = the assigned
 developer/design reviewer; true = the deployer. Criteria-revision power
 concerns the design context Sum.inl (), not a power inferred from assignment
 to an individual denial. This is an explicit institutional case fact.
 I30/A39/A40; source motivation MH-019/036/038/040 (§§104,109,111). -/
def allocation (criteriaPower : Bool) :
    ResponsibilityAllocation Unit Bool (Sum Unit PublicBenefits.Decision) where
  highImpact := (DeveloperResponsibility.governance true false).highImpact
  institutionResponsible _ _ := True
  institutionIdentifiable _ := True
  member _ _ := True
  humanIdentifiable := (DeveloperResponsibility.governance true false).identifiable
  assigned := (DeveloperResponsibility.governance true false).assigned
  canCorrect actor context := actor = false ∧ context = .inl () ∧ criteriaPower = true

/-! A concrete rule-revision process, not a new principal abstraction.
The Bool current/proposal values select the EXISTING Fairness.notice rules:
false retains the 15-point assisted-intake penalty; true removes it.
Requests are accepted, recorded and amendable. Option Bool identifies the
acting role (none means no actor). A recorded proposal becomes OPERATIVE only
if that actor is assigned and empowered for criteria revision and both actual
computed awards pass the adopted base-score cutoff test. Failed validation
leaves the current rule in force. This models perfect enforcement of these
checks; it is not an authentication or delivery implementation. -/
def process (criteriaPower : Bool) : ConsultationProcess Bool where
  accepts _ _ := True
  record _ request := request
  revise _ _ amendment := amendment
  decide current recorded actingRole := match actingRole with
    | none => current
    | some actor => by
      haveI : Decidable ((allocation criteriaPower).assigned actor (.inl ())) := by
        change Decidable (actor = false)
        infer_instance
      haveI : Decidable ((allocation criteriaPower).canCorrect actor (.inl ())) := by
        change Decidable (actor = false ∧
          (Sum.inl () : Sum Unit PublicBenefits.Decision) = .inl () ∧ criteriaPower = true)
        infer_instance
      exact if (allocation criteriaPower).assigned actor (.inl ()) ∧
          (allocation criteriaPower).canCorrect actor (.inl ()) ∧
          (Fairness.notice recorded false).2.2.2 =
            decide (50 ≤ (Fairness.notice recorded false).1) ∧
          (Fairness.notice recorded true).2.2.2 =
            decide (50 ≤ (Fairness.notice recorded true).1)
      then recorded else current

/-! Actual application notices are computed from the process's returned
operative rule selector. Updating a request record alone cannot change this
artifact. This is closed finite case data over the existing scoring family. -/
def notice (power current request : Bool) (actingRole : Option Bool) (channel : Bool) :
    Nat × Nat × Nat × Bool :=
  Fairness.notice ((process power).decide current
    ((process power).record current request) actingRole) channel

theorem requests_are_recorded_and_amendable (power current : Bool) :
    (∀ request, (process power).accepts current request ∧
      (process power).record current request = request) ∧
    (∀ old amendment, (process power).revise current old amendment = amendment) ∧
    (process power).record current false ≠ (process power).record current true := by
  exact ⟨fun _ => ⟨True.intro, rfl⟩, fun _ _ => rfl, Bool.noConfusion⟩

/-! Named design assignment and authority for that SAME context are distinct.
The deployer really handles the denial, but is not assigned to design review.
This does not infer criteria power from ordinary appeal/correction capacity. -/
theorem criteria_authority_is_scoped (power : Bool) :
    HumanAnswerability (allocation power) (.inl ()) ∧
    (ActionableResponsibility (allocation power) (.inl ()) ↔ power = true) ∧
    (allocation power).assigned true (.inr .benefitDenial) ∧
    ¬ (allocation power).assigned true (.inl ()) := by
  refine ⟨⟨(), false, True.intro, True.intro, rfl, True.intro⟩, ?_,
    Or.inl ⟨rfl, rfl⟩, ?_⟩
  · constructor
    · intro h
      obtain ⟨_, _, _, _, _, _, hp⟩ := h
      exact hp.2.2
    · intro hp
      exact ⟨(), false, True.intro, True.intro, rfl, True.intro, rfl, rfl, hp⟩
  · intro h
    cases h

/-! An actual recorded objection and a named design assignee do not update
the operative rule without criteria-changing power. The application notices
still compute different awards for equal eligibility. -/
theorem recorded_objection_leaves_penalty_operative :
    (process false).record false true = true ∧
    (process false).revise false false true = true ∧
    HumanAnswerability (allocation false) (.inl ()) ∧
    (process false).decide false true (some false) = false ∧
    notice false false true (some false) false = (60, 0, 50, true) ∧
    notice false false true (some false) true = (60, 15, 50, false) := by
  exact ⟨rfl, rfl, (criteria_authority_is_scoped false).1, rfl, rfl, rfl⟩

/-! A real denial assignee cannot use that assignment to edit design criteria.
Even when the design reviewer is empowered, the deployment role is rejected. -/
theorem denial_assignment_does_not_authorize_criteria_revision :
    (allocation true).assigned true (.inr .benefitDenial) ∧
    (process true).record false true = true ∧
    (process true).decide false true (some true) = false ∧
    notice true false true (some true) true = (60, 15, 50, false) := by
  exact ⟨Or.inl ⟨rfl, rfl⟩, rfl, rfl, rfl⟩

/-! Exact result for a valid recorded request to remove the penalty from the
initial bad rule. Assignment, scoped power and acting role are enforced by
the evaluator, not just listed in a report beside an unchanged scoring rule. -/
theorem operative_correction_iff_scoped_authority (power : Bool) (actor : Option Bool) :
    (process power).decide false true actor = true ↔
      power = true ∧ actor = some false := by
  cases power <;> cases actor with
  | none => decide
  | some role => cases role <;> decide

/-! Positive T7/T8 connection: an amended/recorded proposal reaches the
operative rule through an assigned, empowered design reviewer, and the actual
application awards change. Person-facing safeguards pass for the resulting
case, in all three existing policies. The original eligibility/cutoff and
recourse channels are preserved by the comparison below. -/
theorem authorized_correction_changes_rule_and_awards :
    (process true).revise false false true = true ∧
    ActionableResponsibility (allocation true) (.inl ()) ∧
    (process true).decide false
      ((process true).record false ((process true).revise false false true))
      (some false) = true ∧
    notice true false true (some false) false = (60, 0, 50, true) ∧
    notice true false true (some false) true = (60, 0, 50, true) ∧
    (∀ channel, (Fairness.office
        ((process true).decide false ((process true).record false true) (some false))).explained channel ∧
      CompliantAt (Fairness.office true) (responsibilityAppealPolicy (Fairness.office true)) channel ∧
      CompliantAt (Fairness.office true) (broadAppealPolicy (Fairness.office true)) channel ∧
      CompliantAt (Fairness.office true) (harmRemedyPolicy (Fairness.office true)) channel) := by
  refine ⟨rfl, (criteria_authority_is_scoped true).2.1.mpr rfl,
    rfl, rfl, rfl, ?_⟩
  intro channel
  have h := Fairness.existing_safeguards_satisfied true channel
  exact ⟨Fairness.truthful_rule_explanations true channel,
    h.2.2.2.2.1, h.2.2.2.2.2.1, h.2.2.2.2.2.2⟩

/-! The adopted audit prevents returning from a valid rule to the known bad
penalty rule, even when a criteria-authorized actor proposes that reversion.
This is a property of the finite candidate-rule set and validation guard. -/
theorem valid_rule_is_preserved (power proposal : Bool) (actor : Option Bool) :
    (process power).decide true ((process power).record true proposal) actor = true := by
  cases power <;> cases proposal <;> cases actor with
  | none => rfl
  | some role => cases role <;> decide

/-! Positive invariant over ANY finite sequence of the modeled revision
attempts, not just the one successful correction. Each update records a
proposal, checks its actor and audit, and returns the next operative selector.
No unmodeled edits or enforcement failures are included. -/
theorem valid_rule_survives_all_finite_revision_attempts (power : Bool)
    (attempts : List (Bool × Option Bool)) :
    attempts.foldl (fun current attempt => (process power).decide current
      ((process power).record current attempt.1) attempt.2) true = true := by
  induction attempts with
  | nil => rfl
  | cons attempt rest ih =>
    change rest.foldl (fun current next => (process power).decide current
      ((process power).record current next.1) next.2)
      ((process power).decide true
        ((process power).record true attempt.1) attempt.2) = true
    rw [valid_rule_is_preserved]
    exact ih

/-! Isolate the changed permissions/rule. Request recording, allocation,
identity, relevant scores, cutoff, and person-facing channels stay fixed.
Award-dependent exclusion/harm can change with the corrected calculation. -/
theorem correction_preserves_records_allocation_and_channels :
    (process false).accepts = (process true).accepts ∧
    (process false).record = (process true).record ∧
    (process false).revise = (process true).revise ∧
    (allocation false).assigned = (allocation true).assigned ∧
    (allocation false).humanIdentifiable = (allocation true).humanIdentifiable ∧
    (∀ channel,
      (notice false false true (some false) channel).1 =
        (notice true false true (some false) channel).1 ∧
      (notice false false true (some false) channel).2.2.1 =
        (notice true false true (some false) channel).2.2.1) ∧
    (Fairness.office false).assigned = (Fairness.office true).assigned ∧
    (Fairness.office false).identifiable = (Fairness.office true).identifiable ∧
    (Fairness.office false).appeal = (Fairness.office true).appeal ∧
    (Fairness.office false).remedyCapacity = (Fairness.office true).remedyCapacity := by
  exact ⟨rfl, rfl, rfl, rfl, rfl, fun _ => ⟨rfl, rfl⟩, rfl, rfl, rfl, rfl⟩

end RuleCorrection
end MagnificaHumanitas

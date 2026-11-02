import MagnificaHumanitas.RuleCorrection

namespace MagnificaHumanitas
namespace AppealCorrection

/-! Existing benefits case, two channels: false = independent appeal/review
board; true = case-correction office. The office accepts correction requests
but cannot conduct the review; the board can review but cannot itself edit
the case record. These are capacities, not completed actions. -/
def procedures (access power : Bool) : ProcedureSystem Unit Unit Bool where
  accepts _ _ channel := channel = true ∨ access = true
  canReview channel := channel = false
  canCorrect channel := channel = true ∧ power = true

/-! Closed finite appeal/review/update instance, reusing ConsultationProcess.
Decision Bool is the stored award: false = already issued denial, true = grant.
record computes admitted submission; revise computes a completed review finding
from that record, an actual review attempt, and disagreement with reassessment.
decide sends the finding to the chosen channel and applies the update only
when the review-to-correction handoff exists and the office has correction power.

The reassessment consumes the corrected operative rule from checkpoint 0.15.
These functions model an ordered dataflow, not authentication or guaranteed
exercise. The findings supplied to decide are restricted to the composed path
shown in the theorems. I31/A41/A42; MH-022/023/025/031 (§§105–108). -/
def process (access power handoff : Bool) : ConsultationProcess Bool where
  accepts _ request := request = true ∧ access = true
  record _ request := request && access
  revise current admitted reviewAttempt := admitted && reviewAttempt &&
    decide (current ≠ (RuleCorrection.notice true false true (some false) true).2.2.2)
  decide current finding target := match target with
    | some true => if finding && handoff && power
        then (RuleCorrection.notice true false true (some false) true).2.2.2
        else current
    | _ => current

/-! Snapshot of the ORIGINAL denial and its prospective safeguards. The
workflow above returns the updated award separately; this record does not
claim the person remains excluded after correction. Handoff is intentionally
not inferred from acceptance/review/correction capacity. -/
def governance (access power : Bool) : Governance Unit PublicBenefits.Officer Unit where
  affected _ _ := True
  excluded _ _ := True
  harmed _ _ := True
  highImpact _ := True
  assigned h _ := (Fairness.office false).assigned h true
  identifiable := (Fairness.office false).identifiable
  appeal := (procedures access power).HasAppeal
  remedyCapacity := (procedures access power).HasRemedyCapacity
  explained _ := (Fairness.office false).explained true
  humanReviewed _ := False
  producedByAI _ := True

/-! Intervention is now an actual correction path reachable through the
independent board and implementing office, not an unconnected power flag.
Board independence and recognition remain explicit institutional case facts. -/
def oversight (access power handoff : Bool) : OversightSystem Bool PublicBenefits.Decision where
  recognized _ := True
  independent role := role = false
  covers _ d := d = .benefitDenial
  canReview role := role = false
  canIntervene role d := role = false ∧ d = .benefitDenial ∧
    ∃ request reviewAttempt target,
      (process access power handoff).decide false
        ((process access power handoff).revise false
          ((process access power handoff).record false request) reviewAttempt) target = true

theorem static_capacities_iff (access power : Bool) :
    ((procedures access power).HasAppeal () () ↔ access = true) ∧
    ((procedures access power).HasRemedyCapacity () () ↔ power = true) := by
  constructor
  · constructor
    · rintro ⟨channel, ha, hr⟩
      change channel = false at hr
      subst channel
      cases ha with
      | inl h => cases h
      | inr h => exact h
    · intro ha
      exact ⟨false, Or.inr ha, rfl⟩
  · constructor
    · rintro ⟨_, _, hp⟩
      exact hp.2
    · intro hp
      exact ⟨true, Or.inl rfl, rfl, hp⟩

/-! The implementing office's capacity agrees with the named case officer's
existing decision-scoped authority. It is not authority over design criteria
or a promise to restore every consequence of the earlier denial. -/
theorem correction_capacity_matches_scoped_officer (power : Bool) :
    (procedures true power).canCorrect true ↔
      ActionableResponsibility (PublicBenefits.allocation true power) .benefitDenial := by
  cases power with
  | false =>
    constructor
    · intro h; cases h.2
    · intro h
      exact False.elim (PublicBenefits.named_case_without_power_not_actionable h)
  | true =>
    constructor
    · intro _; exact PublicBenefits.identified_powered_case_is_actionable
    · intro _; exact ⟨rfl, rfl⟩

/-! Exact conditions for this COMPOSED action path to change the stored
already-issued denial. Review completion, handoff and actual update are
additional conditions beyond static capacity. No automatic success is assumed. -/
theorem completed_path_iff (access power handoff request reviewAttempt : Bool)
    (target : Option Bool) :
    (process access power handoff).decide false
      ((process access power handoff).revise false
        ((process access power handoff).record false request) reviewAttempt) target = true ↔
      access = true ∧ power = true ∧ handoff = true ∧ request = true ∧
        reviewAttempt = true ∧ target = some true := by
  cases access <;> cases power <;> cases handoff <;> cases request <;>
    cases reviewAttempt <;> cases target with
  | none => decide
  | some channel => cases channel <;> decide

/-! Static fragment satisfaction with an actual affected, excluded high-impact
person. Neither this checklist nor its remedy-capacity field asserts that a
particular review finding has been delivered or an update performed. -/
theorem person_facing_policies_hold :
    (governance true true).affected () () ∧ (governance true true).excluded () () ∧
    (governance true true).highImpact () ∧
    CompliantAt (governance true true) (responsibilityAppealPolicy (governance true true)) () ∧
    CompliantAt (governance true true) (broadAppealPolicy (governance true true)) () ∧
    CompliantAt (governance true true) (harmRemedyPolicy (governance true true)) () := by
  refine ⟨True.intro, True.intro, True.intro, ?_, ?_, ?_⟩ <;>
    intro s _hs <;> cases s with
  | identifiableResponsibility => exact ⟨.caseOfficer, rfl, Or.inr rfl⟩
  | appeal p => exact ⟨false, Or.inr rfl, rfl⟩
  | remedyCapacity p => exact ⟨true, Or.inl rfl, rfl, rfl⟩

/-! Capacity/connection separation: the appeal is actually admitted and
reviewed, but no handoff means the stored denial remains. All three current
person-facing checklists still hold as prospective-capacity specifications. -/
theorem static_safeguards_do_not_supply_handoff :
    CompliantAt (governance true true) (broadAppealPolicy (governance true true)) () ∧
    CompliantAt (governance true true) (harmRemedyPolicy (governance true true)) () ∧
    (process true true false).record false true = true ∧
    (process true true false).revise false
      ((process true true false).record false true) true = true ∧
    (process true true false).decide false
      ((process true true false).revise false
        ((process true true false).record false true) true) (some true) = false := by
  exact ⟨person_facing_policies_hold.2.2.2.2.1,
    person_facing_policies_hold.2.2.2.2.2, rfl, rfl, rfl⟩

theorem review_without_application_keeps_denial :
    (process true true true).revise false
      ((process true true true).record false true) true = true ∧
    (process true true true).decide false
      ((process true true true).revise false
        ((process true true true).record false true) true) none = false := by
  exact ⟨rfl, rfl⟩

theorem application_before_review_keeps_denial :
    (process true true true).decide false false (some true) = false ∧
    (process true true true).decide false
      ((process true true true).revise false
        ((process true true true).record false true) false) (some true) = false := by
  exact ⟨rfl, rfl⟩

/-! Positive ordered trace: admitted request -> completed review finding ->
correct office receives/applies it -> stored award changes to the reassessed
grant. This is correction of the individual record after criteria revision,
not merely recomputation of an unrecorded hypothetical application. -/
theorem ordered_path_corrects_existing_denial :
    (process true true true).record false true = true ∧
    (process true true true).revise false
      ((process true true true).record false true) true = true ∧
    ActionableResponsibility (PublicBenefits.allocation true true) .benefitDenial ∧
    (process true true true).decide false
      ((process true true true).revise false
        ((process true true true).record false true) true) (some true) =
      (RuleCorrection.notice true false true (some false) true).2.2.2 ∧
    (process true true true).decide false
      ((process true true true).revise false
        ((process true true true).record false true) true) (some true) = true := by
  exact ⟨rfl, rfl, PublicBenefits.identified_powered_case_is_actionable, rfl, rfl⟩

theorem available_powers_without_exercise_keep_denial :
    (procedures true true).HasAppeal () () ∧
    (procedures true true).HasRemedyCapacity () () ∧
    (process true true true).record false false = false ∧
    (process true true true).decide false
      ((process true true true).revise false
        ((process true true true).record false false) false) none = false := by
  exact ⟨(static_capacities_iff true true).1.mpr rfl,
    (static_capacities_iff true true).2.mpr rfl, rfl, rfl⟩

/-! T6's bounded intervention proxy is linked to a usable ordered correction
path. The independent board can cause an implemented update through the
separate office exactly when access, power and handoff all exist. This is
capacity, not a theorem that agents will choose to exercise it. -/
theorem actionable_board_iff_path_available (access power handoff : Bool) :
    ActionableIndependentOversight (oversight access power handoff) .benefitDenial ↔
      access = true ∧ power = true ∧ handoff = true := by
  constructor
  · rintro ⟨role, _, hi, _, _, hAction⟩
    obtain ⟨_, _, request, reviewAttempt, target, hFinal⟩ := hAction
    have h := (completed_path_iff access power handoff request reviewAttempt target).mp hFinal
    exact ⟨h.1, h.2.1, h.2.2.1⟩
  · rintro ⟨ha, hp, hh⟩
    rw [ha, hp, hh]
    exact ⟨false, True.intro, rfl, rfl, rfl,
      rfl, rfl, true, true, some true, rfl⟩

/-! The paired handoff repair changes the connection, while acceptance,
recording and completed review behavior remain fixed. The original Governance
and prospective channels are literally the same record in both comparisons. -/
theorem handoff_repair_preserves_submission_and_review :
    (process true true false).accepts = (process true true true).accepts ∧
    (process true true false).record = (process true true true).record ∧
    (process true true false).revise = (process true true true).revise ∧
    (oversight true true false).recognized = (oversight true true true).recognized ∧
    (oversight true true false).independent = (oversight true true true).independent ∧
    (oversight true true false).covers = (oversight true true true).covers ∧
    (oversight true true false).canReview = (oversight true true true).canReview := by
  exact ⟨rfl, rfl, rfl, rfl, rfl, rfl, rfl⟩

end AppealCorrection
end MagnificaHumanitas

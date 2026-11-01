import MagnificaHumanitas.Responsibility

namespace MagnificaHumanitas
namespace HighStakes

/-! A bounded hypothetical hazardous execution, not a claim about all AI.
Loss is a physical outcome; the record is administrative. The available
actions do not reverse physical loss. These dynamics are case assumptions
(I14/I17-I19; A11/A16-A18), not deductions from the source document.
The execution guard honors a delivered stop, not merely a requested stop. -/
structure State where
  loss : Bool := false
  stopRequested : Bool := false
  stopDelivered : Bool := false
  recordCorrected : Bool := false
  deriving Repr, DecidableEq

inductive Event where
  | requestStop
  | deliverStop
  | execute
  | correctRecord
  | review
  deriving Repr, DecidableEq

def step (s : State) : Event → State
  | .requestStop => { s with stopRequested := true }
  | .deliverStop => { s with stopDelivered := s.stopDelivered || s.stopRequested }
  | .execute => { s with loss := s.loss || !s.stopDelivered }
  | .correctRecord => { s with recordCorrected := true }
  | .review => s

def run (s : State) : List Event → State
  | [] => s
  | e :: es => run (step s e) es

def RestorationPossible (s : State) : Prop :=
  ∃ events, (run s events).loss = false

/-! Derived invariants of the stated transition rules. -/
theorem loss_persists_step (s : State) (e : Event) (h : s.loss = true) :
    (step s e).loss = true := by
  cases e <;> simp [step, h]

theorem loss_persists_run (s : State) (events : List Event) (h : s.loss = true) :
    (run s events).loss = true := by
  induction events generalizing s with
  | nil => exact h
  | cons e es ih =>
    exact ih (step s e) (loss_persists_step s e h)

theorem loss_not_restorable (s : State) (h : s.loss = true) :
    ¬ RestorationPossible s := by
  intro hr
  obtain ⟨events, he⟩ := hr
  have hp := loss_persists_run s events h
  rw [hp] at he
  cases he

theorem protected_step (s : State) (e : Event)
    (hLoss : s.loss = false) (hStop : s.stopDelivered = true) :
    (step s e).loss = false ∧ (step s e).stopDelivered = true := by
  cases e <;> simp [step, hLoss, hStop]

/-! Conditional guarantee over all finite continuations in THIS event model.
It assumes the loss-free state and already-delivered stop; it does not prove
that an actual operator detects the hazard or delivers a stop in time. -/
theorem timely_stop_protects_all_continuations (s : State) (events : List Event)
    (hLoss : s.loss = false) (hStop : s.stopDelivered = true) :
    (run s events).loss = false ∧ (run s events).stopDelivered = true := by
  induction events generalizing s with
  | nil => exact ⟨hLoss, hStop⟩
  | cons e es ih =>
    have hp := protected_step s e hLoss hStop
    exact ih (step s e) hp.1 hp.2

/-! The two traces contain the same events; delivery/execution order differs. -/
def lateControl : State :=
  run {} [.requestStop, .execute, .deliverStop, .correctRecord]

def timelyControl : State :=
  run {} [.requestStop, .deliverStop, .execute, .correctRecord]

theorem requested_stop_without_delivery_does_not_prevent_loss :
    let s := run {} [.requestStop, .execute]
    s.stopRequested = true ∧ s.stopDelivered = false ∧ s.loss = true := by
  exact ⟨rfl, rfl, rfl⟩

theorem late_control_corrects_record_without_restoring :
    lateControl.stopRequested = true ∧ lateControl.stopDelivered = true ∧
    lateControl.recordCorrected = true ∧ lateControl.loss = true ∧
    ¬ RestorationPossible lateControl := by
  exact ⟨rfl, rfl, rfl, rfl, loss_not_restorable _ rfl⟩

theorem same_final_control_flags_different_outcomes :
    lateControl.stopRequested = timelyControl.stopRequested ∧
    lateControl.stopDelivered = timelyControl.stopDelivered ∧
    lateControl.recordCorrected = timelyControl.recordCorrected ∧
    lateControl.loss = true ∧ timelyControl.loss = false := by
  exact ⟨rfl, rfl, rfl, rfl, rfl⟩

/-! A named officer has authority to correct the decision RECORD here.
I17 fixes this scope: canCorrect is not authority/capacity to restore the
physical outcome. The actual correctRecord transition implements that edit. -/
def recordCorrectionAllocation : ResponsibilityAllocation Unit Unit Unit where
  highImpact _ := True
  institutionResponsible _ _ := True
  institutionIdentifiable _ := True
  member _ _ := True
  humanIdentifiable _ := True
  assigned _ _ := True
  canCorrect _ _ := True

theorem named_record_correction_authority :
    ActionableResponsibility recordCorrectionAllocation () := by
  exact ⟨(), (), True.intro, True.intro, True.intro, True.intro, True.intro⟩

/-! A first-class separation witness with existing responsibility machinery.
It does not refute a specification that explicitly requires full restoration;
it shows why that stronger protection cannot be silently inferred. -/
theorem responsibility_and_record_correction_do_not_restore :
    ∃ s : State,
      ActionableResponsibility recordCorrectionAllocation () ∧
      s.stopDelivered = true ∧ s.recordCorrected = true ∧ s.loss = true ∧
      ¬ RestorationPossible s := by
  exact ⟨lateControl, named_record_correction_authority,
    rfl, rfl, rfl, loss_not_restorable _ rfl⟩

theorem timely_case_satisfying_instance :
    ∃ s : State,
      ActionableResponsibility recordCorrectionAllocation () ∧
      s.stopRequested = true ∧ s.stopDelivered = true ∧
      s.recordCorrected = true ∧ s.loss = false := by
  exact ⟨timelyControl, named_record_correction_authority, rfl, rfl, rfl, rfl⟩

theorem timely_trace_stays_loss_free (events : List Event) :
    (run timelyControl events).loss = false := by
  exact (timely_stop_protects_all_continuations timelyControl events rfl rfl).1

end HighStakes
end MagnificaHumanitas

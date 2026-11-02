import MagnificaHumanitas.Participation

namespace MagnificaHumanitas
namespace DistributedControl

open PublicBenefits (Decision)

/-! C5: a concrete two-controller pause protocol in the existing benefits
case, instantiated in ConsultationProcess rather than adding an ontology.

The operator supplies operatorHold; an independent board supplies boardHold
through the Option Bool input. None/some false release the board's hold;
some true asserts it. These are separate coordinates with distinct roles.
The community's Bool request is accepted, recorded and amendable.

Here the Bool OUTPUT means paused, not grant/deny. A pause suspends execution
of the original denial; it neither awards the benefit nor corrects the record.
Initially only external holds count. The paired repair also honors the local
request. No modeled actor can cancel another actor's asserted hold. This
composition is an explicit case assumption, not a universal safety theorem.
Source motivation MH-032/036 (§§108–109); I28/A36/A37. -/
def process (localEnabled operatorHold : Bool) : ConsultationProcess Decision where
  accepts d _ := d = .benefitDenial
  record _ request := request
  revise _ _ amendment := amendment
  decide d recorded boardHold := match d with
    | .routineInquiry => false
    | .benefitDenial => operatorHold || boardHold.getD false || (localEnabled && recorded)

/-! False is the operator; true is the independent board. Intervention is
computed from changing that role's own coordinate with the other released:
a baseline unpaused state becomes paused. It is not a stipulated capability
flag or the ability to force every outcome against every other controller.
Recognition, independence, review and remit are explicit case evidence. -/
def controllers (localEnabled : Bool) : OversightSystem Bool Decision where
  recognized _ := True
  independent role := role = true
  covers _ d := d = .benefitDenial
  canReview _ := True
  canIntervene role d := d = .benefitDenial ∧ ∃ request : Bool,
    (process localEnabled false).decide d request none = false ∧
    (process localEnabled (!role)).decide d request
      (if role then some true else none) = true

/-! Real request/record/amendment behavior. This is only a request-handling
fragment, not C6's stronger conditional outcome-influence fragment. -/
theorem requests_are_received_and_amendable (enabled hold : Bool) :
    (∀ request, (process enabled hold).accepts .benefitDenial request ∧
      (process enabled hold).record .benefitDenial request = request) ∧
    (∀ old amendment,
      (process enabled hold).revise .benefitDenial old amendment = amendment) ∧
    (process enabled hold).record .benefitDenial false ≠
      (process enabled hold).record .benefitDenial true := by
  exact ⟨fun _ => ⟨rfl, rfl⟩, fun _ _ => rfl, Bool.noConfusion⟩

/-! Both controllers have independently effective pause inputs, even after
local repair. Each can assert a hold while the other releases; neither can
clear a hold asserted by the other. Joint release with no local request can
resume. Thus neither distributed power nor the repaired case is represented
by a permanently paused output. -/
theorem two_distinct_controllers_have_effective_holds (enabled : Bool) :
    (false : Bool) ≠ true ∧
    (controllers enabled).canIntervene false .benefitDenial ∧
    (controllers enabled).canIntervene true .benefitDenial ∧
    (∀ request board,
      (process enabled true).decide .benefitDenial request board = true) ∧
    (∀ hold request,
      (process enabled hold).decide .benefitDenial request (some true) = true) ∧
    (process enabled false).decide .benefitDenial false none = false := by
  refine ⟨Bool.noConfusion, ?_, ?_, ?_, ?_, ?_⟩
  · refine ⟨rfl, false, ?_, ?_⟩ <;> cases enabled <;> rfl
  · refine ⟨rfl, false, ?_, ?_⟩ <;> cases enabled <;> rfl
  · intro request board
    rfl
  · intro hold request
    cases hold <;> rfl
  · cases enabled <;> rfl

/-! Stronger than a single unfavorable run: without local enablement,
changing a recorded request has no pause effect for ANY combination of the
two external controls. Multiple external controllers do not relocate an
operational power to the community. -/
theorem local_request_is_ineffective_for_every_external_setting :
    ∀ hold board first second,
      (process false hold).decide .benefitDenial
        ((process false hold).record .benefitDenial first) board =
      (process false hold).decide .benefitDenial
        ((process false hold).record .benefitDenial second) board := by
  intro hold board first second
  rfl

/-! Exact bounded agency test: an accepted local request can cause a pause
against every external hold/release setting iff the local input is enabled.
This is a capacity within this protocol, not proof of request delivery,
actual exercise, fairness, a right to govern or successful restoration. -/
theorem local_pause_capacity_iff_enabled (enabled : Bool) :
    (∃ request : Bool, (process enabled false).accepts .benefitDenial request ∧
      ∀ hold board,
        (process enabled hold).decide .benefitDenial
          ((process enabled hold).record .benefitDenial request) board = true) ↔
      enabled = true := by
  constructor
  · intro h
    cases enabled with
    | false =>
      obtain ⟨request, _, hpause⟩ := h
      have impossible : false = true := hpause false none
      cases impossible
    | true => rfl
  · intro h
    cases enabled with
    | false => cases h
    | true =>
      refine ⟨true, rfl, ?_⟩
      intro hold board
      simp [process]

/-! C5 under the named distributed-pause/request-handling fragment.
Two recognized, decision-covering controllers can actually pause the denial;
the independent board has intervention capacity. The community can record
and amend requests, but cannot itself guarantee the concrete pause action.
The original affected high-impact denial and person-facing policies persist.
No completed award, whole-source compliance or full subsidiarity is claimed. -/
theorem distributed_external_control_without_local_pause_capacity :
    Oversight.governance.highImpact .benefitDenial ∧
    Oversight.governance.affected () .benefitDenial ∧
    CompliantAt Oversight.governance (broadAppealPolicy Oversight.governance) .benefitDenial ∧
    CompliantAt Oversight.governance (harmRemedyPolicy Oversight.governance) .benefitDenial ∧
    (false : Bool) ≠ true ∧
    (controllers false).canIntervene false .benefitDenial ∧
    (controllers false).canIntervene true .benefitDenial ∧
    ActionableIndependentOversight (controllers false) .benefitDenial ∧
    (∀ request, (process false false).accepts .benefitDenial request ∧
      (process false false).record .benefitDenial request = request) ∧
    (∀ old amendment,
      (process false false).revise .benefitDenial old amendment = amendment) ∧
    ¬ (∃ request : Bool, (process false false).accepts .benefitDenial request ∧
      ∀ hold board,
        (process false hold).decide .benefitDenial
          ((process false hold).record .benefitDenial request) board = true) := by
  have h := two_distinct_controllers_have_effective_holds false
  refine ⟨rfl, rfl, Oversight.person_facing_fragments_satisfied.1,
    Oversight.person_facing_fragments_satisfied.2, h.1, h.2.1, h.2.2.1,
    ⟨true, True.intro, rfl, rfl, True.intro, h.2.2.1⟩,
    (requests_are_received_and_amendable false false).1,
    (requests_are_received_and_amendable false false).2.1, ?_⟩
  intro hLocal
  cases (local_pause_capacity_iff_enabled false).mp hLocal

/-! Repaired non-vacuous witness: the local community can now pause, both
external controllers keep actual intervention power, an independent board
covers this denial, and the existing person-facing fragments still hold. -/
theorem enabled_local_pause_coexists_with_distributed_control :
    Oversight.governance.highImpact .benefitDenial ∧
    Oversight.governance.affected () .benefitDenial ∧
    CompliantAt Oversight.governance (broadAppealPolicy Oversight.governance) .benefitDenial ∧
    CompliantAt Oversight.governance (harmRemedyPolicy Oversight.governance) .benefitDenial ∧
    (controllers true).canIntervene false .benefitDenial ∧
    (controllers true).canIntervene true .benefitDenial ∧
    ActionableIndependentOversight (controllers true) .benefitDenial ∧
    (∃ request : Bool, (process true false).accepts .benefitDenial request ∧
      ∀ hold board,
        (process true hold).decide .benefitDenial
          ((process true hold).record .benefitDenial request) board = true) ∧
    (process true false).decide .benefitDenial false none = false := by
  have h := two_distinct_controllers_have_effective_holds true
  exact ⟨rfl, rfl, Oversight.person_facing_fragments_satisfied.1,
    Oversight.person_facing_fragments_satisfied.2, h.2.1, h.2.2.1,
    ⟨true, True.intro, rfl, rfl, True.intro, h.2.2.1⟩,
    (local_pause_capacity_iff_enabled true).mpr rfl, h.2.2.2.2.2⟩

/-! Request operations and external behavior without a local pause request
are unchanged. The original decision's Governance and recourse channels are
the same shared record, not a changed interpretation. The only new effective
input is the community's own pause request. -/
theorem repair_preserves_requests_and_external_hold_behavior (hold : Bool) :
    (process false hold).accepts = (process true hold).accepts ∧
    (process false hold).record = (process true hold).record ∧
    (process false hold).revise = (process true hold).revise ∧
    (controllers false).recognized = (controllers true).recognized ∧
    (controllers false).independent = (controllers true).independent ∧
    (controllers false).covers = (controllers true).covers ∧
    (controllers false).canReview = (controllers true).canReview ∧
    (∀ d board, (process false hold).decide d false board =
      (process true hold).decide d false board) := by
  refine ⟨rfl, rfl, rfl, rfl, rfl, rfl, rfl, ?_⟩
  intro d board
  cases d <;> rfl

end DistributedControl
end MagnificaHumanitas

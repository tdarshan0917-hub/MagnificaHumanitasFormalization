import MagnificaHumanitas.Theory

namespace MagnificaHumanitas

variable {P A D : Type}

/-! I03 broad reading: retain the original exclusion rule and additionally
require appeal for an affected person in a high-impact decision, even before
exclusion. This adds ONE principal policy definition and no new case domain.
It does not add remedy-capacity duties or assert this is the unique reading.
Source motivation: MH-017/022 and impact classifier MH-013; A04 is explicit. -/
def broadAppealPolicy (g : Governance P A D) : Policy P D where
  required d r := match r with
    | .identifiableResponsibility => g.highImpact d
    | .appeal p => g.excluded p d ∨ (g.highImpact d ∧ g.affected p d)
    | .remedyCapacity _ => False

/-! Interface/refinement lemma; not a substantive result count by itself. -/
theorem broad_appeal_implies_narrow (g : Governance P A D) (d : D)
    (h : CompliantAt g (broadAppealPolicy g) d) :
    CompliantAt g (responsibilityAppealPolicy g) d := by
  intro r hr
  cases r with
  | identifiableResponsibility => exact h _ hr
  | appeal p => exact h _ (Or.inl hr)
  | remedyCapacity p => exact False.elim hr

/-! T4: shared explicit rule, hence a baseline consequence in both readings.
This does not establish the normative rule's truth or novelty. -/
theorem exclusion_without_appeal_fails_both (g : Governance P A D) (d : D) (p : P)
    (hExcluded : g.excluded p d) (hNoAppeal : ¬ g.appeal p d) :
    (¬ CompliantAt g (responsibilityAppealPolicy g) d) ∧
    (¬ CompliantAt g (broadAppealPolicy g) d) := by
  constructor
  · intro h
    exact hNoAppeal (h (.appeal p) hExcluded)
  · intro h
    exact hNoAppeal (h (.appeal p) (Or.inl hExcluded))

/-! Exact difference between these TWO named policies. This is a structural
characterization, not a weakest-premise theorem across all interpretations. -/
theorem broad_compliance_iff_narrow_and_affected_appeal
    (g : Governance P A D) (d : D) :
    CompliantAt g (broadAppealPolicy g) d ↔
      CompliantAt g (responsibilityAppealPolicy g) d ∧
      (∀ p, g.highImpact d → g.affected p d → g.appeal p d) := by
  constructor
  · intro h
    exact ⟨broad_appeal_implies_narrow g d h,
      fun p hi ha => h (.appeal p) (Or.inr ⟨hi, ha⟩)⟩
  · intro h r hr
    cases r with
    | identifiableResponsibility => exact h.1 _ hr
    | appeal p =>
      cases hr with
      | inl he => exact h.1 _ he
      | inr hi => exact h.2 p hi.1 hi.2
    | remedyCapacity p => exact False.elim hr

namespace AppealReview

/-! Internal review is available; access by the affected person is independent.
These are concrete witnesses in the existing employment-style case domain. -/
def procedures (accessOpen : Bool) : ProcedureSystem Unit Unit Unit where
  accepts _ _ _ := accessOpen = true
  canReview _ := True
  canCorrect _ := False

def reviewedDecision (excluded accessOpen : Bool) : Governance Unit Unit Unit where
  affected _ _ := True
  excluded _ _ := excluded = true
  harmed _ _ := False
  highImpact _ := True
  assigned _ _ := True
  identifiable _ := True
  appeal := (procedures accessOpen).HasAppeal
  remedyCapacity := (procedures accessOpen).HasRemedyCapacity
  explained _ := True
  humanReviewed _ := True

theorem closed_access_has_no_appeal (e : Bool) :
    ¬ (reviewedDecision e false).appeal () () := by
  intro h
  obtain ⟨channel, ha, _⟩ := h
  cases ha

/-! C2 under a responsibility-and-internal-review factual fragment.
The excluded witness violates BOTH appeal policies; it is not claimed to
satisfy a full policy that already requires appeal for this person. -/
theorem internal_review_without_appeal :
    ∃ g : Governance Unit Unit Unit,
      g.highImpact () ∧ g.affected () () ∧ g.excluded () () ∧
      g.humanReviewed () ∧ Provided g () .identifiableResponsibility ∧
      ¬ g.appeal () () ∧
      (¬ CompliantAt g (responsibilityAppealPolicy g) ()) ∧
      (¬ CompliantAt g (broadAppealPolicy g) ()) := by
  have hNo := closed_access_has_no_appeal true
  have hFail := exclusion_without_appeal_fails_both
    (reviewedDecision true false) () () rfl hNo
  exact ⟨reviewedDecision true false, True.intro, True.intro, rfl,
    True.intro, ⟨(), True.intro, True.intro⟩, hNo, hFail.1, hFail.2⟩

theorem nonexcluded_closed_case_satisfies_narrow :
    CompliantAt (reviewedDecision false false)
      (responsibilityAppealPolicy (reviewedDecision false false)) () := by
  intro r hr
  cases r with
  | identifiableResponsibility => exact ⟨(), True.intro, True.intro⟩
  | appeal p => cases hr
  | remedyCapacity p => exact False.elim hr

theorem nonexcluded_closed_case_fails_broad :
    ¬ CompliantAt (reviewedDecision false false)
      (broadAppealPolicy (reviewedDecision false false)) () := by
  intro h
  exact closed_access_has_no_appeal false
    (h (.appeal ()) (Or.inr ⟨True.intro, True.intro⟩))

/-! The same high-impact, affected-person facts are accepted by the narrow
appeal fragment and rejected by the broader one. This also supplies a C2
witness COMPATIBLE with the narrow policy, with non-vacuous impact. -/
theorem narrow_accepts_broad_rejects :
    ∃ g : Governance Unit Unit Unit,
      g.highImpact () ∧ g.affected () () ∧ (¬ g.excluded () ()) ∧
      g.humanReviewed () ∧ (¬ g.appeal () ()) ∧
      CompliantAt g (responsibilityAppealPolicy g) () ∧
      (¬ CompliantAt g (broadAppealPolicy g) ()) := by
  refine ⟨reviewedDecision false false, True.intro, True.intro, ?_,
    True.intro, closed_access_has_no_appeal false,
    nonexcluded_closed_case_satisfies_narrow,
    nonexcluded_closed_case_fails_broad⟩
  intro h
  cases h

/-! Repair comparison and satisfying instances for both policies. Remedy
capacity remains false, but neither named policy demands it. -/
theorem accessible_appeal_satisfies_both (excluded : Bool) :
    CompliantAt (reviewedDecision excluded true)
      (responsibilityAppealPolicy (reviewedDecision excluded true)) () ∧
    CompliantAt (reviewedDecision excluded true)
      (broadAppealPolicy (reviewedDecision excluded true)) () := by
  have hBroad : CompliantAt (reviewedDecision excluded true)
      (broadAppealPolicy (reviewedDecision excluded true)) () := by
    intro r hr
    cases r with
    | identifiableResponsibility => exact ⟨(), True.intro, True.intro⟩
    | appeal p => exact ⟨(), rfl, True.intro⟩
    | remedyCapacity p => exact False.elim hr
  exact ⟨broad_appeal_implies_narrow _ _ hBroad, hBroad⟩

theorem opening_preserves_other_facts (excluded : Bool) :
    (reviewedDecision excluded false).humanReviewed =
      (reviewedDecision excluded true).humanReviewed ∧
    (reviewedDecision excluded false).assigned =
      (reviewedDecision excluded true).assigned ∧
    (reviewedDecision excluded false).excluded =
      (reviewedDecision excluded true).excluded ∧
    (procedures false).canReview = (procedures true).canReview := by
  exact ⟨rfl, rfl, rfl, rfl⟩

end AppealReview
end MagnificaHumanitas

import MagnificaHumanitas.Model

namespace MagnificaHumanitas

variable {P A D : Type}

/-! Explicit normative interpretation, a fragment rather than all 28 claims.
Responsibility trigger: I01/I02; appeal trigger: MH-017/I03.
The individual actor allocation is a chosen prototype reading, not established
by the use of Actor as a type parameter. -/
def responsibilityAppealPolicy (g : Governance P A D) : Policy P D where
  required d r := match r with
    | .identifiableResponsibility => g.highImpact d
    | .appeal p => g.excluded p d
    | .remedyCapacity _ => False

/-! Optional prospective-capacity interpretation of MH-023/I04:
actual harm triggers a duty of remedy capacity. Capacity is not a successful
remedy, and no theorem asserts complete restoration. -/
def harmRemedyPolicy (g : Governance P A D) : Policy P D where
  required d r := match r with
    | .identifiableResponsibility => g.highImpact d
    | .appeal p => g.excluded p d
    | .remedyCapacity p => g.harmed p d

/-! Structural interface lemma; not counted as a flagship result. -/
theorem stronger_implies_fragment (g : Governance P A D) (d : D)
    (h : CompliantAt g (harmRemedyPolicy g) d) :
    CompliantAt g (responsibilityAppealPolicy g) d := by
  intro r hr
  cases r with
  | identifiableResponsibility => exact h _ hr
  | appeal p => exact h _ hr
  | remedyCapacity p => exact False.elim hr

/-! Exact extra provision required for extension to this particular policy.
This is a structural characterization, with both policy choices explicit. -/
theorem stronger_compliance_iff (g : Governance P A D) (d : D) :
    CompliantAt g (harmRemedyPolicy g) d ↔
      CompliantAt g (responsibilityAppealPolicy g) d ∧
        (∀ p, g.harmed p d → g.remedyCapacity p d) := by
  constructor
  · intro h
    exact ⟨stronger_implies_fragment g d h, fun p hp => h (.remedyCapacity p) hp⟩
  · intro h r hr
    cases r with
    | identifiableResponsibility => exact h.1 _ hr
    | appeal p => exact h.1 _ hr
    | remedyCapacity p => exact h.2 p hr

/-! Interface lemma: a duty and observed harm alone do not provide a remedy.
An actual compliance hypothesis is required here. -/
theorem compliant_harmed_has_capacity (g : Governance P A D) (d : D) (p : P)
    (h : CompliantAt g (harmRemedyPolicy g) d) (hh : g.harmed p d) :
    g.remedyCapacity p d := h (.remedyCapacity p) hh

end MagnificaHumanitas

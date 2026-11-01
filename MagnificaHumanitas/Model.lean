import MagnificaHumanitas.Source

namespace MagnificaHumanitas

/-! Factual relations do not assert that any obligation is fulfilled. -/
structure Governance (Person Actor Decision : Type) where
  affected : Person → Decision → Prop
  excluded : Person → Decision → Prop
  harmed : Person → Decision → Prop
  highImpact : Decision → Prop
  assigned : Actor → Decision → Prop
  identifiable : Actor → Prop
  appeal : Person → Decision → Prop
  remedyCapacity : Person → Decision → Prop
  explained : Decision → Prop
  humanReviewed : Decision → Prop
  -- Direct production is separate from merely using AI assistance.
  producedByAI : Decision → Prop := fun _ => False

inductive Safeguard (Person : Type) where
  | identifiableResponsibility
  | appeal (person : Person)
  | remedyCapacity (person : Person)

structure Policy (Person Decision : Type) where
  required : Decision → Safeguard Person → Prop

variable {P A D : Type}

def Provided (g : Governance P A D) (d : D) : Safeguard P → Prop
  | .identifiableResponsibility => ∃ a, g.assigned a d ∧ g.identifiable a
  | .appeal p => g.appeal p d
  | .remedyCapacity p => g.remedyCapacity p d

def CompliantAt (g : Governance P A D) (policy : Policy P D) (d : D) : Prop :=
  ∀ r, policy.required d r → Provided g d r

/-! A procedure may permit reconsideration without permitting correction. -/
structure ProcedureSystem (Person Decision Channel : Type) where
  accepts : Person → Decision → Channel → Prop
  canReview : Channel → Prop
  canCorrect : Channel → Prop

def ProcedureSystem.HasAppeal {C : Type} (ps : ProcedureSystem P D C)
    (p : P) (d : D) : Prop :=
  ∃ c, ps.accepts p d c ∧ ps.canReview c

def ProcedureSystem.HasRemedyCapacity {C : Type} (ps : ProcedureSystem P D C)
    (p : P) (d : D) : Prop :=
  ∃ c, ps.accepts p d c ∧ ps.canCorrect c

end MagnificaHumanitas

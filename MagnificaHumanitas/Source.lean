/-! Source references identify editorial provenance, not proof of textual fidelity. -/
namespace MagnificaHumanitas

structure SourceRef where
  claim : String
  paragraph : Nat
  interpretation : String
  deriving Repr

def prototypeSources : List SourceRef := [
  ⟨"MH-015", 103, "I01"⟩,
  ⟨"MH-017", 104, "I03"⟩,
  ⟨"MH-020", 105, "I01"⟩,
  ⟨"MH-021", 105, "I05"⟩,
  ⟨"MH-023", 105, "I04"⟩]

end MagnificaHumanitas

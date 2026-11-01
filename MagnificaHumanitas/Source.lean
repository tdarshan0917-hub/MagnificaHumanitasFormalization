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
  ⟨"MH-023", 105, "I04"⟩,
  ⟨"MH-020", 105, "I15"⟩,
  ⟨"MH-021", 105, "I15"⟩,
  ⟨"MH-001", 97, "I18"⟩,
  ⟨"MH-023", 105, "I17"⟩,
  ⟨"MH-022", 105, "I03"⟩,
  ⟨"MH-025", 106, "I06"⟩,
  ⟨"MH-031", 108, "I20"⟩,
  ⟨"MH-029", 107, "I21"⟩,
  ⟨"MH-032", 108, "I21"⟩,
  ⟨"MH-036", 109, "I21"⟩,
  ⟨"MH-020", 105, "I22"⟩,
  ⟨"MH-040", 111, "I22"⟩,
  ⟨"MH-039", 110, "I23"⟩,
  ⟨"MH-015", 103, "I24"⟩,
  ⟨"MH-020", 105, "I24"⟩]

end MagnificaHumanitas

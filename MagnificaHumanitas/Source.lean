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
  ⟨"MH-020", 105, "I24"⟩,
  ⟨"MH-021", 105, "I25"⟩,
  ⟨"MH-024", 106, "I26"⟩,
  ⟨"MH-016", 104, "I27"⟩,
  ⟨"MH-019", 104, "I27"⟩,
  ⟨"MH-038", 109, "I27"⟩,
  ⟨"MH-032", 108, "I28"⟩,
  ⟨"MH-036", 109, "I28"⟩,
  ⟨"MH-020", 105, "I29"⟩,
  ⟨"MH-022", 105, "I29"⟩,
  ⟨"MH-023", 105, "I29"⟩,
  ⟨"MH-025", 106, "I29"⟩,
  ⟨"MH-039", 110, "I29"⟩,
  ⟨"MH-019", 104, "I30"⟩,
  ⟨"MH-036", 109, "I30"⟩,
  ⟨"MH-038", 109, "I30"⟩,
  ⟨"MH-040", 111, "I30"⟩,
  ⟨"MH-022", 105, "I31"⟩,
  ⟨"MH-023", 105, "I31"⟩,
  ⟨"MH-025", 106, "I31"⟩,
  ⟨"MH-031", 108, "I31"⟩]

end MagnificaHumanitas

"""Small integrity check; compilation remains the proof check."""
import csv
import json
import re
from pathlib import Path

root = Path(__file__).resolve().parents[1]
rows = json.loads((root / "data/claims.json").read_text())
with (root / "data/claims.csv").open(newline="") as stream:
    table = list(csv.DictReader(stream))
assert len(rows) == len(table) == 40
assert len({r["id"] for r in rows}) == 40
assert sum(r["disposition"] == "Select" for r in rows) == 28
assert set(r["paragraph"] for r in rows) == set(range(97, 112))
for record, row in zip(rows, table):
    assert all(str(record[key]) == row[key] for key in record)
interpretations = (root / "docs/INTERPRETATION_LEDGER.md").read_text()
assert all(r["interpretation_id"] in interpretations for r in rows)
files = list((root / "MagnificaHumanitas").rglob("*.lean")) + [
    root / "MagnificaHumanitas.lean", root / "Audit.lean"]
for path in files:
    text = path.read_text()
    assert not re.search(r"\b(sorry|admit|native_decide)\b", text), path
    assert not re.search(r"^\s*(axiom|opaque)\s", text, re.M), path
assert "PUBLIC_REPORT_REQUIREMENTS.md" in (root / "README.md").read_text()
print(f"Integrity checks passed: {len(rows)} claims and {len(files)} Lean files.")

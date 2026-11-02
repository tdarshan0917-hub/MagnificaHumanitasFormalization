"""Verify delivered mathematical sources, document identity, and paper evidence links."""
import hashlib
import json
import re
from pathlib import Path
from pypdf import PdfReader
ROOT=Path(__file__).resolve().parents[1]
source=json.loads((ROOT/'verification/lean_source_manifest.json').read_text())
assert source['lean_files']==21 and source['lean_lines']==2789
actual=set(p.relative_to(ROOT).as_posix() for p in ROOT.glob('*.lean')) | set(p.relative_to(ROOT).as_posix() for p in (ROOT/'MagnificaHumanitas').rglob('*.lean'))
assert actual=={f['path'] for f in source['files']},'Lean file inventory changed'
for f in source['files']:
 b=(ROOT/f['path']).read_bytes()
 assert hashlib.sha256(b).hexdigest()==f['sha256'],f['path']
 assert hashlib.sha1(b'blob '+str(len(b)).encode()+b'\0'+b).hexdigest()==f['git_blob_sha'],f['path']
assert sum(len((ROOT/p).read_text().splitlines()) for p in actual)==2789
manuscript=json.loads((ROOT/'paper/manuscript.json').read_text())
assert manuscript['formal_commit']==source['formal_commit']
all_lean='\n'.join((ROOT/p).read_text() for p in sorted(actual))
names=set(re.findall(r'^\s*theorem\s+([A-Za-z_][A-Za-z_0-9.]*)',all_lean,re.M))
references=[]
for page in manuscript['pages']:
 for block in page['blocks']:
  if block['type']=='lean':
   for ref in block['text'].split('; '):
    assert ref.split('.')[-1] in {n.split('.')[-1] for n in names},ref
    references.append(ref)
documents=json.loads((ROOT/'verification/document_manifest.json').read_text())
assert documents['formal_commit']==source['formal_commit']
for f in documents['documents']:
 p=ROOT/f['path'];assert hashlib.sha256(p.read_bytes()).hexdigest()==f['sha256'],f['path']
 r=PdfReader(p); assert len(r.pages)==f['pages'],f['path']
 assert all(len(page.extract_text().split())>100 for page in r.pages),'Empty or overflow-only page'
 assert all('\ufffd' not in page.extract_text() for page in r.pages),'Unmapped glyph'
print(f"Release checks passed: 21 unchanged Lean files, {len(references)} named paper references, 16-page technical paper, 6-page public report.")

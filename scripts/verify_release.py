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
public=json.loads((ROOT/'paper/public_report.json').read_text())
summary=json.loads((ROOT/'paper/one_page_summary.json').read_text())
release=json.loads((ROOT/'publication/release.json').read_text())
assert public['release']==manuscript['release']==summary['release']==release['release']==documents['release']
assert all(x['formal_commit']==source['formal_commit'] for x in [public,manuscript,summary,release])
assert len(public['pages'])==6 and len(manuscript['pages'])==17
assert len(public['key_findings'])==7 and len(public['pages'][5]['table']['rows'])==6
by_path={d['path']:d for d in documents['documents']}
assert by_path['output/pdf/MagnificaHumanitas_Plain_Language_Progress_Report.pdf']['pages']==6
assert by_path['output/pdf/MagnificaHumanitas_Technical_Paper.pdf']['pages']==17
assert by_path['output/pdf/MagnificaHumanitas_One_Page_Summary.pdf']['pages']==1
assert release['document_versions']=={'public_report':public['version'],'technical_paper':manuscript['version'],'one_page_summary':summary['version']}
doi=release['doi'];doi_url='https://doi.org/'+doi
assert doi=='10.5281/zenodo.23923506'
assert all(x['doi']==doi and x['doi_url']==doi_url for x in [public,manuscript,summary])
assert json.loads((ROOT/'publication/zenodo_metadata.json').read_text())['doi']==doi
assert ('doi: "'+doi+'"') in (ROOT/'CITATION.cff').read_text()
assert manuscript['pages'][-2]['title'].startswith('15. Connections')
assert manuscript['pages'][-1]['title'].startswith('16. Reproduction')
refs=[b['text'] for b in manuscript['pages'][-1]['blocks'] if b.get('text','').startswith('[')]
assert [int(re.match(r'\[(\d+)\]',x).group(1)) for x in refs]==list(range(1,8))
normalize=lambda s:' '.join(s.split())
pub_pdf=PdfReader(ROOT/'output/pdf/MagnificaHumanitas_Plain_Language_Progress_Report.pdf')
pub_text=normalize('\n'.join(p.extract_text() for p in pub_pdf.pages))
assert [p['id'] for pg in public['pages'] for p in pg['paragraphs']]==list(range(1,27))
for pg in public['pages']:
 for p in pg['paragraphs']:assert normalize(p['text']) in pub_text,p['id']
for name in ['lean_explainer','model_limits']:assert normalize(public[name]['text']) in pub_text
assert normalize(public['acknowledgment']['text']) in normalize(pub_pdf.pages[-1].extract_text())
sum_text=normalize(PdfReader(ROOT/'output/pdf/MagnificaHumanitas_One_Page_Summary.pdf').pages[0].extract_text())
for key in ['purpose','lean','story','limits','evidence_note']:assert normalize(summary[key]) in sum_text,key
for finding in summary['findings']:assert normalize(finding) in sum_text,finding
for refs in public['key_findings_evidence']+[r['proofs'] for r in public['pages'][5]['table']['support']]:
 for ref in refs:assert re.search(r'\btheorem\s+'+re.escape(ref['declaration'])+r'\b',(ROOT/ref['file']).read_text()),ref
for page in pub_pdf.pages:
 destinations=[a.get_object()['/Dest'] for a in page.get('/Annots',[]) if '/Dest' in a.get_object()]
 assert len(destinations)==1 and destinations[0][0].get_object()==pub_pdf.pages[-1]
assert 'Recommended final check' in pub_text and 'Recommended final check' in sum_text
assert '?.' not in pub_text
assert not re.search(r'(score(?: of)?|cutoff(?: of)?)\s+47\b',pub_text,re.I)
for f in documents['documents']:
 r=PdfReader(ROOT/f['path']);assert doi in normalize('\n'.join(p.extract_text() for p in r.pages)),f['path']
 links=[a.get_object().get('/A',{}).get('/URI') for p in r.pages for a in p.get('/Annots',[])]
 assert doi_url in links,f['path']
print(f"Release {release['release']} checks passed: 21 unchanged Lean files, {len(references)} named paper references; technical 17 pages, public 6 pages, summary 1 page; complete text and evidence links.")

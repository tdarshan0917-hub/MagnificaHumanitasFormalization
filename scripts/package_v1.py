"""Create a deterministic tracked-source ZIP with exact commit and CI evidence."""
import argparse
import hashlib
import io
import json
import subprocess
import zipfile
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
p=argparse.ArgumentParser();p.add_argument('--verification',required=True,type=Path);args=p.parse_args()
def git(*a):return subprocess.check_output(['git',*a],cwd=ROOT)
sha=git('rev-parse','HEAD').decode().strip()
verification=json.loads(args.verification.read_text())
assert verification['commit']==sha and verification['conclusion']=='success'
assert verification['status']=='completed'
assert verification['workflow_run_url'].startswith('https://github.com/tdarshan0917-hub/MagnificaHumanitasFormalization/actions/runs/')
assert not git('status','--porcelain','--untracked-files=no').strip(),'Commit tracked changes before packaging'
payload={}
for record in git('ls-tree','-rz','HEAD').split(b'\0'):
 if not record:continue
 meta,name=record.split(b'\t',1);mode,kind,obj=meta.split()
 assert kind==b'blob'
 name=name.decode();payload[name]=git('cat-file','blob',obj.decode())
payload['RELEASE_COMMIT.txt']=(sha+'\n').encode()
payload['RELEASE_VERIFICATION.json']=(json.dumps(verification,indent=2,sort_keys=True)+'\n').encode()
release=json.loads(payload['publication/release.json'])
payload['RELEASE_VERSION.txt']=(release['release']+'\n').encode()
manifest=''.join(f"{hashlib.sha256(data).hexdigest()}  {name}\n" for name,data in sorted(payload.items()))
payload['MANIFEST.sha256']=manifest.encode()
buf=io.BytesIO()
with zipfile.ZipFile(buf,'w',compression=zipfile.ZIP_DEFLATED,compresslevel=9) as z:
 for name,data in sorted(payload.items()):
  info=zipfile.ZipInfo('MagnificaHumanitas_V1/'+name,date_time=(2026,11,3,0,0,0));info.compress_type=zipfile.ZIP_DEFLATED;info.external_attr=0o100644<<16
  z.writestr(info,data)
out=ROOT/'dist/MagnificaHumanitas_V1_Source_and_Reports.zip';out.parent.mkdir(exist_ok=True)
out.write_bytes(buf.getvalue())
with zipfile.ZipFile(out) as z:
 assert z.testzip() is None
 for name,data in payload.items():assert z.read('MagnificaHumanitas_V1/'+name)==data
print(json.dumps({'path':str(out),'commit':sha,'payload_files':len(payload),'bytes':out.stat().st_size,'sha256':hashlib.sha256(out.read_bytes()).hexdigest()}))

# Update the existing Mac repository to prototype 0.4

The project has already been cloned and version 0.3 pushed. Do not clone it again.

Download `MagnificaHumanitas_Prototype_0_4.bundle` to Downloads. This single update file carries the existing history plus the new checked commit. Then paste this complete block into Terminal:

```bash
cd "$HOME/MagnificaHumanitasFormalization" &&
git fetch "$HOME/Downloads/MagnificaHumanitas_Prototype_0_4.bundle" main --tags &&
git merge --ff-only FETCH_HEAD &&
git push origin main &&
git push origin prototype-v0.4
```

The fetch imports local history. The fast-forward merge preserves existing commits and refuses a divergent history. No force push or reset is used. If any command fails, the remaining commands do not run; retain the message for diagnosis. These instructions assume the downloaded filename is unchanged.

The assistant's GitHub connection could not read the private repository, so this file does not claim the remote upload or CI succeeded. The user must run the update block, or grant the connection access before a direct remote update can be attempted.

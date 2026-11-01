# Update the existing Mac repository from GitHub

The project has already been cloned and connected to GitHub. Repository access from this app is now working. Changes can be saved directly, and the Mac copy can receive them by pulling.

To update the existing Mac copy, paste:

```bash
cd "$HOME/MagnificaHumanitasFormalization" &&
git pull --ff-only origin main
```

The fast-forward pull preserves existing commits and refuses a divergent history. No force push or reset is used. If it fails, retain the message for diagnosis. Local modifications may need to be reconciled; never discard them automatically.

The original bundle-import instructions are retained in Git history if needed. A new clone or download bundle is not needed for ordinary updates. This app's Lean execution remains separate from the Mac; local verification is optional while the app and GitHub run the checks.

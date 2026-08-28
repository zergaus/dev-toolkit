# DevToolkit

**DevToolkit** is a Windows development-environment lifecycle manager designed to make setup, repair, update, reconfiguration, and verification repeatable instead of turning each machine into a one-off installation project.

> **Status:** Preview/Test correction candidate `v0.1.0-preview.20260828.12` is available for bounded testing. It is **not Stable or Official**.

## Preview/Test path-explicit quick start

Run these lines in Windows PowerShell 5.1 or later. The installer is downloaded to a visible full path, verified by SHA-256, and then executed with `-File`. This path does not use `-EncodedCommand` or `Invoke-Expression`.

```powershell
$Version = '0.1.0-preview.20260828.12'
$InstallerUri = "https://github.com/zergaus/dev-toolkit/releases/download/v$Version/install-preview.ps1"
$InstallerPath = Join-Path $env:TEMP "DevToolkit-$Version-install-preview.ps1"
Invoke-WebRequest -UseBasicParsing -Uri $InstallerUri -OutFile $InstallerPath
if ((Get-FileHash -LiteralPath $InstallerPath -Algorithm SHA256).Hash -ne '99E6154F2A77DE7861A1360BA15DD277614F97307FDF7816BD0ECB2A491F6A0B') {
    throw 'DevToolkit Preview/Test installer SHA-256 mismatch.'
}
powershell.exe -NoProfile -ExecutionPolicy Bypass -File $InstallerPath
```

The exact staged executable path is:

```powershell
$DevToolkitExe = Join-Path $env:LOCALAPPDATA 'DevToolkit\bootstrap\DevToolkit-0.1.0-preview.20260828.12-3aa5b99e146366d1.exe'
```

The complete disposable-Windows headless E2E commands are:

```powershell
$DevToolkitExe = Join-Path $env:LOCALAPPDATA 'DevToolkit\bootstrap\DevToolkit-0.1.0-preview.20260828.12-3aa5b99e146366d1.exe'
& $DevToolkitExe --execute-mutations --headless full.install --state-root 'C:\DevToolkit-CIW\E2E'
& $DevToolkitExe --headless complete.check --state-root 'C:\DevToolkit-CIW\E2E'
& $DevToolkitExe --execute-mutations --headless update.existing --state-root 'C:\DevToolkit-CIW\E2E'
& $DevToolkitExe --execute-mutations --headless repair.existing --state-root 'C:\DevToolkit-CIW\E2E'
& $DevToolkitExe --execute-mutations --headless setup.reconfigure --state-root 'C:\DevToolkit-CIW\E2E'
```

Those mutation commands belong only on the designated disposable Windows E2E host. They are not safe-host smoke commands.

For the downloaded ZIP bundle, define the full launch path first:

```powershell
$LaunchPath = 'C:\DevToolkit-Preview\DevToolkit-0.1.0-preview.20260828.12-win-x64\launch.ps1'
powershell.exe -NoProfile -ExecutionPolicy Bypass -File $LaunchPath
```

Scoop candidate, also Preview/Test only:

```powershell
scoop install 'https://github.com/zergaus/dev-toolkit/releases/download/v0.1.0-preview.20260828.12/devtoolkit-preview.json'
```

Exact identity:

- source commit: `dbc63ce052bff556f8587f668c9eb012d6c9f107` in private source authority `zergaus/dev-toolkit-source`;
- `DevToolkit.exe`: 75,133,020 bytes, SHA-256 `3AA5B99E146366D183EE97FA645A3CA3D2C04D27AEBC7E565D11D8E02F6663C7`;
- `release-manifest.json`: SHA-256 `E8F35DAFE09646A7FE928E8AAC022D5E46D578C209226B968844405632E28FA8`;
- bundle ZIP: SHA-256 `CE4D19B95FEB024B7C58745353D3A730B711CF1D1EEF80E57679FBDB13D261CA`;
- installer: SHA-256 `99E6154F2A77DE7861A1360BA15DD277614F97307FDF7816BD0ECB2A491F6A0B`.

Avast ScanResult `73` later proved that the Human first-run failure targeted the exact historical `.11` executable as `IDP.Generic`, not the discarded encoded PowerShell harness. The new `.12` identity has passed local Machine Gate; fresh public first-run behavior remains acceptance-bearing. No exclusion or shield change is required by this Preview/Test path, and the executable remains unsigned.

This Preview/Test distribution is not an `Official Release` as defined by the current license. Public availability does not create a broader license grant or a Stable/production-readiness claim.

## What DevToolkit is for

DevToolkit is being built around a stricter definition of a working development environment:

```text
bootstrap
→ discover current state
→ install or reconcile
→ setup / reconfigure
→ verify
→ Complete Check
→ repair / update / support evidence
```

Installing a package is not considered completion by itself. DevToolkit is intended to converge installation, configuration, version policy, required manual/authentication steps, and verification into one managed lifecycle.

## Planned user operations

- **Full Install (Yesha Standard)**
- **Custom Install**
- **Reconfigure / Setup**
- **Repair Existing**
- **Update Existing**
- **Complete Check**
- **Support / Logs**

The product is designed for local Windows use as well as terminal/SSH workflows, with deterministic fallback and non-interactive/headless operation where appropriate.

## Distribution model

This repository is the **public distribution surface** for DevToolkit.

Preview/Test pre-releases and future Official releases are published through this repository's **GitHub Releases** page with corresponding integrity/provenance information. Development source, architecture work, internal tests, and release engineering are maintained separately and are not published here by default.

Until an Official Release appears on the Releases page, Preview/Test files must not be treated as an official DevToolkit release.

## License

DevToolkit is **proprietary software and is not open source**.

Use of Official Releases is governed by the **DevToolkit Limited Use License (DTLUL)** in [`LICENSE`](./LICENSE). In short, the license permits use of unmodified Official Releases for personal use and internal organizational use, while reserving modification, redistribution, repackaging, derivative-work, and source-reuse rights.

Third-party software that DevToolkit installs, configures, detects, or manages remains governed by its own upstream/vendor license.

## Current development status

The project is currently converging its runtime, terminal UI, bootstrap, catalog/state engine, installation adapters, verification, and release pipeline before the first public release.

The current public artifact is deliberately limited to Preview/Test validation. Stable/Official support requirements and claims remain pending.

---

Copyright © 2026 zergaus. All rights reserved.

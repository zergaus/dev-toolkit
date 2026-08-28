# DevToolkit

**DevToolkit** is a Windows development-environment lifecycle manager designed to make setup, repair, update, reconfiguration, and verification repeatable instead of turning each machine into a one-off installation project.

> **Status:** Preview/Test pre-release `v0.1.0-preview.20260827.11` is available for bounded testing. It is **not Stable or Official**.

## Preview/Test path-explicit quick start

Run these lines in Windows PowerShell 5.1 or later. The installer is downloaded to a visible full path, verified by SHA-256, and then executed with `-File`. This path does not use `-EncodedCommand` or `Invoke-Expression`.

```powershell
$Version = '0.1.0-preview.20260827.11'
$InstallerUri = "https://github.com/zergaus/dev-toolkit/releases/download/v$Version/install-preview.ps1"
$InstallerPath = Join-Path $env:TEMP "DevToolkit-$Version-install-preview.ps1"
Invoke-WebRequest -UseBasicParsing -Uri $InstallerUri -OutFile $InstallerPath
if ((Get-FileHash -LiteralPath $InstallerPath -Algorithm SHA256).Hash -ne 'B82F7D23586954DEF4981C89AC8B0D5E3FAAC02B6229FE7CAA256807985AD4BE') {
    throw 'DevToolkit Preview/Test installer SHA-256 mismatch.'
}
powershell.exe -NoProfile -ExecutionPolicy Bypass -File $InstallerPath
```

The exact staged executable path is:

```powershell
$DevToolkitExe = Join-Path $env:LOCALAPPDATA 'DevToolkit\bootstrap\DevToolkit-0.1.0-preview.20260827.11-ea9ebd146ada6718.exe'
```

The complete disposable-Windows headless E2E commands are:

```powershell
$DevToolkitExe = Join-Path $env:LOCALAPPDATA 'DevToolkit\bootstrap\DevToolkit-0.1.0-preview.20260827.11-ea9ebd146ada6718.exe'
& $DevToolkitExe --execute-mutations --headless full.install --state-root 'C:\DevToolkit-CIW\E2E'
& $DevToolkitExe --headless complete.check --state-root 'C:\DevToolkit-CIW\E2E'
& $DevToolkitExe --execute-mutations --headless update.existing --state-root 'C:\DevToolkit-CIW\E2E'
& $DevToolkitExe --execute-mutations --headless repair.existing --state-root 'C:\DevToolkit-CIW\E2E'
& $DevToolkitExe --execute-mutations --headless setup.reconfigure --state-root 'C:\DevToolkit-CIW\E2E'
```

Those mutation commands belong only on the designated disposable Windows E2E host. They are not safe-host smoke commands.

For the downloaded ZIP bundle, define the full launch path first:

```powershell
$LaunchPath = 'C:\DevToolkit-Preview\DevToolkit-0.1.0-preview.20260827.11-win-x64\launch.ps1'
powershell.exe -NoProfile -ExecutionPolicy Bypass -File $LaunchPath
```

Scoop candidate, also Preview/Test only:

```powershell
scoop install 'https://github.com/zergaus/dev-toolkit/releases/download/v0.1.0-preview.20260827.11/devtoolkit-preview.json'
```

Exact identity:

- source commit: `6bda3e54a4718dd763f0531d7ae7e528eed72e2d` in private source authority `zergaus/dev-toolkit-source`;
- `DevToolkit.exe`: 74,895,964 bytes, SHA-256 `EA9EBD146ADA67187B4A3A5B1C8CF42E3EE4A8BAAC4EF83B59A5F5EF8442528B`;
- `release-manifest.json`: SHA-256 `B1D199651973022A6C4A4A7CF11B811E01EDA8A97E2AB8039BE7C303A74A9ABC`;
- bundle ZIP: SHA-256 `693A8E92550FCADD821C4355FE783EA1C4A575D47FCE410E8C9DF201101E756F`.

The earlier Avast Behavior Shield record identified the discarded `powershell.exe -EncodedCommand` test harness as `IDP.HELU.PSE90%s_cmd`; it did not identify `DevToolkit.exe` as the detection path. The corrected `.11` public acquisition, exact executable, safe rerun, headless/plain/rich/narrow checks produced no new Avast ScanResult on the tested machine. This bounded observation is not an Avast vendor attestation or a digital-signature claim; the executable remains unsigned.

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

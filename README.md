# DevToolkit

**DevToolkit** is a Windows development-environment lifecycle manager designed to make setup, repair, update, reconfiguration, and verification repeatable instead of turning each machine into a one-off installation project.

> **Status:** **SECURITY HOLD.** Preview/Test pre-release `v0.1.0-preview.20260827.10` has been withdrawn to Draft. Do **not** download or run it. It is not Stable or Official.

## Preview/Test security hold

The first public-acquisition check exposed two unresolved release-path findings:

- Avast Behavior Shield detected the test harness process `powershell.exe` as `IDP.HELU.PSE90%s_cmd` while it used `-EncodedCommand`. The observed record did not identify `DevToolkit.exe` as the detected path, but the finding has not been dismissed as a false positive.
- The immutable bootstrap rejected GitHub's signed release-asset redirect because the redirect contains a query string. The public acquisition path therefore did not pass its declared E2E gate.

The release is intentionally kept as a Draft while these findings are investigated and corrected. No quick-start, Scoop, launch, or mutation command is currently authorized from this repository.

The affected draft identity is retained only for incident traceability:

- source commit: `c549e5c9ab8b337914287798591554c8045af62a` in private source authority `zergaus/dev-toolkit-source`;
- `DevToolkit.exe`: 74,895,964 bytes, SHA-256 `C14DA16E28ED276F124D2755ADE0293A2A97A11FE4E15F45AEA83407230CD4B0`;
- `release-manifest.json`: SHA-256 `5E3097704BEC5F8BA0B3B3402FD9C7C6F40F90A19AD2F6B3B5A4642CB72F7B61`;
- bundle ZIP: SHA-256 `07F86B697DDAB61BFB9517F5C50040E33CC50C45F322D85F09C18BD999EC2DD7`.

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

There is currently no downloadable or executable public candidate. Stable/Official support requirements and claims remain pending.

---

Copyright © 2026 zergaus. All rights reserved.

# DevToolkit

**DevToolkit** is a Windows development-environment lifecycle manager designed to make setup, repair, update, reconfiguration, and verification repeatable instead of turning each machine into a one-off installation project.

> **Status:** Active development. No Official Release has been published yet.

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

Official releases, when available, will be published through this repository's **GitHub Releases** page with the corresponding integrity/provenance information. Development source, architecture work, internal tests, and release engineering are maintained separately and are not published here by default.

Until an Official Release appears on the Releases page, files or artifacts found elsewhere should not be treated as an official DevToolkit release.

## License

DevToolkit is **proprietary software and is not open source**.

Use of Official Releases is governed by the **DevToolkit Limited Use License (DTLUL)** in [`LICENSE`](./LICENSE). In short, the license permits use of unmodified Official Releases for personal use and internal organizational use, while reserving modification, redistribution, repackaging, derivative-work, and source-reuse rights.

Third-party software that DevToolkit installs, configures, detects, or manages remains governed by its own upstream/vendor license.

## Current development status

The project is currently converging its runtime, terminal UI, bootstrap, catalog/state engine, installation adapters, verification, and release pipeline before the first public release.

This README will be updated with the supported installation command, release channel, system requirements, and verification procedure when the first accepted public artifact is available.

---

Copyright © 2026 zergaus. All rights reserved.

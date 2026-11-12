# Renovate swift: pin edits are lost when Package.swift files share one Package.resolved

## Current behavior

This repository has an Xcode workspace with two local packages, `App` and `Tool`. Each `Package.swift` pins one dependency with `exact:`. The workspace has one shared lockfile, `Workspace.xcworkspace/xcshareddata/swiftpm/Package.resolved`, that holds both pins.

`renovate.json` groups the `swift` updates, so both bumps land in one branch.

Renovate updates both `Package.swift` files, but only one pin in the shared `Package.resolved`:

| File | swift-argument-parser | swift-log |
| --- | --- | --- |
| `App/Package.swift` | 1.2.0 -> 1.8.2 | |
| `Tool/Package.swift` | | 1.5.3 -> 1.17.0 |
| `Package.resolved` | **stays at 1.2.0** | 1.5.3 -> 1.17.0 |

See [PR #1](https://github.com/bdolewski/renovate-swift-shared-package-resolved/pull/1), created by Renovate built from `main` (`25da094b6e`).

The lockfile now pins `swift-argument-parser` at 1.2.0, while `App/Package.swift` requires exactly 1.8.2. A resolve with automatic resolution disabled fails with "an out-of-date resolved file was detected".

## Expected behavior

`Package.resolved` gets both pins updated, as in [PR #3](https://github.com/bdolewski/renovate-swift-shared-package-resolved/pull/3). PR #3 was created by Renovate built from the fix branch, with `branchPrefix: renovate-with-fix/`, so the two PRs can be compared.

## Cause

The `swift` manager's `updateArtifacts` runs once per `Package.swift`. Each call reads `Package.resolved` from disk and edits only the pins of that one manifest. The branch worker keeps only the last result for a file. Every call reads the original lockfile, so the edits from earlier manifests are lost.

## Link to the Renovate fix

https://github.com/renovatebot/renovate/pull/47969

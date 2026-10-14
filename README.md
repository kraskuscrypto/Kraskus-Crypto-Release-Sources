# Kraskus Crypto Release Sources

Public, per-release source and licence material for software that Kraskus Crypto
distributes in its container images.

This repository exists to meet the source and notice obligations of the
third-party open-source components Kraskus ships, and to give app-store
reviewers a public reference for each release. It is **not** a mirror of any
Kraskus development repository and contains only material that a release needs.

## Scope

| Path | Contents |
|---|---|
| [`chta/ckpool/`](chta/ckpool/) | Complete corresponding source (GPL-3.0-only) for every published `kraskus-chta-ckpool` image |
| [`apps/`](apps/) | Third-party component and notice records for each Kraskus app release |
| [`third-party-licenses/`](third-party-licenses/) | Full licence texts of the bundled third-party components, pinned to the shipped versions |

## Kraskus components

The Kraskus application layer (UI, API/adapter, controller, supervisors and
packaging) is **not** published or licensed by this repository. Nothing here
grants any licence to Kraskus proprietary components.

Kraskus modifications to a third-party component are published here under that
component's own licence (for CKPool: GPL-3.0-only).

## Integrity

Each release folder lists SHA-256 checksums in `SHA256SUMS`. Release folders are
immutable once tagged; corrections are made in a new folder and tag.

Contact: https://kraskuscrypto.com/

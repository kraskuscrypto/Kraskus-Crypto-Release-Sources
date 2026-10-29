# Bitcoin by Kraskus 0.5.0-dev (Development Preview): release provenance and third-party source information

**This is release provenance and third-party source information. It is not the complete source of the BTC app.**
The Kraskus Crypto components of this app (UI, API, packaging) are proprietary software of 4KM Ventures LLC and are not published or licensed here (see [LICENSE-KRASKUS.md](../../../LICENSE-KRASKUS.md)). Their reviewed source is preserved privately; the exact commits are listed below so this record can be matched to it.

Status: **development preview, mining disabled** (no `--enable-mining`, no `--allow-mainnet`, no Stratum port). Not qualified for live mining.

## Third-party components

| Component | Licence | Source | Licence text |
|---|---|---|---|
| Bitcoin Core 32.1: unmodified official release binaries `bitcoind` and `bitcoin-cli` from `bitcoin-32.1-x86_64-linux-gnu.tar.gz` (archive SHA-256 `61545c17c3120fb7412f896d248b11993af04ec8817aad3649c55b2afb044963`, listed in `SHA256SUMS` signed by the Bitcoin Core guix builders). Binary SHA-256: `bitcoind` `580ac61190154da31aac3f82d13c4254ef453d70e1bf2c39d338dac5129c92ac`, `bitcoin-cli` `83dad233fb62b1b2931efd446f7c66fe02585055143e0f0087c742732c75b52d` | MIT | https://github.com/bitcoin/bitcoin/tree/v32.1 (tag commit `f0de87f040621468b956f01f526a43a010310501`) | [bitcoin-core-32.1-COPYING.txt](../../../third-party-licenses/bitcoin-core-32.1-COPYING.txt) |

## Source-distribution obligations

- Bitcoin Core is MIT-licensed: the obligation is to keep its copyright and permission notice with the software. The images ship the unmodified binaries; the notice is provided here, alongside the release. No source-distribution obligation applies, and none of its source is modified.
- No GPL/LGPL component is added by Kraskus in these images. Container base images (Debian, Alpine, Python, nginx) keep their own licences and notices; the corresponding Debian sources are available from https://snapshot.debian.org/ and Alpine sources from https://gitlab.alpinelinux.org/alpine/aports.

## Notices in the images

The released images ship only the binaries of the third-party components; the Bitcoin Core licence text is not inside the images and is provided here. The Kraskus foundation modules vendored into the app image carry their own MIT / Apache-2.0 files (`FOUNDATION-LICENSE-MIT`, `FOUNDATION-LICENSE-APACHE`).

## Images of this release

| Image (tag `0.5.0-dev`, pinned by registry digest) | Image ID (config digest) | Built from (reviewed commit) | Base (by digest) |
|---|---|---|---|
| `ghcr.io/kraskuscrypto/kraskus-btc-solo:0.5.0-dev@sha256:3f48a7ed4d7c2be909047c3ee527050c89f4a78618b98bca477c82192fdd9ee7` | `sha256:9e149632a24b842e635b36adf475cdd94aa35089062944cc05918d3b75d3efe9` | `4b968fc` (`package/Dockerfile`) | `python:3.13-slim-trixie@sha256:2d44738ebf4ce5f63b9d9ea871e9c7cfdc0426f7b0c97cac915fd88ded1d86bb` |
| `ghcr.io/kraskuscrypto/kraskus-btc-solo-ui:0.5.0-dev@sha256:96a2283660adcd67ca03f12617901446978fe633c2810195b9ce98cb53ce4e34` | `sha256:1c9a885dc8435bf59ae43cfc661590fb222dda07a61137fd504f6e33db761027` | `e7bf79f` (`package/ui/Dockerfile`) | `nginx:1.30.6-alpine@sha256:0e52bd054126cdc040b1276c0af347aeb02a41b9cfe305d6094767ac30e97949` |
| `ghcr.io/kraskuscrypto/kraskus-btc-solo-node:0.5.0-dev@sha256:3321ad408515a5a3168e3c7e60f6942d2de49dce079d99dd884dab1aa20ab76e` | `sha256:974ed0d319c7afc8bae247217c6b014200faaec5fde2913563e30d1faefd9b93` | `e7bf79f` (`qa/vm100/node/Dockerfile`) | `debian:trixie-slim@sha256:f6b08b09a05725f9431502d3b5714f5c4576e82c1a84fa1debe0c24a7e0c3ec4` |

## Build information

- Built on 2026-10-29 with `docker build --no-cache --pull=false` against the base digests above (app 16:29 UTC, UI and node 13:19 UTC).
- App image: `apt-get upgrade` from the base's own Debian sources, then pip removed (unused at runtime). UI image: `apk upgrade`, curl removed. Node image: `apt-get upgrade` on Debian slim, the Bitcoin Core binaries copied unmodified.
- Each image records its installed package list (`/usr/share/kraskus-dpkg-manifest.txt`, `/usr/share/kraskus-apk-manifest.txt`).
- Vulnerability scan: Trivy 0.76.1 (`aquasec/trivy@sha256:790fd66d1697395d8693d1acaa1ea702406a20f109b6fc7bac8db623eca6c06c`), archive-only: UI 0 findings; app/node 0 critical and no finding with an available fix.

## Reviewed source (private)

- Repository `kraskuscrypto/Kraskus-Mining-Platform` (private), branch `v3/btc`, path `apps/btc-solo/` (full review history kept).
- Reviewed commits: app `4b968fc`, UI and node `e7bf79f`, release preparation `b272422`.

Recipe of this release: https://github.com/kraskuscrypto/Kraskus-Crypto-Dev-Store/tree/4e3c46a/kraskus-btc-solo (Kraskus Crypto Dev Store, development preview)

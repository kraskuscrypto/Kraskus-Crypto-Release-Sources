# BTC2b by Kraskus 0.2.6 — third-party components and notices

Kraskus Crypto components of this app (UI, API/adapter, controller, packaging) are proprietary and are not published or licensed here.

## Third-party components

| Component | Licence | Source | Licence text |
|---|---|---|---|
| Bitcoin Knots 29.4.2.knots20260508 (official release binaries `bitcoind`, `bitcoin-cli`, SHA-256 verified) | MIT | https://github.com/bitcoinknots/bitcoin/tree/v29.4.2.knots20260508 | [bitcoin-knots-29.4.2-COPYING.txt](../../../third-party-licenses/bitcoin-knots-29.4.2-COPYING.txt) |
| DATUM Gateway (CONVOY Mining) at commit `56c31f40c83c3c8315694617082456677799e43a`, modified by Kraskus build-time patches (developer fee, telemetry, share difficulty, block events) | MIT | https://github.com/CONVOYMining/datum_gateway/tree/56c31f40c83c3c8315694617082456677799e43a | [datum-gateway-56c31f4-LICENSE.txt](../../../third-party-licenses/datum-gateway-56c31f4-LICENSE.txt) |

DATUM links the unmodified Debian packages libcurl, libjansson, libsodium and libmicrohttpd (LGPL-2.1+) dynamically; their sources are available from the Debian archive (https://snapshot.debian.org/).

## Notices in the images

The released images ship only the binaries of these components; apart from CKPool (which ships its GPL text), their licence texts are not inside the images. They are provided here, alongside the release.

Container base images (Debian, Alpine, Python, nginx) keep their own licences and notices; the corresponding Debian sources are available from https://snapshot.debian.org/.

## Images of this release

- `alpine:3.22.1@sha256:4bcff63911fcb4448bd4fdacec207030997caf25e9bea4045fa6c8c44de311d1`
- `ghcr.io/kraskuscrypto/kraskus-5trat-btc-blake2b-knots:0.2.6@sha256:efe140d215ab6fac0ff0683a254d414f0774071296608c530606f36b1be4fc3e`
- `ghcr.io/kraskuscrypto/kraskus-5trat-btc-blake2b-datum:0.2.5@sha256:c1d7ab3a73caa8854bba4a2127fa273174645fd6da939456b43699143fc5ba39`
- `ghcr.io/kraskuscrypto/kraskus-5trat-btc-blake2b-adapter:0.2.6@sha256:65f34c4e4a7118e84b5f9a1092d00880fcdd9a39690212fbdec3dc97407c20c9`
- `ghcr.io/kraskuscrypto/kraskus-5trat-btc-blake2b-ui:0.2.6@sha256:6d45a2a417bd05b03044fd834107251f8e5fed41725e9738bb8157c632a6deec`

Recipe of this release: https://github.com/kraskuscrypto/Kraskus-Crypto-Store/tree/b7b1aa0/kraskus-btc-blake2b-solo

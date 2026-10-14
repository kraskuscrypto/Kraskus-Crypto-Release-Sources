# Pearl by Kraskus 0.5.1 — third-party components and notices

Kraskus Crypto components of this app (UI, API/adapter, controller, packaging) are proprietary and are not published or licensed here.

## Third-party components

| Component | Licence | Source | Licence text |
|---|---|---|---|
| Pearl node `pearld` and Oyster wallet v1.4.8 (official release archive, SHA-256 verified) | ISC | https://github.com/pearl-research-labs/pearl/tree/v1.4.8 | [pearl-1.4.8-LICENSE.txt](../../../third-party-licenses/pearl-1.4.8-LICENSE.txt) |
| Pearl Stratum gateway from commit `5b09d844e4069440933722c51495ac24a7bb4886` with two Kraskus patches (developer fee, proof metrics) | ISC | https://github.com/pearl-research-labs/pearl/tree/5b09d844e4069440933722c51495ac24a7bb4886 | [pearl-gateway-5b09d84-LICENSE.txt](../../../third-party-licenses/pearl-gateway-5b09d84-LICENSE.txt) |

## Gateway Python and Rust dependencies

Audited 2026-10-14 from the shipped gateway image (`kraskus-prl-solo-gateway@sha256:52253e64…`):

- 45 Python distributions. All are under permissive licences (MIT, BSD, Apache-2.0, PSF-2.0, ISC, CC0/Public Domain) except:
  - `python-bitcoinrpc` 1.0 — LGPL-2.1, unmodified pure-Python library, installed as source in the image's virtual environment and imported dynamically. Upstream: https://github.com/jgarzik/python-bitcoinrpc (PyPI `python-bitcoinrpc-1.0.tar.gz`). Licence: [`python-bitcoinrpc-LICENSE.txt`](../../../third-party-licenses/python-bitcoinrpc-LICENSE.txt).
  - `pearl-gateway` 0.1.0, `miner-utils` 0.1.0 and `py-pearl-mining` 0.3.1 carry no licence metadata; they are packages of the Pearl repository and fall under its ISC licence (commit `5b09d84`).
- `py-pearl-mining` compiles 185 crates.io dependencies (from its `Cargo.lock` at `5b09d84`); all are permissive (MIT and/or Apache-2.0, BSD-2-Clause, Zlib, Unlicense/MIT, CC0, Unicode-3.0; `r-efi` is MIT OR Apache-2.0 OR LGPL-2.1+ and is used under MIT/Apache-2.0).

## Notices in the images

The released images ship only the binaries of these components; apart from CKPool (which ships its GPL text), their licence texts are not inside the images. They are provided here, alongside the release.

Container base images (Debian, Alpine, Python, nginx) keep their own licences and notices; the corresponding Debian sources are available from https://snapshot.debian.org/.

## Images of this release

- `ghcr.io/kraskuscrypto/kraskus-prl-node:0.2.1@sha256:82bde309dd3e842f908f27e0058b9c38b292e40d50230524c1dd6b4704941b49`
- `ghcr.io/kraskuscrypto/kraskus-prl-solo-gateway:0.5.1@sha256:52253e64871319ffab2539c9a1a1a659f7b891166bd869a0f8c7a943cd39a6cb`
- `ghcr.io/kraskuscrypto/kraskus-prl-solo-api:0.5.1@sha256:c3801848e0eb730bfe24bc3b9d44af47769934c2dc85aa23509c88e697462c61`
- `ghcr.io/kraskuscrypto/kraskus-prl-solo-ui:0.5.1@sha256:f2cbbbf49f9e14eef26fcca7a3124fd89e135ce531105b918001ee353dfd01c8`

Recipe of this release: https://github.com/kraskuscrypto/Kraskus-Crypto-Store/tree/b7b1aa0/kraskus-prl-solo

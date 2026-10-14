# Bitcoin SV 0.5.2 — third-party components and notices

Kraskus Crypto components of this app (UI, API/adapter, controller, packaging) are proprietary and are not published or licensed here.

## Third-party components

| Component | Licence | Source | Licence text |
|---|---|---|---|
| SV Node 1.2.2: official image `bitcoinsv/bitcoin-sv@sha256:5aa32112ba1fd5a08df227118487d26d327493e1fff1f36979e3485ef6017e16` (release archive sha256 `d8b181c89fb6b76ff74487472d29d9d4ada6d2f186d89d84d33d9861d681e073`) with a Kraskus supervisor added | Open BSV License v5 (use limited to the Bitcoin SV blockchain) | https://github.com/bitcoin-sv/bitcoin-sv/tree/v1.2.2 | [sv-node-1.2.2-LICENSE.txt](../../../third-party-licenses/sv-node-1.2.2-LICENSE.txt) |

## SV Node licence conditions

SV Node is © BSV Association, licensed under the Open BSV License Version 5 ([`sv-node-1.2.2-LICENSE.txt`](../../../third-party-licenses/sv-node-1.2.2-LICENSE.txt)). The licence is non-exclusive and revocable, and requires that the software and any software derived from it **be used only on the BSV Blockchains**. This app runs SV Node only as a Bitcoin SV mainnet node.

## Notices in the images

The released images ship only the binaries of these components; apart from CKPool (which ships its GPL text), their licence texts are not inside the images. They are provided here, alongside the release.

Container base images (Debian, Alpine, Python, nginx) keep their own licences and notices; the corresponding Debian sources are available from https://snapshot.debian.org/.

## Images of this release

- `ghcr.io/kraskuscrypto/kraskus-bsv-solo:0.5.2@sha256:98d2cca010000ca5e07e8f1f80bdad76a8f6e77dc658f0ee30c41f1299fb0624`
- `ghcr.io/kraskuscrypto/kraskus-bsv-node:0.5.2@sha256:bcb744bcf5d3b36fc3f10392042191ce8cc366f798cddf05fda54873ef2638cb`
- `ghcr.io/kraskuscrypto/kraskus-bsv-solo-ui:0.5.2@sha256:ec037f258930402762c4dbc535747fdb357a66b376a7cb01a935f1d877cd388e`

Recipe of this release: https://github.com/kraskuscrypto/Kraskus-Crypto-Store/tree/b7b1aa0/kraskus-bsv-solo

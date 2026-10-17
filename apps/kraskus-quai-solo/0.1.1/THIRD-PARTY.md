# Quai Solo by Kraskus 0.1.1 — third-party components and notices

Kraskus Crypto components of this app (UI, API/adapter, launcher, packaging) are proprietary and are not published or licensed here.

## Third-party components

| Component | Licence | Source | Licence text |
|---|---|---|---|
| go-quai v0.56.1 (commit `5917bf5e`, unmodified, built from source; includes the built-in Stratum "StratumX") | GPL-3.0 | [quai/go-quai/0.1.1](../../../quai/go-quai/0.1.1/) (complete corresponding source) | [go-quai-0.56.1-COPYING.txt](../../../third-party-licenses/go-quai-0.56.1-COPYING.txt) |

## Notices in the images

The node image ships go-quai's `LICENSE` and the licence/notice files of every Go module compiled into the binary under `/usr/share/licenses/go-quai/`. Container base images (Alpine, Python, nginx) keep their own licences and notices.

## Images of this release

- `ghcr.io/kraskuscrypto/kraskus-5trat-quai-node:0.1.1@sha256:99a02552648cd84fc627b3897168fae4ed18bb498fe12bb0c9116b039e99b38c`
- `ghcr.io/kraskuscrypto/kraskus-5trat-quai-adapter:0.1.1@sha256:f78baab99f6b8393827e86ca23be98f10329348cb9cd69ded0c652bb97ef5f41`
- `ghcr.io/kraskuscrypto/kraskus-5trat-quai-ui:0.1.1@sha256:4b2e07cf3b03430b428308cf98ef303adf5c7f792d290ae58d35c673e3c35a2c`

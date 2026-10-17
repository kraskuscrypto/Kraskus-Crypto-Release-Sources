# Quai Solo by Kraskus 0.1.0 — third-party components and notices

Kraskus Crypto components of this app (UI, API/adapter, launcher, packaging) are proprietary and are not published or licensed here.

## Third-party components

| Component | Licence | Source | Licence text |
|---|---|---|---|
| go-quai v0.56.1 (commit `5917bf5e`, unmodified, built from source; includes the built-in Stratum "StratumX") | GPL-3.0 | [quai/go-quai/0.1.0](../../../quai/go-quai/0.1.0/) (complete corresponding source) | [go-quai-0.56.1-COPYING.txt](../../../third-party-licenses/go-quai-0.56.1-COPYING.txt) |

## Notices in the images

The node image ships go-quai's `LICENSE` and the licence/notice files of every Go module compiled into the binary under `/usr/share/licenses/go-quai/`. Container base images (Alpine, Python, nginx) keep their own licences and notices.

## Images of this release

- `ghcr.io/kraskuscrypto/kraskus-5trat-quai-node:0.1.0@sha256:60a574fdd129c8b4c3bc759126d4545f5e16bb1923f123f06392faa723cc7069`
- `ghcr.io/kraskuscrypto/kraskus-5trat-quai-adapter:0.1.0@sha256:a93f02952c3f515704c69999e92b958adf5f6ca99f9489469aeb12b93538dfa9`
- `ghcr.io/kraskuscrypto/kraskus-5trat-quai-ui:0.1.0@sha256:5ca10da236297d925ed03a9f9fcc7ef0aec23cfa641c10ae74d70d2d20203191`

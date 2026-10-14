# Monero by Kraskus 0.1.22 — third-party components and notices

Kraskus Crypto components of this app (UI, API/adapter, controller, packaging) are proprietary and are not published or licensed here.

## Third-party components

| Component | Licence | Source | Licence text |
|---|---|---|---|
| Monero CLI v0.18.5.1 (official release archive, SHA-256 verified) | BSD-3-Clause | https://github.com/monero-project/monero/tree/v0.18.5.1 | [monero-0.18.5.1-LICENSE.txt](../../../third-party-licenses/monero-0.18.5.1-LICENSE.txt) |
| XMRig Proxy v6.26.0 (official static release binary, unmodified, SHA-256 verified) | GPL-3.0 | https://github.com/xmrig/xmrig-proxy/tree/v6.26.0 | [xmrig-proxy-6.26.0-LICENSE.txt](../../../third-party-licenses/xmrig-proxy-6.26.0-LICENSE.txt) |

## XMRig Proxy (GPL-3.0) source

XMRig Proxy is redistributed unmodified. Exact source: tag `v6.26.0` = commit `0dc23f69b546ae973ae0ae6fb65593f998256589`, https://github.com/xmrig/xmrig-proxy/tree/0dc23f69b546ae973ae0ae6fb65593f998256589. The binary is the official release asset `xmrig-proxy-6.26.0-linux-static-x64.tar.gz` (sha256 `73cceb10be474ba8ce20faddb9d2c6af0cb50bce84e72f7d36a326f7147c01c4`, matching GitHub's published asset digest), verified during the image build.

## Notices in the images

The released images ship only the binaries of these components; apart from CKPool (which ships its GPL text), their licence texts are not inside the images. They are provided here, alongside the release.

Container base images (Debian, Alpine, Python, nginx) keep their own licences and notices; the corresponding Debian sources are available from https://snapshot.debian.org/.

## Images of this release

- `alpine:3.22.1@sha256:4bcff63911fcb4448bd4fdacec207030997caf25e9bea4045fa6c8c44de311d1`
- `ghcr.io/kraskuscrypto/kraskus-5trat-xmr-monerod:0.1.16@sha256:1d90d99963de534c6d566953985fc02dd527ef14c588ec2e7028e5ffcaf907da`
- `ghcr.io/kraskuscrypto/kraskus-5trat-xmr-adapter:0.1.16@sha256:b8b1ae475bc62f0a9f659d41529ddb339350cf21df6d7732867c330e92ec90bb`
- `ghcr.io/kraskuscrypto/kraskus-5trat-xmr-miner-gateway:0.1.20@sha256:f595e7e064864b374965e19420244ee5c6ed8c5ffc7efab0c60f8d59b2b68054`
- `ghcr.io/kraskuscrypto/kraskus-5trat-xmr-wallet-api:0.1.22@sha256:653d8a56229e386d136dbb134910a5a34e5bcc8359fdf688f16151d99876b784`
- `ghcr.io/kraskuscrypto/kraskus-5trat-xmr-ui:0.1.22@sha256:73cbfbc3982f77ecbd30112aa97cdc0f47de9e0c80d852bf05ede6fd516fa224`

Recipe of this release: https://github.com/kraskuscrypto/Kraskus-Crypto-Store/tree/b7b1aa0/kraskus-xmr-solo

# DigiByte 0.2.1 — third-party components and notices

Kraskus Crypto components of this app (UI, API/adapter, controller, packaging) are proprietary and are not published or licensed here.

## Third-party components

| Component | Licence | Source | Licence text |
|---|---|---|---|
| DigiByte Core v9.26.7 built unmodified from commit `d7265fb05e26e1e799876bcd526225e4826c3ba8` (tag verified at build) | MIT | https://github.com/DigiByte-Core/digibyte/tree/v9.26.7 | [digibyte-core-9.26.7-COPYING.txt](../../../third-party-licenses/digibyte-core-9.26.7-COPYING.txt) |
| libdgbpow: Kraskus C wrapper compiled with DigiByte Core's own sha256/hmac_sha256/scrypt/sph-skein sources | MIT | https://github.com/DigiByte-Core/digibyte/tree/v9.26.7 | [digibyte-core-9.26.7-COPYING.txt](../../../third-party-licenses/digibyte-core-9.26.7-COPYING.txt) |

## Notices in the images

The released images ship only the binaries of these components; apart from CKPool (which ships its GPL text), their licence texts are not inside the images. They are provided here, alongside the release.

Container base images (Debian, Alpine, Python, nginx) keep their own licences and notices; the corresponding Debian sources are available from https://snapshot.debian.org/.

## Images of this release

- `ghcr.io/kraskuscrypto/kraskus-dgb-solo-adapter:0.2.1@sha256:93bb7ad48dd75e01a49c52973ca31bc6c255220cbe9f09a83a3492a87e05e88c`
- `ghcr.io/kraskuscrypto/kraskus-dgb-solo-node:0.1.3@sha256:32efdc8ecd8c5b3866539cda24efabd0ed3cd209dc41c5d06e5fb00bc71f8a33`
- `ghcr.io/kraskuscrypto/kraskus-dgb-solo-stratum:0.1.3@sha256:37c823fe16e1e603707b9b5e19602b345004aac8b4bf9d5ce5e449aedc9cba40`
- `ghcr.io/kraskuscrypto/kraskus-dgb-solo-ui:0.2.1@sha256:7347bfe94fe2fe4063dee7d5297edcf2c46bc25b5473b091f9dd1118c88fda1b`

Recipe of this release: https://github.com/kraskuscrypto/Kraskus-Crypto-Store/tree/b7b1aa0/kraskus-dgb-solo

# CheetahCoin by Kraskus 0.5.2 — third-party components and notices

Kraskus Crypto components of this app (UI, API/adapter, controller, packaging) are proprietary and are not published or licensed here.

## Third-party components

| Component | Licence | Source | Licence text |
|---|---|---|---|
| CheetahCoin Core 2.5.0 (official release binaries `cheetahcoind`, `cheetahcoin-cli`, SHA-256 verified) | MIT | https://github.com/ShorelineCrypto/cheetahcoin/tree/v2.5.0 | [cheetahcoin-core-2.5.0-COPYING.txt](../../../third-party-licenses/cheetahcoin-core-2.5.0-COPYING.txt) |
| CKPool, NMminer fractional-difficulty fork at commit `49b45c25940f2138955c4503e1da55f19cea8de9`, **modified by Kraskus** (configurable developer-fee address, fail-closed fee-address validation, fractional-difficulty and reject-count accounting, portable SHA-256 build) | GPL-3.0-only | https://github.com/NMminer1024/btc-ckpool-solo/tree/49b45c25940f2138955c4503e1da55f19cea8de9 | [ckpool-49b45c2-COPYING.txt](../../../third-party-licenses/ckpool-49b45c2-COPYING.txt) |

## CKPool corresponding source

The CKPool in `ghcr.io/kraskuscrypto/kraskus-chta-ckpool:0.3.1` is modified. Its complete corresponding source, build recipe, modification notice and image mapping: https://github.com/kraskuscrypto/Kraskus-Crypto-Release-Sources/tree/main/chta/ckpool/0.3.1

## Notices in the images

The released images ship only the binaries of these components; apart from CKPool (which ships its GPL text), their licence texts are not inside the images. They are provided here, alongside the release.

Container base images (Debian, Alpine, Python, nginx) keep their own licences and notices; the corresponding Debian sources are available from https://snapshot.debian.org/.

## Images of this release

- `ghcr.io/kraskuscrypto/kraskus-chta-solo:0.5.2@sha256:94fd7d89bba150cc08cce65e21d49fbac4e0cc1541ed0adb91f6d5979847416b`
- `ghcr.io/kraskuscrypto/kraskus-cheetahcoin-core:0.5.0@sha256:2a4a4d30010f04fd4304a0241d51ad0027502e59d0728d464533aad2b3e08742`
- `ghcr.io/kraskuscrypto/kraskus-chta-ckpool:0.3.1@sha256:2355f9ca770776dcaa3f4091cb57af827b58338f80065a3d3ecf9b92c8618082`
- `ghcr.io/kraskuscrypto/kraskus-chta-ui:0.5.2@sha256:2a5b36c2681db4681164f73dcf07cb03eabb86203e2b683377a8f2df7e7a2ac0`

Recipe of this release: https://github.com/kraskuscrypto/Kraskus-Crypto-Store/tree/b7b1aa0/kraskus-chta-solo

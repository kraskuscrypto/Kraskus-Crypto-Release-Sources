# CKPool (CHTA) — corresponding source

Kraskus builds CKPool for CheetahCoin by Kraskus from the NMminer
fractional-difficulty fork of CKPool, with Kraskus modifications.

- Upstream: https://github.com/NMminer1024/btc-ckpool-solo
- Upstream commit (every image below): [`49b45c25940f2138955c4503e1da55f19cea8de9`](https://github.com/NMminer1024/btc-ckpool-solo/tree/49b45c25940f2138955c4503e1da55f19cea8de9)
- Licence: GNU General Public License v3.0 only (see each folder's `COPYING`)
- Images: `ghcr.io/kraskuscrypto/kraskus-chta-ckpool`

| Image tag | Status | Image digest | `/usr/bin/ckpool` sha256 |
|---|---|---|---|
| [`0.3.1`](0.3.1/) | **current** | `sha256:2355f9ca770776dcaa3f4091cb57af827b58338f80065a3d3ecf9b92c8618082` | `4bb9f3a78be7bfb50f4edf92dc0378de3f4f864e88df7b031946f2b48bf6aa8c` |
| [`0.3.0`](0.3.0/) | superseded | `sha256:1d15221c99d099e3a7b6cff988d3fa6280ebb45a14caa14bde431b5991dc5636` | `f0b0147288759fb9bbdb944edb61d7bac5a7fdd95a7c65568b2981c93a7dcf1e` |
| [`0.2.34-dev15`](0.2.34-dev15/) | pre-release | `sha256:ad16b3e4a4c55d2786cb11792c84feacad30eba39f2903c7f328977798ab9440` | `8e5746d36616c166ae48657693ec9d9067f835268e0bde0d2dfee126bfae0f02` |
| [`candidate9-qualified`](candidate9-qualified/) | pre-release | `sha256:fafa08b00a243cd4047a0ff1735573c8a1119149a9afb18abc1f052c050f1588` | `79f596b43a4d837aac2cd19b31be14403e45aa01118ba0d2e54cb8e303e30718` |

Each folder contains the complete corresponding source for that image: the
patched source tree (`*-source.tar.gz`), the Kraskus modifications as a unified
diff against the upstream commit, the exact builder `Dockerfile` (and patch),
build instructions, a dated modification notice, the licence and the
image-to-source mapping.

The Kraskus CKPool **supervisor** script that some images also contain
(`/usr/local/bin/kraskus-ckpool-supervisor`) is a separate Kraskus program that
starts and stops CKPool; it is not part of CKPool and is not covered here.
See [`SUPERVISOR.md`](SUPERVISOR.md) for why it is a separate program.

# Image ↔ source mapping

| Item | Value |
|---|---|
| Image | `ghcr.io/kraskuscrypto/kraskus-chta-ckpool:0.3.0` |
| Image digest | `sha256:1d15221c99d099e3a7b6cff988d3fa6280ebb45a14caa14bde431b5991dc5636` (application/vnd.docker.distribution.manifest.v2+json) |
| Config digest | `sha256:6ef90eca865db2a925810380cb0bc53fbc4e403c8994f2f076c9b3a948083ecb` |
| Created | 2026-09-24T12:25:21.887697356Z |
| Platform | linux/amd64 |
| `/usr/bin/ckpool` sha256 | `f0b0147288759fb9bbdb944edb61d7bac5a7fdd95a7c65568b2981c93a7dcf1e` (2498224 bytes) |
| `/usr/share/licenses/ckpool/COPYING` sha256 | `8ceb4b9ee5adedde47b31e975c1d90c73ad27b6b165a1dcd80c7c545eb65b903` (identical to `COPYING` here) |
| Kraskus build revision | `391683bf208fca83839f3012d60b9ba6032ed177` (OCI label `org.opencontainers.image.revision`) |
| Upstream commit | `49b45c25940f2138955c4503e1da55f19cea8de9` |
| Used by | CheetahCoin by Kraskus 0.3.0 (superseded; image still publicly pullable) |

Verification performed 2026-10-14: the published Dockerfile's source steps were
replayed on the upstream commit (all built-in `grep -c` guards passed) and the
resulting tree's distinguishing markers were checked against strings in the
shipped binary.

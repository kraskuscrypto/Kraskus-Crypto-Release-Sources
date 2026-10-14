# Image ↔ source mapping

| Item | Value |
|---|---|
| Image | `ghcr.io/kraskuscrypto/kraskus-chta-ckpool:0.3.1` |
| Image digest | `sha256:2355f9ca770776dcaa3f4091cb57af827b58338f80065a3d3ecf9b92c8618082` (application/vnd.docker.distribution.manifest.v2+json) |
| Config digest | `sha256:1c94fe06c7a46221d22471c65a8b62f3c9c6fc38d7b11a573d07a2d5e2fafd26` |
| Created | 2026-09-26T23:07:59.672865591Z |
| Platform | linux/amd64 |
| `/usr/bin/ckpool` sha256 | `4bb9f3a78be7bfb50f4edf92dc0378de3f4f864e88df7b031946f2b48bf6aa8c` (2498376 bytes) |
| `/usr/share/licenses/ckpool/COPYING` sha256 | `8ceb4b9ee5adedde47b31e975c1d90c73ad27b6b165a1dcd80c7c545eb65b903` (identical to `COPYING` here) |
| Kraskus build revision | `a667f1364634d66c8eb1569f9a78f82123ab4ee8` (OCI label `org.opencontainers.image.revision`) |
| Upstream commit | `49b45c25940f2138955c4503e1da55f19cea8de9` |
| Used by | CheetahCoin by Kraskus 0.3.1 and 0.5.x (current release 0.5.2), services `pool` and `pool_lowhash` |

Verification performed 2026-10-14: the published Dockerfile's source steps were
replayed on the upstream commit (all built-in `grep -c` guards passed) and the
resulting tree's distinguishing markers were checked against strings in the
shipped binary.

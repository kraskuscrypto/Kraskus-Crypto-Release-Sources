# Image ↔ source mapping

| Item | Value |
|---|---|
| Image | `ghcr.io/kraskuscrypto/kraskus-chta-ckpool:candidate9-qualified` |
| Image digest | `sha256:fafa08b00a243cd4047a0ff1735573c8a1119149a9afb18abc1f052c050f1588` (application/vnd.docker.distribution.manifest.v2+json) |
| Config digest | `sha256:0642e7d912c12e59b64fb65517955b28051cfd1c5c01adb7370ce8b251c6acb7` |
| Created | 2026-08-26T12:14:53.887553992Z |
| Platform | linux/amd64 |
| `/usr/bin/ckpool` sha256 | `79f596b43a4d837aac2cd19b31be14403e45aa01118ba0d2e54cb8e303e30718` (2499568 bytes) |
| `/usr/share/licenses/ckpool/COPYING` sha256 | `8ceb4b9ee5adedde47b31e975c1d90c73ad27b6b165a1dcd80c7c545eb65b903` (identical to `COPYING` here) |
| Kraskus build revision | none (image has no OCI labels; see `PROVENANCE.md`) |
| Upstream commit | `49b45c25940f2138955c4503e1da55f19cea8de9` |
| Used by | pre-release qualification build (never in a Kraskus store release; image still publicly pullable) |

Verification performed 2026-10-14: the published Dockerfile's source steps were
replayed on the upstream commit (all built-in `grep -c` guards passed) and the
resulting tree's distinguishing markers were checked against strings in the
shipped binary.

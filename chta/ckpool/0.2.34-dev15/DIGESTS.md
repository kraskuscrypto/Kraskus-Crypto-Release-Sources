# Image ↔ source mapping

| Item | Value |
|---|---|
| Image | `ghcr.io/kraskuscrypto/kraskus-chta-ckpool:0.2.34-dev15` |
| Image digest | `sha256:ad16b3e4a4c55d2786cb11792c84feacad30eba39f2903c7f328977798ab9440` (application/vnd.oci.image.index.v1+json) |
| amd64 image manifest | `sha256:61cc90414b5cd5ba53d01a780feb02c696a8fb4d77f880e99153e7375a86e937` |
| Config digest | `sha256:48a5b59952488c3c54be7dd4548b63540cbd0ccc30f34a6bfa3a1cf7544813b5` |
| Created | 2026-09-19T14:02:44.265351655Z |
| Platform | linux/amd64 |
| `/usr/bin/ckpool` sha256 | `8e5746d36616c166ae48657693ec9d9067f835268e0bde0d2dfee126bfae0f02` (2498104 bytes) |
| `/usr/share/licenses/ckpool/COPYING` sha256 | `8ceb4b9ee5adedde47b31e975c1d90c73ad27b6b165a1dcd80c7c545eb65b903` (identical to `COPYING` here) |
| Kraskus build revision | none (image has no OCI labels; see `PROVENANCE.md`) |
| Upstream commit | `49b45c25940f2138955c4503e1da55f19cea8de9` |
| Used by | pre-release development build (never in a Kraskus store release; image still publicly pullable) |

Verification performed 2026-10-14: the published Dockerfile's source steps were
replayed on the upstream commit (all built-in `grep -c` guards passed) and the
resulting tree's distinguishing markers were checked against strings in the
shipped binary.

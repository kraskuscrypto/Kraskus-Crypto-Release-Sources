# Image ↔ source mapping

| Item | Value |
|---|---|
| Image | `ghcr.io/kraskuscrypto/kraskus-5trat-quai-node:0.1.0` |
| Image digest | `sha256:60a574fdd129c8b4c3bc759126d4545f5e16bb1923f123f06392faa723cc7069` |
| Config digest (image ID) | `sha256:1c3e58746285f799204629c52cb036f8a630910605703b2b339dc7a37bb69fff` |
| Created | 2026-10-16T20:16:47.645111697Z |
| Platform | linux/amd64 |
| `/opt/go-quai/go-quai` sha256 | `c3ef988aaa9912fece9b5d2115036346a06808b5c3b1fdb1f689a92c45c4bac2` (74113368 bytes) |
| `/usr/share/licenses/go-quai/LICENSE` sha256 | `e57f1c320b8cf8798a7d2ff83a6f9e06a33a03585f6e065fea97f1d86db84052` (identical to `COPYING` here) |
| `/usr/share/licenses/go-quai/deps/modules.txt` | identical to `go-quai-v0.56.1-5917bf5e-modules.txt` here |
| `/usr/local/bin/quai-node-entrypoint.sh` | identical to `quai-node-entrypoint.sh` here |
| Kraskus build revision | `6a2035851f3be62d97553822bce9617382271ca1` (OCI label `org.opencontainers.image.revision`) |
| Upstream commit | `5917bf5e2ced1d3f1cafdde6bc6fa3345fb71c3e` (go-quai `v0.56.1`, unmodified) |
| Used by | Quai Solo by Kraskus 0.1.0 |

Verification performed 2026-10-17: the source tarballs here were exported from the
same build cache that produced the image (`--target source-bundle`, every builder
layer cached). Building offline from them as described in `BUILD.md` (`GOPROXY=off`,
modules only from the published module cache) gave a `go-quai` binary bit-identical
to the one in the image (sha256 above).

Note: the `SOURCE.md` text inside this image (`/usr/share/licenses/go-quai/SOURCE.md`)
describes an earlier vendored-build plan and names a `…-vendored-source.tar.gz`
file. The image was built in module mode; the files that apply are the ones in this
folder. The text is corrected in the next release.

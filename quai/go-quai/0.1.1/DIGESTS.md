# Image ↔ source mapping

| Item | Value |
|---|---|
| Image | `ghcr.io/kraskuscrypto/kraskus-5trat-quai-node:0.1.1` |
| Image digest | `sha256:99a02552648cd84fc627b3897168fae4ed18bb498fe12bb0c9116b039e99b38c` |
| Config digest (image ID) | `sha256:8bf5e0dd986ed2b4f45a755cb6757780b5d7f63a9cef2ed0989b0ff2dd02afd5` |
| Created | 2026-10-17T05:29:24.078162814Z |
| Platform | linux/amd64 |
| `/opt/go-quai/go-quai` sha256 | `c3ef988aaa9912fece9b5d2115036346a06808b5c3b1fdb1f689a92c45c4bac2` (74113368 bytes; bit-identical to 0.1.0) |
| `/usr/share/licenses/go-quai/LICENSE` sha256 | `e57f1c320b8cf8798a7d2ff83a6f9e06a33a03585f6e065fea97f1d86db84052` (identical to `COPYING` here) |
| `/usr/share/licenses/go-quai/SOURCE.md` | identical to `SOURCE.md` here (corrects the 0.1.0 erratum) |
| Kraskus build revision | `e43f596` (OCI label `org.opencontainers.image.revision`) |
| Upstream commit | `5917bf5e2ced1d3f1cafdde6bc6fa3345fb71c3e` (go-quai `v0.56.1`, unmodified) |
| Used by | Quai Solo by Kraskus 0.1.1 |

## Corresponding source

The 0.1.1 node image was built from exactly the same inputs as 0.1.0: the
`--target source-bundle` export of this build produced files byte-identical to the
ones published in [`../0.1.0/`](../0.1.0/), which are the complete corresponding
source of this image (read `../0.1.0/BUILD.md` for the build):

| File in `../0.1.0/` | sha256 (identical for 0.1.1) |
|---|---|
| `go-quai-5917bf5e.tar` | `4ff7dae5cc9f20d0bd9e18de9748763548cd20af67dfcbc942f8602d2f39ad50` |
| `go-quai-v0.56.1-5917bf5e-source.tar.gz` | `22792c095467f53382a93adf918c0bb46c64b6954799c8b7c8164da2f7eba8b6` |
| `go-quai-v0.56.1-5917bf5e-gomodcache.tar.gz` (parts 00–02 joined) | `1640875d73707d644354610ed1511d1efcd210c9f3530a8af52ed0dd7682cbc7` |
| `go-quai-v0.56.1-5917bf5e-modules.txt` | `fb2259c4daea3d97624e98811bed8f4f5b558bd5c71c928d9471013db982d3e4` |
| `Dockerfile.node` | `94802a3bf827aa74c7efa382ac10f159967a46080f7a5ab1a78f245644e0929c` |
| `quai-node-entrypoint.sh` | `70f6cb083214dfaaf6eb27470cb84c4580e12e972dd4a6d216b4dff73d39cfd5` |

The only change in the node image from 0.1.0 is `/usr/share/licenses/go-quai/SOURCE.md`
(documentation). Kraskus modifications to go-quai: none.

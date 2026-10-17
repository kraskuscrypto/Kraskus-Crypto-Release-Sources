# go-quai: corresponding source (GPL-3.0)

The Quai Solo node image contains the `go-quai` binary, licensed under the
**GNU General Public License v3.0** (`LICENSE` in this folder, byte-identical
to upstream; sha256 `e57f1c320b8cf8798a7d2ff83a6f9e06a33a03585f6e065fea97f1d86db84052`).

| Item | Value |
|---|---|
| Upstream | https://github.com/dominant-strategies/go-quai |
| Tag | `v0.56.1` (released 2026-10-07) |
| Commit | `5917bf5e2ced1d3f1cafdde6bc6fa3345fb71c3e` |
| Upstream source tar | `git archive --format=tar 5917bf5e…` = sha256 `4ff7dae5cc9f20d0bd9e18de9748763548cd20af67dfcbc942f8602d2f39ad50` |
| Licence | GPL-3.0 (whole repository) |
| Kraskus modifications | **None.** The built-in Stratum ("StratumX", `stratum/`) is used as shipped. |
| Build | `runtime/Dockerfile.node`: module mode (`go mod download && go mod verify`, every module checked against `go.sum`), then `make go-quai` (upstream `build/ci.go` adds `-trimpath`), Go 1.24.9 (`golang:1.24.9-alpine3.22@sha256:8f8959f3…`), `GOTOOLCHAIN=local`, `GOFLAGS=-mod=mod`. A vendored build is not possible: `go mod vendor` drops the C sources of cgo dependencies. |

## How a recipient gets the source (owner decision 2026-10-16: mirror per release)

Kraskus publishes the **exact corresponding source next to every released node
image** (GPL-3.0 §6(d)) in the public repository
https://github.com/kraskuscrypto/Kraskus-Crypto-Release-Sources under
`quai/go-quai/<app version>/`, tagged and immutable:

- `go-quai-v0.56.1-5917bf5e-source.tar.gz`: the upstream tree exactly as
  compiled, produced by the image build itself (`build.sh --source-bundle`);
- `go-quai-v0.56.1-5917bf5e-gomodcache.tar.gz` (published in parts): the Go
  module cache download zips of every dependency, verified against `go.sum`,
  and `go-quai-v0.56.1-5917bf5e-modules.txt` (the modules compiled in);
- `go-quai-5917bf5e.tar`: the pinned upstream `git archive`;
- `Dockerfile.node`, `quai-node-entrypoint.sh`, `BUILD.md` (exact build
  instructions), `DIGESTS.md` (image-to-source mapping), `COPYING` (GPL-3.0),
  `SHA256SUMS`.

Inside the image, `/usr/share/licenses/go-quai/` holds the GPL-3.0 `LICENSE`,
this `SOURCE.md` and `deps/` (the licence and notice files of every vendored Go
module, plus `modules.txt`).

## Image to source mapping

Recorded per release in `DIGESTS.md` of the release-sources folder and in
`release-manifest.json` (`images.node.digest`).

If Kraskus ever modifies go-quai, each change is listed here and published as a
diff with the modified source before the image is distributed.

## Not distributed

KawPoW GPU miners and SHA-256 or Scrypt ASIC firmware are **not** bundled.
Miners bring their own.

# Build: go-quai for `ghcr.io/kraskuscrypto/kraskus-5trat-quai-node:0.1.0`

## Inputs

- Upstream source: https://github.com/dominant-strategies/go-quai, tag `v0.56.1`, commit `5917bf5e2ced1d3f1cafdde6bc6fa3345fb71c3e`
- `go-quai-5917bf5e.tar`: `git archive --format=tar 5917bf5e2ced1d3f1cafdde6bc6fa3345fb71c3e`
  (byte-exact; sha256 `4ff7dae5cc9f20d0bd9e18de9748763548cd20af67dfcbc942f8602d2f39ad50`; on Windows run git with
  `-c core.autocrlf=false -c core.eol=lf`)
- `go-quai-v0.56.1-5917bf5e-source.tar.gz`: the upstream tree exactly as compiled (produced by the image build)
- `go-quai-v0.56.1-5917bf5e-gomodcache.tar.gz`: the Go module cache download zips of every dependency, each verified
  against `go.sum` (`go mod download && go mod verify`) — the dependency source the binary is compiled from.
  Published in three parts (`.part-00` … `.part-02`, GitHub's 100 MB file limit); join them first:
  `cat go-quai-v0.56.1-5917bf5e-gomodcache.tar.gz.part-* > go-quai-v0.56.1-5917bf5e-gomodcache.tar.gz`
  (sha256 of the joined file: `1640875d73707d644354610ed1511d1efcd210c9f3530a8af52ed0dd7682cbc7`)
- `go-quai-v0.56.1-5917bf5e-modules.txt`: the modules compiled into the binary (`go list -deps`), with versions
- Kraskus modifications to go-quai: **none**
- Build recipe: `Dockerfile.node` (exact file used for this image) and the launcher `quai-node-entrypoint.sh`
  (a separate shell script; it does not modify go-quai)

## Build environment

- Builder image: `golang:1.24.9-alpine3.22@sha256:8f8959f38530d159bf71d0b3eb0c547dc61e7959d8225d1599cf762477384923`
  with `make gcc musl-dev tar` (Alpine packages, unmodified), `GOTOOLCHAIN=local CGO_ENABLED=1 GOFLAGS=-mod=mod`
- Runtime image: `alpine:3.22@sha256:5291449c3df73caf6ed85e649dec1b9e818b39a5d8c871e97afc13e9cd5e8fa8` with
  `ca-certificates curl tini`

## Build from the published source (offline)

```sh
cat go-quai-v0.56.1-5917bf5e-gomodcache.tar.gz.part-* > go-quai-v0.56.1-5917bf5e-gomodcache.tar.gz
tar -xzf go-quai-v0.56.1-5917bf5e-source.tar.gz                     # -> src/
tar -xzf go-quai-v0.56.1-5917bf5e-gomodcache.tar.gz                 # -> gomodcache/cache/download
cd src
GOMODCACHE="$PWD/../gomodcache" GOFLAGS=-mod=mod GOPROXY=off make go-quai
# result: build/bin/go-quai  (upstream build/ci.go adds -trimpath)
```

## Build with the original recipe

```sh
mkdir ctx && cp go-quai-5917bf5e.tar Dockerfile.node quai-node-entrypoint.sh ctx/
touch ctx/SOURCE.md   # the image's licence-folder text (Kraskus document, not part of go-quai)
docker build -f ctx/Dockerfile.node --build-arg APP_VERSION=0.1.0 --build-arg SOURCE_REVISION=<revision> ctx
docker build -f ctx/Dockerfile.node --target source-bundle --output type=local,dest=out ctx   # regenerates the tarballs
```

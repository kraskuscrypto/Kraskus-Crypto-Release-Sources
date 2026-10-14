# Build — CKPool for `ghcr.io/kraskuscrypto/kraskus-chta-ckpool:0.3.0`

## Inputs

- Upstream source: https://github.com/NMminer1024/btc-ckpool-solo at commit `49b45c25940f2138955c4503e1da55f19cea8de9`
- Kraskus modifications: `kraskus-modifications.diff` (unified diff against that commit)
- Complete modified source tree: `ckpool-49b45c2-kraskus-0.3.0-source.tar.gz`
- Builder recipe: `Dockerfile` (exact file used for this image; source: private Kraskus-Crypto-Apps commit 391683b (apps/chta-solo/packaging/ckpool/Dockerfile))

## Build environment

- Builder and runtime base image: `debian:trixie-slim@sha256:a99cfc517144bc59b1978475ec53b46ecabec7e43635402ee5b77cc54cd1b20a` (the dev15/candidate9 recipes name `debian:trixie-slim` by tag)
- Build packages (Debian, unmodified): `ca-certificates git build-essential yasm autoconf automake libtool libzmq3-dev pkgconf`
- Runtime package: `libzmq5` (0.3.x) or `libzmq3-dev` (pre-release builds)

## Build from the source tarball

```sh
tar -xzf ckpool-49b45c2-kraskus-0.3.0-source.tar.gz
cd ckpool-49b45c2-kraskus-0.3.0
./autogen.sh
./configure
make -j"$(nproc)"
# result: src/ckpool
```

`./configure` is run without options, exactly as in the Dockerfile.

## Build from upstream + diff

```sh
git clone https://github.com/NMminer1024/btc-ckpool-solo.git ckpool && cd ckpool
git checkout --detach 49b45c25940f2138955c4503e1da55f19cea8de9
git apply ../kraskus-modifications.diff
./autogen.sh && ./configure && make -j"$(nproc)"
```

## Build with the original recipe

The `Dockerfile` is the unmodified recipe. Its builder stage clones the upstream
commit and applies the modifications with checked `sed`/`awk` edits (and
`git apply` where shown), then runs the commands above. Its final stage also copies the separate Kraskus supervisor script, which is not part of CKPool and is not published here; build only the `builder` stage (`docker build --target builder .`) to reproduce `src/ckpool`.

Builds are not bit-for-bit reproducible; the image-to-source mapping is recorded
in `DIGESTS.md`.

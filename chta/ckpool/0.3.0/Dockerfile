# CHTA CKPool runtime, used by BOTH Stratum entrances (compose services `pool`
# = NORMAL 1926 and `pool_lowhash` = LOW-DIFF 1927). The two differ only in the
# config file the supervisor is pointed at; see kraskus_solo/coins/chta/pool_config.py.
#
# Build context: apps/chta-solo. Built only by apps/chta-solo/build.sh.
#
# The previously qualified WillItMod image pinned upstream ckpool where
# mindiff/startdiff are int64_t and cannot represent the sub-1 share
# difficulties MH/s-class NMMiner devices need. This image builds the NMminer
# fractional-difficulty fork from an immutable, verified source commit. All
# source is rebuilt in the builder stage; only the ckpool binary, its runtime
# library and the Kraskus supervisor are carried into the final image.

ARG CKPOOL_COMMIT=49b45c25940f2138955c4503e1da55f19cea8de9

FROM debian:trixie-slim@sha256:a99cfc517144bc59b1978475ec53b46ecabec7e43635402ee5b77cc54cd1b20a AS builder
ARG CKPOOL_COMMIT

RUN apt-get update \
 && apt-get install --yes --no-install-recommends \
      ca-certificates git build-essential yasm autoconf automake libtool \
      libzmq3-dev pkgconf \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /build
RUN git clone https://github.com/NMminer1024/btc-ckpool-solo.git . \
 && git checkout --detach "$CKPOOL_COMMIT" \
 && test "$(git rev-parse HEAD)" = "$CKPOOL_COMMIT"

# Required CHTA developer-fee support. Upstream CKPool already constructs a
# two-output coinbase whenever donation > 0, but hard-codes its own donation
# address after parse_config(). Make that address configurable.
RUN test "$(grep -F -c 'json_get_double(&ckp->donation, json_conf, "donation");' src/ckpool.c)" = "1" \
 && sed -i '/json_get_double(&ckp->donation, json_conf, "donation");/a\	json_get_string(\&ckp->donaddress, json_conf, "donaddress");' src/ckpool.c \
 && test "$(grep -F -c 'json_get_string(&ckp->donaddress, json_conf, "donaddress");' src/ckpool.c)" = "1" \
 && test "$(grep -F -c 'ckp.donaddress = "bc1q5gq32mvu3cltkcw2sx9nyc5udx3zy0gt82002c";' src/ckpool.c)" = "1" \
 && sed -i 's/ckp\.donaddress = "bc1q5gq32mvu3cltkcw2sx9nyc5udx3zy0gt82002c";/if (!ckp.donaddress)\n\t\tckp.donaddress = "bc1q5gq32mvu3cltkcw2sx9nyc5udx3zy0gt82002c";/' src/ckpool.c \
 && test "$(grep -F -c 'if (!ckp.donaddress)' src/ckpool.c)" = "1"

# 0.3.0 fee hardening. Upstream falls back to its own BTC testnet/regtest
# donation addresses when the configured one does not validate, and otherwise
# silently mines with the fee disabled. For CHTA both outcomes are wrong:
#   1. the testnet/regtest fallbacks become the configured address itself;
#   2. a configured fee (donation > 0) whose address does not validate against
#      the node is fatal -- CKPool exits and the supervisor reports ERROR.
RUN test "$(grep -F -c 'ckp.tndonaddress = "tb1q5fyv7tue73y4zxezh2c685qpwx0cfngfxlrgxh";' src/ckpool.c)" = "1" \
 && test "$(grep -F -c 'ckp.rtdonaddress = "bcrt1qlk935ze2fsu86zjp395uvtegztrkaezawxx0wf";' src/ckpool.c)" = "1" \
 && sed -i 's/ckp\.tndonaddress = "tb1q5fyv7tue73y4zxezh2c685qpwx0cfngfxlrgxh";/ckp.tndonaddress = ckp.donaddress;/' src/ckpool.c \
 && sed -i 's/ckp\.rtdonaddress = "bcrt1qlk935ze2fsu86zjp395uvtegztrkaezawxx0wf";/ckp.rtdonaddress = ckp.donaddress;/' src/ckpool.c \
 && test "$(grep -F -c 'ckp.tndonaddress = ckp.donaddress;' src/ckpool.c)" = "1" \
 && test "$(grep -F -c 'ckp.rtdonaddress = ckp.donaddress;' src/ckpool.c)" = "1" \
 && test "$(grep -F -c 'LOGNOTICE("No valid donation address found");' src/stratifier.c)" = "1" \
 && sed -i 's/LOGNOTICE("No valid donation address found");/{ if (ckp->donation > 0) quit(1, "Kraskus: developer-fee address %s is invalid; refusing to mine with the fee disabled", ckp->donaddress); LOGNOTICE("No valid donation address found"); }/' src/stratifier.c \
 && test "$(grep -F -c 'Kraskus: developer-fee address %s is invalid' src/stratifier.c)" = "1"

# Guard the exact upstream accounting shape before modifying it. There are two
# difficulty-weighted paths in this pinned revision. If upstream changes, fail
# the build rather than silently applying a partial or incorrect patch.
RUN test "$(grep -F -c 'unaccounted_diff_shares += MAX(1, diff);' src/stratifier.c)" = "2" \
 && sed -i 's/unaccounted_diff_shares += MAX(1, diff);/unaccounted_diff_shares += diff;/g' src/stratifier.c \
 && test "$(grep -F -c 'unaccounted_diff_shares += MAX(1, diff);' src/stratifier.c)" = "0" \
 && test "$(grep -F -c 'unaccounted_diff_shares += diff;' src/stratifier.c)" = "2"

# Preserve fractional difficulty through the periodic pool-stat snapshot.
# In the pinned fork these temporary variables are int64_t even though the
# backing pool statistics are doubles; sub-1 difficulty is therefore
# truncated to zero before dsps/hashrate accounting.
RUN test "$(grep -F -c 'int64_t unaccounted_shares,' src/stratifier.c)" = "1" \
 && sed -i 's/int64_t unaccounted_shares,/double unaccounted_shares,/' src/stratifier.c \
 && test "$(grep -F -c 'int64_t unaccounted_shares,' src/stratifier.c)" = "0" \
 && test "$(grep -F -c 'double unaccounted_shares,' src/stratifier.c)" = "1"

# Expose accepted submission count separately without changing CKPool's
# historical "accepted" field. Anchor the edit to the unique pool.status
# JSON_CPACK format in the pinned source.
RUN test "$(grep -F -c 'JSON_CPACK(val, "{sf,sf,sf,sf,sf,sf,sf,sf,sf}",' src/stratifier.c)" = "1" \
 && sed -i 's/JSON_CPACK(val, "{sf,sf,sf,sf,sf,sf,sf,sf,sf}",/JSON_CPACK(val, "{sf,sf,sf,sf,sf,sf,sf,sf,sf,sf}",/' src/stratifier.c \
 && awk 'BEGIN { in_pool_status = 0 } \
    index($0, "JSON_CPACK(val, \"{sf,sf,sf,sf,sf,sf,sf,sf,sf,sf}\",") { in_pool_status = 1 } \
    { print } \
    in_pool_status && index($0, "\"accepted\", stats->accounted_diff_shares,") { \
        print "                                \"accepted_shares\", stats->accounted_shares,"; \
        in_pool_status = 0 \
    }' src/stratifier.c > src/stratifier.c.tmp \
 && mv src/stratifier.c.tmp src/stratifier.c \
 && test "$(grep -F -c '"accepted_shares", stats->accounted_shares,' src/stratifier.c)" = "1" \
 && test "$(grep -F -c 'JSON_CPACK(val, "{sf,sf,sf,sf,sf,sf,sf,sf,sf}",' src/stratifier.c)" = "0" \
 && test "$(grep -F -c 'JSON_CPACK(val, "{sf,sf,sf,sf,sf,sf,sf,sf,sf,sf}",' src/stratifier.c)" = "1"

# Portable release build: upstream probes /proc/cpuinfo inside the build
# container and compiles one host-native SHA256 assembly variant. That makes
# the resulting image depend on the builder CPU. Force all native SHA flags
# empty immediately before the Automake conditionals so every builder uses
# CKPool's portable C SHA256 implementation instead.
RUN sed -i '/AM_CONDITIONAL(\[HAVE_AVX2\]/i rorx=\navx1=\nsse4=' configure.ac \
 && grep -n -B4 -A3 'AM_CONDITIONAL(\[HAVE_AVX2\]' configure.ac

RUN ./autogen.sh \
 && ./configure \
 && make -j"$(nproc)"

FROM debian:trixie-slim@sha256:a99cfc517144bc59b1978475ec53b46ecabec7e43635402ee5b77cc54cd1b20a
ARG APP_VERSION
ARG SOURCE_REVISION
ARG CKPOOL_COMMIT

RUN test -n "$APP_VERSION" && echo "$APP_VERSION" | grep -Eq '^[0-9]+\.[0-9]+\.[0-9]+$' \
 && test -n "$SOURCE_REVISION"

RUN apt-get update \
 && apt-get install --yes --no-install-recommends libzmq5 \
 && rm -rf /var/lib/apt/lists/*

COPY --from=builder /build/src/ckpool /bin/ckpool
COPY --from=builder /build/COPYING /usr/share/licenses/ckpool/COPYING
COPY packaging/ckpool/kraskus-ckpool-supervisor /usr/local/bin/kraskus-ckpool-supervisor
RUN chmod 0755 /usr/local/bin/kraskus-ckpool-supervisor \
 && sh -n /usr/local/bin/kraskus-ckpool-supervisor \
 && if ldd /bin/ckpool | grep -q 'not found'; then ldd /bin/ckpool; exit 1; fi

LABEL org.opencontainers.image.title="CHTA Kraskus CKPool" \
      org.opencontainers.image.description="NMminer fractional-difficulty CKPool with the CHTA developer-fee split and the Kraskus Stratum supervisor" \
      org.opencontainers.image.version="${APP_VERSION}" \
      org.opencontainers.image.revision="${SOURCE_REVISION}" \
      org.opencontainers.image.source="https://github.com/kraskuscrypto/Kraskus-Crypto-Apps" \
      org.opencontainers.image.licenses="GPL-3.0-only" \
      org.opencontainers.image.base.name="docker.io/library/debian:trixie-slim@sha256:a99cfc517144bc59b1978475ec53b46ecabec7e43635402ee5b77cc54cd1b20a" \
      com.kraskus.ckpool.upstream="https://github.com/NMminer1024/btc-ckpool-solo" \
      com.kraskus.ckpool.commit="${CKPOOL_COMMIT}"

EXPOSE 3333
ENTRYPOINT ["/usr/local/bin/kraskus-ckpool-supervisor"]

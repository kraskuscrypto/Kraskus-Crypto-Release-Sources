# Candidate9 CHTA CKPool runtime.
#
# The previously qualified WillItMod image pins upstream ckpool where
# mindiff/startdiff are int64_t. That build cannot represent the sub-1
# share difficulties required by MH/s-class NMMiner devices.
#
# This image builds the NMminer fractional-difficulty CKPool fork from an
# immutable source commit. The fork changes mindiff/startdiff and client diff
# state to floating point and parses those configuration fields as JSON real
# numbers. All source is rebuilt in the builder stage; only the ckpool binary
# and its runtime dependency are carried into the final image.
#
# Candidate9 also carries one narrow accounting correction: the upstream fork
# counts accepted submissions correctly but clamps difficulty-weighted pool
# accounting to at least 1. That inflates aggregate hashrate by ~1/diff for
# sub-1 shares. We preserve accepted/rejected submission counts and only remove
# that clamp from unaccounted_diff_shares.

ARG CKPOOL_COMMIT=49b45c25940f2138955c4503e1da55f19cea8de9

FROM debian:trixie-slim AS builder
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
# address after parse_config(). Make that address configurable while retaining
# the upstream default whenever donaddress is absent.
RUN test "$(grep -F -c 'json_get_double(&ckp->donation, json_conf, "donation");' src/ckpool.c)" = "1" \
 && sed -i '/json_get_double(&ckp->donation, json_conf, "donation");/a\	json_get_string(\&ckp->donaddress, json_conf, "donaddress");' src/ckpool.c \
 && test "$(grep -F -c 'json_get_string(&ckp->donaddress, json_conf, "donaddress");' src/ckpool.c)" = "1" \
 && test "$(grep -F -c 'ckp.donaddress = "bc1q5gq32mvu3cltkcw2sx9nyc5udx3zy0gt82002c";' src/ckpool.c)" = "1" \
 && sed -i 's/ckp\.donaddress = "bc1q5gq32mvu3cltkcw2sx9nyc5udx3zy0gt82002c";/if (!ckp.donaddress)\n\t\tckp.donaddress = "bc1q5gq32mvu3cltkcw2sx9nyc5udx3zy0gt82002c";/' src/ckpool.c \
 && test "$(grep -F -c 'if (!ckp.donaddress)' src/ckpool.c)" = "1"

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

FROM debian:trixie-slim
RUN apt-get update \
 && apt-get install --yes --no-install-recommends libzmq3-dev \
 && rm -rf /var/lib/apt/lists/*

COPY --from=builder /build/src/ckpool /bin/ckpool
COPY --from=builder /build/COPYING /usr/share/licenses/ckpool/COPYING

EXPOSE 3333
ENTRYPOINT ["/bin/ckpool"]

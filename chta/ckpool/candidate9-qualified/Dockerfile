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

# Match the portability choice used by the currently qualified CKPool image:
# disable host-CPU-specific configure optimisations when these probes exist.
RUN sed -i "s/host_cpu = 'x86_64'/host_cpu = 'x86_64-disabled'/" configure.ac \
 && sed -i "s/host_cpu = 'aarch64'/host_cpu = 'aarch64-disabled'/" configure.ac

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

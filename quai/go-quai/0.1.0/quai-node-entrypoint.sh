#!/bin/sh
# Quai Solo by Kraskus: go-quai v0.56.1 launcher and storage guard.
#
# Every listener is set explicitly (never upstream defaults, which differ
# between source and docs):
#   KawPoW 1936, SHA-256 1937, Scrypt 1938  (Stratum v1, published)
#   StratumX API 3336, RPC 9001/9002/9200   (app network only, never published)
#   P2P 4002                                 (published)
# Mainnet, cyprus1 only: --node.slices "[0 0]". No zone selector exists.
#
# The node holds no reward key: StratumX takes the reward address from each
# miner's username (address.worker). The node's own coinbase flags are unused
# by StratumX and stay at upstream defaults.
#
# Storage guard (owner rule: clean shutdown before critical disk exhaustion):
#   * preflight: the node does not start while free space on the data volume
#     is below QUAI_STORAGE_START_FREE_GIB;
#   * runtime: free space is checked every QUAI_STORAGE_CHECK_SECONDS; below
#     QUAI_STORAGE_STOP_FREE_GIB go-quai gets SIGINT (its own clean shutdown,
#     LevelDB flushed) and the guard waits, without restarting the node,
#     until space is back above the start threshold;
#   * state for the adapter: $RUN/storage-guard.json (never a secret).
# Nothing here deletes, truncates or moves chain data.
set -eu

DATA="${QUAI_DATA_DIR:-/data/quai}"
RUN="${QUAI_RUN_DIR:-/data/run}"
START_FREE_GIB="${QUAI_STORAGE_START_FREE_GIB:-25}"
STOP_FREE_GIB="${QUAI_STORAGE_STOP_FREE_GIB:-10}"
CHECK_SECONDS="${QUAI_STORAGE_CHECK_SECONDS:-30}"
GUARD="$RUN/storage-guard.json"
mkdir -p "$DATA" "$RUN"
# go-quai reads VERSION and params/*.json and writes nodelogs/ relative to its working dir.
ln -sfn /opt/go-quai/params "$RUN/params"
ln -sfn /opt/go-quai/VERSION "$RUN/VERSION"
cd "$RUN"

free_gib() {
  # Available GiB on the data volume (integer, rounded down).
  df -Pk "$DATA" | awk 'NR==2 {print int($4 / 1048576)}'
}

guard_state() {
  # state: running | low_space_wait | stopped_low_space
  now=$(date +%s)
  printf '{"state":"%s","free_gib":%s,"start_free_gib":%s,"stop_free_gib":%s,"updated_at":%s}\n' \
    "$1" "$(free_gib)" "$START_FREE_GIB" "$STOP_FREE_GIB" "$now" > "$GUARD.tmp"
  mv "$GUARD.tmp" "$GUARD"
}

NODE_PID=""
on_signal() {
  if [ -n "$NODE_PID" ]; then
    kill -INT "$NODE_PID" 2>/dev/null || true
    wait "$NODE_PID" 2>/dev/null || true
  fi
  exit 0
}
trap on_signal INT TERM

while :; do
  if [ "$(free_gib)" -lt "$START_FREE_GIB" ]; then
    guard_state low_space_wait
    echo "storage guard: $(free_gib) GiB free on the data volume, need $START_FREE_GIB GiB to start the node; waiting" >&2
    sleep "$CHECK_SECONDS" &
    wait $! || true
    continue
  fi

  /opt/go-quai/go-quai start \
    --global.data-dir "$DATA" \
    --global.log-level "${QUAI_LOG_LEVEL:-info}" \
    --global.log-size "${QUAI_LOG_SIZE_MB:-50}" \
    --node.environment colosseum \
    --node.slices "[0 0]" \
    --node.db-engine leveldb \
    --node.port 4002 \
    --node.max-peers "${QUAI_MAX_PEERS:-50}" \
    --rpc.http \
    --rpc.http-addr 0.0.0.0 \
    --rpc.http-vhosts "${QUAI_RPC_VHOSTS:-node,localhost}" \
    --rpc.http-api "quai,net,web3,txpool" \
    --rpc.ws=false \
    --node.stratum-enabled \
    --node.stratum-kawpow-addr 0.0.0.0:1936 \
    --node.stratum-sha-addr 0.0.0.0:1937 \
    --node.stratum-scrypt-addr 0.0.0.0:1938 \
    --node.stratum-api-addr 0.0.0.0:3336 \
    --node.stratum-vardiff \
    --node.stratum-name kraskus-quai-solo \
    "$@" &
  NODE_PID=$!
  guard_state running

  while kill -0 "$NODE_PID" 2>/dev/null; do
    sleep "$CHECK_SECONDS" &
    wait $! || true
    kill -0 "$NODE_PID" 2>/dev/null || break
    if [ "$(free_gib)" -lt "$STOP_FREE_GIB" ]; then
      echo "storage guard: only $(free_gib) GiB free (stop threshold $STOP_FREE_GIB GiB); stopping the node cleanly" >&2
      guard_state stopped_low_space
      kill -INT "$NODE_PID" 2>/dev/null || true
      wait "$NODE_PID" 2>/dev/null || true
      NODE_PID=""
      break
    fi
    guard_state running
  done

  if [ -n "$NODE_PID" ]; then
    # go-quai exited by itself: let the container restart policy decide.
    set +e
    wait "$NODE_PID"
    rc=$?
    set -e
    echo "go-quai exited with status $rc" >&2
    exit "$rc"
  fi
  # Stopped by the storage guard: wait for space before starting again.
  while [ "$(free_gib)" -lt "$START_FREE_GIB" ]; do
    guard_state stopped_low_space
    sleep "$CHECK_SECONDS" &
    wait $! || true
  done
done

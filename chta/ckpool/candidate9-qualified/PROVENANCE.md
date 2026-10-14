# Provenance — `ghcr.io/kraskuscrypto/kraskus-chta-ckpool:candidate9-qualified`

This image has no OCI labels. Its original build directory still exists on the Kraskus build host: a clean git worktree whose ckpool Dockerfile was last written 2026-08-26 12:14:12 UTC, 41 seconds before the image was created (12:14:53 UTC). That file is byte-identical (sha256 96c5dee42c68...) to the recipe published here. The config history matches its final stage. Its configure.ac step (`host_cpu` substitution) matches nothing in upstream configure.ac, so configure.ac is unmodified; the binary accordingly contains the host-native SSE4 SHA-256 assembly. Source-level markers agree: upstream hard-coded donation address only (no `donaddress` key), `accepted_shares` present.

Confidence: high (build directory, timestamps and binary markers agree).

# Notice

This is go-quai, the reference Go implementation of the Quai Network protocol:

- https://github.com/dominant-strategies/go-quai, tag `v0.56.1`, commit `5917bf5e2ced1d3f1cafdde6bc6fa3345fb71c3e`

It is **not modified** by Kraskus Crypto. It is distributed, unmodified, in
`ghcr.io/kraskuscrypto/kraskus-5trat-quai-node:0.1.0` (Quai Solo by Kraskus) under the GNU
General Public License, version 3 (`COPYING`). There is NO WARRANTY, to the extent permitted
by law.

The image also contains a Kraskus launcher script (`/usr/local/bin/quai-node-entrypoint.sh`),
a separate program that starts go-quai with fixed command-line options and stops it cleanly
when the data disk is almost full. It is published here (`quai-node-entrypoint.sh`).

Copyright in go-quai remains with its authors (see the upstream source). The licence texts of
every Go module compiled into the binary are inside the image at
`/usr/share/licenses/go-quai/deps/`, and their sources are in
`go-quai-v0.56.1-5917bf5e-gomodcache.tar.gz`.

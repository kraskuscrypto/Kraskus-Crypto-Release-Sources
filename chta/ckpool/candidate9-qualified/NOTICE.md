# Notice of modification

This is CKPool, a free software Bitcoin mining pool server, from the NMminer
fractional-difficulty fork:

- https://github.com/NMminer1024/btc-ckpool-solo at commit `49b45c25940f2138955c4503e1da55f19cea8de9`

It has been **modified by Kraskus Crypto**. The modified files and the date each
change was first made:

- 2026-08-26 — `src/stratifier.c`: pool accounting: no MAX(1, diff) clamp on difficulty-weighted shares; `unaccounted_shares` snapshot kept as double; `accepted_shares` count added to pool.status

The modified program is distributed in `ghcr.io/kraskuscrypto/kraskus-chta-ckpool:candidate9-qualified` under the GNU General
Public License, version 3 only (`COPYING`). Kraskus modifications are licensed
under the same terms. There is NO WARRANTY, to the extent permitted by law.

Copyright in CKPool remains with its authors (see the upstream source).

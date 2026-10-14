# The Kraskus CKPool supervisor is a separate program

`ghcr.io/kraskuscrypto/kraskus-chta-ckpool` images `0.3.0` and `0.3.1` contain
two programs:

| Program | Path in the image | Licence | Source |
|---|---|---|---|
| CKPool (modified) | `/usr/bin/ckpool` (installed as `/bin/ckpool`) | GPL-3.0-only | Published in full in this folder |
| Kraskus CKPool supervisor | `/usr/local/bin/kraskus-ckpool-supervisor` | Proprietary (Kraskus) | Not published |

The pre-release images `0.2.34-dev15` and `candidate9-qualified` contain only
CKPool; they start it directly (`ENTRYPOINT ["/bin/ckpool"]`).

## Why the supervisor is not part of CKPool

- **Separate executable.** The supervisor is a standalone POSIX shell script.
  It contains no CKPool source code and is not compiled, linked or combined
  with CKPool in any way. CKPool is built entirely from the source published
  here; the build neither reads nor needs the supervisor.
- **Arm's-length communication only.** The supervisor starts the CKPool binary
  as a child process with ordinary command-line arguments (`-c <config>` plus
  optional CKPool flags), stops it with POSIX signals, and otherwise interacts
  only through files: the CKPool configuration file, a readiness file written
  by the Kraskus app, and a status file it writes for the app. It shares no
  address space, data structures or internal interfaces with CKPool.
- **CKPool runs without it.** The binary works on its own, exactly as upstream
  CKPool does: `ckpool -c <config>`. Replacing or removing the supervisor does
  not affect your ability to build, modify, install or run CKPool from the
  published source.

The supervisor therefore plays the role of a service manager. It decides when
the pool should run (for example, only after the node has synchronised and a
payout address is configured) and keeps CKPool's log files bounded. Together the
two programs form an aggregate of separate works on one container image
(GPL-3.0 section 5, final paragraph). The GPL applies to CKPool and to Kraskus's
modifications of CKPool, all of which are published here. It does not extend to
the supervisor.

Nothing about the supervisor restricts your rights under the GPL to the CKPool
program in these images.

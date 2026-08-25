---
title: "GateRelay"
description: "A small TCP relay packaged as a hardened Linux service. The relay was the easy part. The operational envelope was the project."
status: "Experiment, complete"
featured: 2
source: "https://github.com/vetr0s/gaterelay"
---

GateRelay forwards TCP connections from one public port to one backend target.
I built it to practice the parts of running a service that a toy program skips.
Those parts included least privilege, repeatable deployment, useful logs, and a
runbook for failures.

The relay is intentionally narrow. It does not terminate TLS, balance traffic,
or inspect the bytes it carries. Go handles each direction in its own copy loop.
Connection limits, idle deadlines, graceful shutdown, and structured logs make
the behavior explicit at the edges.

This was a completed infrastructure experiment. It is not a service I am
actively developing.

## What I worked on

- Configuration validation that fails before the service starts
- A hard connection cap claimed before work moves to a goroutine
- Activity-based timeouts that move forward on reads and writes
- A dedicated systemd user with capability and syscall restrictions
- Default-deny firewall rules and SSH key-only access
- Deployment, operations, hardening, and threat-model documentation

The main lesson was that the network loop is a small part of a reliable service.
Installation, permissions, observability, recovery, and clear limits take most
of the design work.

- [Source](https://github.com/vetr0s/gaterelay)
- [Architecture and threat model](https://github.com/vetr0s/gaterelay/blob/main/deploy/docs/ARCHITECTURE.md)
- [Operations runbook](https://github.com/vetr0s/gaterelay/blob/main/deploy/docs/OPERATIONS.md)

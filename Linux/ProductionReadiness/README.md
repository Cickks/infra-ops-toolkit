# Production Readiness

Purpose: track Phase 12.0A and 12.0B readiness work before `INFRA01` becomes a serious 24/7
infrastructure host.

## Current Flow

| Step  | Host      | Status      | Purpose                                                                  |
| ----- | --------- | ----------- | ------------------------------------------------------------------------ |
| 12.0A | `LINUX01` | In Progress | Practice risky concepts in a VM before applying them to the Raspberry Pi |
| 12.0B | `INFRA01` | Planned     | Install hardware and configure the Pi as a production-ready foundation   |

## Practice-First Rule

Use `LINUX01` to learn and validate:

- Disk discovery.
- Filesystem and mount concepts.
- UUID-based persistent mounts.
- Static IP planning.
- SSH validation.
- Docker service validation.
- Docker data-root planning.
- Docker Compose and Portainer review.
- Evidence capture and rollback notes.

Then apply the same discipline to `INFRA01` after the hardware is ready.

## INFRA01 Production Target

Before hosting real monitoring, automation, dashboard, Portainer, or AI Steve support services,
`INFRA01` should have:

- NVMe HAT installed.
- 1TB NVMe SSD installed.
- Active cooling installed and validated.
- Raspberry Pi OS updated.
- SSH key authentication validated.
- Static IP or DHCP reservation documented.
- SSD detected, mounted, and persistent across reboot.
- Docker data stored on SSD-backed storage.
- Docker Engine installed.
- Docker Compose plugin installed.
- Portainer deployed with persistent data on SSD.
- Backup and rollback notes written.

## Evidence Standard

For each step, record:

- Date.
- Host.
- Objective.
- Commands run.
- Before state.
- After state.
- Validation result.
- Problems and fixes.
- Rollback plan.
- Interview relevance.

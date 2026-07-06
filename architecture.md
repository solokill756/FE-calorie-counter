# FE Architecture Overview

## Purpose

This document is the FE architecture entry point.
It defines the shared architectural rules for all FE modules and points to the detailed implementation guides.

Use this document to understand global conventions.
Use the module template to create new modules.
Use module-specific architecture docs for feature details.

## Source Of Truth Order

When architecture guidance conflicts, follow this order:

1. This FE overview for global principles.
2. The shared module template for implementation shape.
3. The specific module architecture file for domain behavior.
4. The module code as runtime truth.

## Required Module Shape

All feature modules must follow the same dependency direction:

- presentation -> application -> domain -> data

Rules:

- Presentation owns UI and user interaction.
- Application owns orchestration and state machine.
- Domain owns contracts and business-facing abstractions.
- Data owns repository implementation and API/provider access.
- Cross-cutting concerns are optional and must be justified per module.

## Global Non-Negotiable Rules

- Do not call network providers directly from UI pages.
- Do not place navigation policies inside repository implementations.
- Keep state machines explicit (for example, Freezed state variants).
- Keep repository interfaces in domain and implementations in data.
- Keep constructor injection explicit via `injectable` and `get_it`.
- Regenerate code after model/state changes (Freezed and JSON).
- Do not copy auth-specific persistence or guard behavior into unrelated modules.

## Where To Read Next

- Creating a new module: see [FE/architecture-template.md](architecture-template.md)
- Working on auth module: see [FE/lib/src/modules/auth/architecture.md](lib/src/modules/auth/architecture.md)

## Decision Matrix

Before implementing a module, answer these questions:

1. Does the module require remote API access?
2. Does the module require persisted local state?
3. Does the module require guarded routes?
4. Does the module require third-party providers?
5. Does the module require multi-step workflow?

If the answer is no, do not add that concern.

## Governance

- If global FE architecture decisions change, update this file first.
- If module creation workflow changes, update [FE/architecture-template.md](architecture-template.md).
- If auth-specific behavior changes, update [FE/lib/src/modules/auth/architecture.md](lib/src/modules/auth/architecture.md).
- Keep docs and code updated in the same change whenever behavior changes.

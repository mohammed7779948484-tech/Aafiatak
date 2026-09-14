# Architecture

Aafiatak is a Flutter UI project with mock data. Its structure is deliberately
small so three students can work on separate screen groups.

```text
lib/
├── main.dart
└── src/
    ├── app/                 # app setup, router, patient shell
    ├── design_system/       # theme, foundations, components, patterns
    └── features/            # product screens, local widgets, mock data
```

A feature should add only the folders it uses:

```text
features/booking/
├── screens/
├── widgets/
└── mock_data.dart
```

Do not add repositories, services, use cases, DTO layers, dependency injection,
or app-wide state management for mock UI. Use local Flutter state and pass data
and callbacks explicitly.

Shared visual controls belong in `design_system/components/`. Reusable patient
compositions belong in `design_system/patterns/`. Feature-specific widgets stay
with their feature.

Routing is defined under `lib/src/app/routing/` with `go_router`. Widgets and
domain patterns do not own navigation or data access.

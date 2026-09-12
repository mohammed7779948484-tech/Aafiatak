# `shared/` contract

`shared/` is intentionally small.

Put code here only when it is:

1. approved as application-wide cross-feature infrastructure, or reused by
   **two or more independent product features**;
2. not a Design System primitive;
3. not business/domain logic;
4. not application-shell concerns such as routing;
5. not a data-source/repository that should have an explicit owner.

Current content:

```text
shared/
└── media/
    ├── aafiatak_image.dart
    ├── aafiatak_network_image.dart
    └── media.dart
```

The media helpers are cross-feature infrastructure for rendering local assets,
SVGs, and cached network images while consuming the Aafiatak Design System for
loading/error presentation.

Do **not** use `shared/` for:

- authentication/session state;
- appointment/booking/payment/doctor/queue models or widgets;
- feature-specific mock data;
- global Riverpod providers;
- buttons, cards, fields, banners, sheets, or other Design System primitives;
- generic "helpers" that have only one caller.

The current `media/` module is an intentionally pre-approved infrastructure
exception because raster/SVG loading, caching, semantics, and fallback behavior
need one consistent implementation across the patient application. Other
helpers should start inside their owning feature and move here only after real
cross-feature reuse appears.

Feature-local mock data stays in `features/<feature>/data/mock/` when that
feature is built. Domain-neutral visual primitives stay in
`design_system/`.

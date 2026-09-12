# `shared/` guide — what it is and what it is not

## Purpose

`shared/` exists for **approved cross-feature infrastructure** that does not
belong to the app shell, a single feature, or the Design System.

This rule keeps the folder small enough that its name remains meaningful.

## Current approved content

```text
lib/src/shared/
├── README.md
└── media/
    ├── aafiatak_image.dart
    ├── aafiatak_network_image.dart
    └── media.dart
```

### `AafiatakNetworkImage`

Use it when several features need a cached raster image from HTTP(S). It owns
only cross-feature concerns:

- network image caching;
- skeleton/loading presentation through the Aafiatak Design System;
- consistent error presentation;
- optional semantics label;
- reduced-motion-aware fade-in;
- optional clipping radius.

It does **not** know about doctors, facilities, appointments, or any domain.

### `AafiatakImage`

Use it when a feature needs one small adapter that can render:

- local raster assets;
- local SVG assets;
- HTTP(S) raster images;
- HTTP(S) SVG images.

Domain composition remains in the feature. For example, a future `DoctorAvatar`
or `FacilityGallery` should not be added to `shared/media/` just because it uses
`AafiatakImage` internally.

## Where common-looking code should go instead

| Code | Correct owner |
|---|---|
| Button/input/card/status primitive | `design_system/` |
| Booking card composition | future Domain Pattern or booking feature |
| Doctor card/profile widget | future Domain Pattern or doctor feature |
| Appointment mock data | owning feature `data/mock/` |
| WhatsApp OTP screen/provider | auth feature |
| Session repository | auth/data layer once real contract exists |
| App routes | `app/routing/` |
| Search debouncer used only by search | search feature |
| Generic helper with one caller | keep beside that caller |

## Promotion rule

Do not start by putting a normal helper in `shared/`. Start it in the owning
feature. Promote it only when a second independent feature needs the same
domain-neutral abstraction.

The current `media/` module is the deliberate foundation exception: image
loading/caching/SVG/error/semantics behavior is infrastructure-wide by nature
and was approved up front so features do not invent competing media stacks.

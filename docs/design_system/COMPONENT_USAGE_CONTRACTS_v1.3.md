# Component usage contracts — Aafiatak Flutter v1.3

This catalog satisfies the Component Foundations handoff requirement that reusable Flutter components document purpose, anatomy/variants, states, semantic token mapping, RTL, text scaling, accessibility, demo states, and do/don’t usage. Feature teams should update the relevant entry when a public component contract materially changes.

## `AafiatakButton`

- **Purpose:** Primary/secondary text action.
- **Anatomy / variants:** filled, tonal, outline, text, destructive; optional leading/trailing; expanded width.
- **States:** enabled, disabled, loading.
- **Semantic token mapping:** Material button themes + semantic ColorScheme roles.
- **RTL behavior:** Directional child spacing; no physical left/right assumptions.
- **Text scaling:** Flexible label; caller must provide concise localized copy.
- **Accessibility:** Button semantics, enabled state and loading live-region/value are explicit.
- **Mock / demo states:** Preview enabled/disabled/loading and long Arabic labels.
- **Do:** Use for product actions; use destructive only for destructive intent.
- **Don’t:** Do not style raw Filled/Outlined/Text buttons independently in feature screens.

## `AafiatakIconButton`

- **Purpose:** Icon-only action.
- **Anatomy / variants:** standard, filled, tonal, outlined.
- **States:** enabled/disabled via callback.
- **Semantic token mapping:** Material IconButton theme and ColorScheme.
- **RTL behavior:** Material handles RTL; directional icons must use appropriate/mirroring icon data.
- **Text scaling:** No text layout; tooltip must be localized.
- **Accessibility:** Tooltip is required by API and becomes the accessible name.
- **Mock / demo states:** Preview every variant and disabled state.
- **Do:** Use for compact utility actions with an unambiguous icon.
- **Don’t:** Do not omit tooltip or use icon-only actions for unclear/high-risk choices.

## `AafiatakTextField`

- **Purpose:** General labeled text/form input.
- **Anatomy / variants:** single/multiline, helper, error, prefix/suffix, formatter/autofill options.
- **States:** normal, focused, disabled, read-only, validation error.
- **Semantic token mapping:** InputDecorationTheme + typography + semantic colors.
- **RTL behavior:** Defaults to page direction; caller can isolate LTR tokens when needed.
- **Text scaling:** Persistent label and multi-line helper/error support Arabic expansion.
- **Accessibility:** Native TextFormField semantics/validation are preserved.
- **Mock / demo states:** Preview normal/focus/error/disabled/read-only/long helper.
- **Do:** Use as the base text-entry primitive.
- **Don’t:** Do not combine controller and initialValue or hide critical labels in placeholders.

## `AafiatakPhoneField`

- **Purpose:** Phone-number entry without inventing phone policy.
- **Anatomy / variants:** controller/focus/icons/formatters/helper/error.
- **States:** normal, focus, error, disabled, read-only.
- **Semantic token mapping:** Delegates to AafiatakTextField.
- **RTL behavior:** Entry is LTR inside RTL pages.
- **Text scaling:** Labels/helper/error localize normally.
- **Accessibility:** Telephone keyboard/autofill retained.
- **Mock / demo states:** Preview local/international example values from feature fixtures.
- **Do:** Use for phone entry; let feature/backend define normalization/country policy.
- **Don’t:** Do not hard-code country prefix/length/validation rules in the primitive.

## `AafiatakOtpInput`

- **Purpose:** Accessible OTP entry with configurable length.
- **Anatomy / variants:** caller-supplied length, helper/error, controller/focus.
- **States:** empty, partial, complete, focused, error, disabled.
- **Semantic token mapping:** Input/surface/outline/motion tokens.
- **RTL behavior:** Visual/code entry is LTR; surrounding label follows page RTL.
- **Text scaling:** Cells remain fixed readable tokens; helper/error may expand.
- **Accessibility:** One logical TextField; visual cells excluded from semantics; one-time-code autofill/paste supported.
- **Mock / demo states:** Preview several configured lengths, partial/error/paste/autofill.
- **Do:** Use with feature-owned explicit verify action unless approved otherwise.
- **Don’t:** Do not freeze 4/6 digits or perform component-owned verification/navigation.

## `AafiatakSearchField`

- **Purpose:** Unified search entry.
- **Anatomy / variants:** leading, up to two trailing actions, read-only/enabled, keyboard/action options.
- **States:** idle, focused, disabled/read-only.
- **Semantic token mapping:** Material SearchBar theme + size token.
- **RTL behavior:** Page-direction aware; search text follows locale unless feature isolates tokens.
- **Text scaling:** Hint must tolerate Arabic expansion.
- **Accessibility:** Native SearchBar input semantics preserved.
- **Mock / demo states:** Preview empty/query/focus/trailing actions.
- **Do:** Use for discovery/search input.
- **Don’t:** Do not place more than two trailing actions or embed search-result business logic.

## `AafiatakChip`

- **Purpose:** Compact non-destructive selectable/filter option.
- **Anatomy / variants:** selected/unselected, optional leading.
- **States:** enabled/disabled, selected/unselected.
- **Semantic token mapping:** ChipTheme + semantic selection roles.
- **RTL behavior:** Material/directional layout.
- **Text scaling:** Label can expand but should stay concise.
- **Accessibility:** FilterChip semantics preserved; custom semantic label supported; checkmark gives non-color cue.
- **Mock / demo states:** Preview selected/unselected/disabled and long label.
- **Do:** Use for filters/toggles that fit chip semantics.
- **Don’t:** Do not use color alone or use as a critical destructive/financial action.

## `AafiatakSegmentedControl<T>`

- **Purpose:** Single selection among peer options.
- **Anatomy / variants:** 2–4 typed segments; optional icons.
- **States:** enabled/disabled segment, selected.
- **Semantic token mapping:** SegmentedButtonTheme.
- **RTL behavior:** Material handles RTL ordering from supplied segment order.
- **Text scaling:** Labels should remain concise and tested at larger text scale.
- **Accessibility:** Selected icon provides non-color cue; native button semantics preserved.
- **Mock / demo states:** Preview 2/3/4 segments and disabled segment.
- **Do:** Use for small peer-choice sets.
- **Don’t:** Do not use for long lists or navigation hierarchy.

## `AafiatakCard`

- **Purpose:** Standard neutral content surface.
- **Anatomy / variants:** static or tappable; configurable padding/clip.
- **States:** default/tappable; feature controls inner states.
- **Semantic token mapping:** CardTheme + radius/surface/outline tokens.
- **RTL behavior:** Directional padding.
- **Text scaling:** Child owns text scaling; card must not impose fixed text height.
- **Accessibility:** Container semantics; optional semantic label; InkWell for interaction.
- **Mock / demo states:** Preview static/tappable/long content.
- **Do:** Use as a surface primitive or Pattern building block.
- **Don’t:** Do not encode Doctor/Appointment/Payment semantics inside this primitive.

## `AafiatakDivider`

- **Purpose:** Low-emphasis content separator.
- **Anatomy / variants:** configurable vertical space.
- **States:** single neutral state.
- **Semantic token mapping:** DividerTheme.
- **RTL behavior:** Direction-neutral.
- **Text scaling:** No text.
- **Accessibility:** Decorative Material divider semantics.
- **Mock / demo states:** Preview inside lists/cards.
- **Do:** Use only where grouping needs a visible separator.
- **Don’t:** Do not over-segment every row when spacing alone is sufficient.

## `AafiatakInfoRow`

- **Purpose:** Simple label/value summary row.
- **Anatomy / variants:** optional value/leading/trailing/tap.
- **States:** static/tappable.
- **Semantic token mapping:** TextTheme, onSurfaceVariant, ListTile spacing.
- **RTL behavior:** RTL-safe Material ListTile.
- **Text scaling:** Value/helper-style text can wrap.
- **Accessibility:** Native ListTile semantics retained; optional semantic grouping label.
- **Mock / demo states:** Preview with/without value and long localized value.
- **Do:** Use for generic summary metadata.
- **Don’t:** Do not turn domain-specific queue/appointment rows into InfoRow if a Pattern is warranted.

## `AafiatakListRow`

- **Purpose:** Generic reusable menu/list row.
- **Anatomy / variants:** Widget title/subtitle/leading/trailing, optional tap.
- **States:** enabled/disabled, static/tappable.
- **Semantic token mapping:** ListTile + 48dp minimum target.
- **RTL behavior:** RTL-safe Material ListTile.
- **Text scaling:** Title/subtitle own wrapping; no fixed line count.
- **Accessibility:** Native ListTile interaction semantics plus optional grouping label.
- **Mock / demo states:** Preview one/two-line, icon/trailing, disabled.
- **Do:** Use for domain-neutral repeated/menu rows.
- **Don’t:** Do not use it to avoid creating a real Notification/Doctor/Appointment Pattern.

## `AafiatakPrimaryActionBar`

- **Purpose:** Stable bottom high-priority action region.
- **Anatomy / variants:** primary action, optional secondary/supporting content, optional SafeArea.
- **States:** content/action states are supplied by children.
- **Semantic token mapping:** Surface/outline/spacing tokens.
- **RTL behavior:** Directional padding and full-width composition.
- **Text scaling:** Supporting/action labels must tolerate Arabic text scaling.
- **Accessibility:** Preserves child action semantics; SafeArea keeps controls clear of system UI.
- **Mock / demo states:** Preview keyboard/no-keyboard, one/two actions, supporting copy.
- **Do:** Use in Scaffold.bottomNavigationBar for transactional/form screens.
- **Don’t:** Do not put eligibility/business decisions or API calls in the bar.

## `AafiatakAppBar`

- **Purpose:** Standard screen title/leading/actions shell.
- **Anatomy / variants:** custom leading or BackButton, actions, bottom.
- **States:** root/no-back vs nested/back.
- **Semantic token mapping:** AppBarTheme + sizing tokens.
- **RTL behavior:** BackButton uses platform/RTL behavior.
- **Text scaling:** Title uses theme and must be tested with long Arabic copy.
- **Accessibility:** Native AppBar/action semantics.
- **Mock / demo states:** Preview root/nested/actions/long title.
- **Do:** Use for screen chrome.
- **Don’t:** Do not supply both custom leading and showBackButton or embed routing state logic.

## `AafiatakNavigationBar`

- **Purpose:** Primary phone destination navigation.
- **Anatomy / variants:** 3–5 items, selected/selectedIcon/tooltip/enabled.
- **States:** selected/unselected/disabled destination.
- **Semantic token mapping:** NavigationBarTheme.
- **RTL behavior:** Material handles RTL layout.
- **Text scaling:** Labels always shown and must stay concise at text scale.
- **Accessibility:** Native destination semantics; selected destination must be enabled.
- **Mock / demo states:** Preview 3 destinations and selected states.
- **Do:** Use only for top-level primary destinations.
- **Don’t:** Do not use for stepper/segmented content or exceed 5 items.

## `AafiatakStatusBlock`

- **Purpose:** Persistent domain-neutral status panel.
- **Anatomy / variants:** tone, icon, optional message/action/trailing.
- **States:** neutral/success/warning/error/info/hold; content supplied by caller.
- **Semantic token mapping:** AafiatakFeedbackTone + radius/border/typography tokens.
- **RTL behavior:** Directional row/alignment.
- **Text scaling:** Message/action area grows vertically.
- **Accessibility:** Container semantics; icon/text means status never relies on color alone.
- **Mock / demo states:** Preview all tones, with/without message/action.
- **Do:** Use as foundation for domain status Patterns.
- **Don’t:** Do not derive domain lifecycle state from raw status strings inside it.

## `AafiatakBanner`

- **Purpose:** Page-level persistent feedback.
- **Anatomy / variants:** title optional, tone, icon, action, dismiss.
- **States:** neutral/success/warning/error/info/hold + dismissible/non-dismissible.
- **Semantic token mapping:** Feedback tone + surface spacing.
- **RTL behavior:** Directional row and icon/action placement.
- **Text scaling:** Copy/action can wrap.
- **Accessibility:** Live region; dismiss tooltip localized.
- **Mock / demo states:** Preview long copy/action/dismiss/all tones.
- **Do:** Use for persistent page-level notice.
- **Don’t:** Do not use for silent decoration or replace domain-specific state composition when richer context is needed.

## `AafiatakSnackbar`

- **Purpose:** Central transient feedback presenter.
- **Anatomy / variants:** semantic tone and optional action according to API.
- **States:** transient message states.
- **Semantic token mapping:** SnackBarTheme + feedback tone.
- **RTL behavior:** Material handles RTL.
- **Text scaling:** Localized message should be concise and wrap safely.
- **Accessibility:** Native Snackbar semantics/live announcements.
- **Mock / demo states:** Preview common info/success/error cases.
- **Do:** Use for transient acknowledgement/non-blocking feedback.
- **Don’t:** Do not use for durable financial/appointment truth that must remain visible.

## `AafiatakDialog`

- **Purpose:** Modal confirmation/information surface.
- **Anatomy / variants:** title/content/actions; scrollable content; presenter helper.
- **States:** open/dismiss/action states supplied by caller.
- **Semantic token mapping:** DialogTheme.
- **RTL behavior:** Directional action/content layout via Material.
- **Text scaling:** Scrollable by default for long/localized content.
- **Accessibility:** Native AlertDialog semantics/focus behavior.
- **Mock / demo states:** Preview confirmation, long Arabic copy, destructive action.
- **Do:** Use when a blocking decision/acknowledgement is justified.
- **Don’t:** Do not use as navigation or hide long workflows in a modal.

## `AafiatakBottomSheetBody`

- **Purpose:** Modal sheet content foundation.
- **Anatomy / variants:** body/content/actions according to API; presenter helper.
- **States:** open/keyboard/safe-area variants.
- **Semantic token mapping:** BottomSheetTheme + radius/spacing.
- **RTL behavior:** RTL/directional content is preserved.
- **Text scaling:** Flexible/scrollable caller content; keyboard-safe.
- **Accessibility:** Material modal sheet semantics/focus behavior.
- **Mock / demo states:** Preview keyboard, long content and actions.
- **Do:** Use for contextual secondary tasks.
- **Don’t:** Do not use for a full-screen flow that needs route/back-stack semantics.

## `AafiatakLoading`

- **Purpose:** General indeterminate loading indicator.
- **Anatomy / variants:** compact/non-compact; optional message/semantic label.
- **States:** loading only.
- **Semantic token mapping:** Progress/theme/sizing tokens.
- **RTL behavior:** Direction-neutral.
- **Text scaling:** Optional message wraps.
- **Accessibility:** Live-region localized loading label.
- **Mock / demo states:** Preview compact/full and message/no-message.
- **Do:** Use for blocking/simple indeterminate loading.
- **Don’t:** Do not replace skeleton/preserved-content refresh states when context should remain visible.

## `AafiatakSkeleton`

- **Purpose:** Geometry-preserving loading placeholder wrapper.
- **Anatomy / variants:** enabled/disabled, pointer suppression.
- **States:** loading skeleton vs real child.
- **Semantic token mapping:** SurfaceContainerHigh SolidColorEffect.
- **RTL behavior:** Inherits child RTL geometry.
- **Text scaling:** Matches child geometry; caller must test scaled-text layouts.
- **Accessibility:** Pointers ignored by default; skeleton is visual loading treatment.
- **Mock / demo states:** Preview against actual final child geometry.
- **Do:** Use when content structure is known while loading.
- **Don’t:** Do not create skeleton geometry unrelated to final content.

## `AafiatakProgress`

- **Purpose:** Determinate/indeterminate linear or circular progress.
- **Anatomy / variants:** linear/circular; optional numeric value/semantic value.
- **States:** indeterminate or 0..1 determinate.
- **Semantic token mapping:** ProgressIndicatorTheme.
- **RTL behavior:** Direction handled by Material.
- **Text scaling:** No visible text unless caller composes it.
- **Accessibility:** Localized semantic label + optional semantic value.
- **Mock / demo states:** Preview determinate/indeterminate.
- **Do:** Use for progress measurement.
- **Don’t:** Do not imply precise progress when backend cannot supply it.

## `AafiatakEmptyState`

- **Purpose:** Canonical empty-state presentation.
- **Anatomy / variants:** title/message/icon/action.
- **States:** empty state; action optional.
- **Semantic token mapping:** Typography/color/spacing/icon size tokens.
- **RTL behavior:** RTL-safe centered composition.
- **Text scaling:** Flexible text; constrained reading width.
- **Accessibility:** Semantic container; action semantics preserved.
- **Mock / demo states:** Preview long Arabic copy/action/no-action.
- **Do:** Use for valid no-content states with a helpful next action.
- **Don’t:** Do not use for errors or loading.

## `AafiatakErrorState`

- **Purpose:** Canonical error-state presentation.
- **Anatomy / variants:** title/message/icon/action.
- **States:** error + retry/next action optional.
- **Semantic token mapping:** Error semantic color + typography/spacing.
- **RTL behavior:** RTL-safe centered composition.
- **Text scaling:** Flexible text; constrained reading width.
- **Accessibility:** Live region + semantic container; action remains accessible.
- **Mock / demo states:** Preview retry/no-retry and long copy.
- **Do:** Use for recoverable/non-content error states.
- **Don’t:** Do not conflate business status (payment/appointment) with technical load failure.

## `AafiatakBadge`

- **Purpose:** Compact category/status label.
- **Anatomy / variants:** tone + optional icon.
- **States:** semantic tone variants.
- **Semantic token mapping:** Feedback tone + radius/border tokens.
- **RTL behavior:** Directional icon-label spacing.
- **Text scaling:** Keep label short; do not force fixed width.
- **Accessibility:** Explicit semantic label; visual child excluded to avoid duplicate announcement.
- **Mock / demo states:** Preview all tones and icon/no-icon.
- **Do:** Use for compact supplementary status/category metadata.
- **Don’t:** Do not use badge/color alone for critical financial/visit truth.

## `AafiatakIcon`

- **Purpose:** Standard icon renderer/vocabulary gateway.
- **Anatomy / variants:** Material/Hugeicons; inline/standard/large/hero sizes; color/semantic label.
- **States:** decorative or meaningful.
- **Semantic token mapping:** Icon size tokens + inherited semantic colors.
- **RTL behavior:** Choose direction-aware icon semantics where applicable.
- **Text scaling:** No text scaling; size is tokenized.
- **Accessibility:** Decorative icons are excluded from semantics; meaningful icons require semanticLabel.
- **Mock / demo states:** Preview both icon sources and sizes.
- **Do:** Use to standardize reusable icon rendering.
- **Don’t:** Do not expose raw Hugeicons directly across features for shared vocabulary.

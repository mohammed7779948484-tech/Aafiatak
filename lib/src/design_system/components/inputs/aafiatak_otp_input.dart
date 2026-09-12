import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../foundations/foundations.dart';

/// Accessible, configuration-driven one-time-code input.
///
/// The visual cells are presentation only. A single logical [TextField]
/// receives input, paste, keyboard and one-time-code autofill so assistive
/// technologies encounter one coherent input. Reaching [length] only notifies
/// [onCompleted]; product code should keep verification as an explicit action
/// unless an approved flow says otherwise.
class AafiatakOtpInput extends StatefulWidget {
  const AafiatakOtpInput({
    super.key,
    required this.label,
    required this.length,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onCompleted,
    this.helperText,
    this.errorText,
    this.enabled = true,
    this.autofocus = true,
    this.semanticLabel,
  }) : assert(length > 0);

  final String label;
  final int length;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final String? helperText;
  final String? errorText;
  final bool enabled;
  final bool autofocus;
  final String? semanticLabel;

  @override
  State<AafiatakOtpInput> createState() => _AafiatakOtpInputState();
}

class _AafiatakOtpInputState extends State<AafiatakOtpInput> {
  TextEditingController? _internalController;
  FocusNode? _internalFocusNode;

  TextEditingController get _controller =>
      widget.controller ?? (_internalController ??= TextEditingController());

  FocusNode get _focusNode =>
      widget.focusNode ?? (_internalFocusNode ??= FocusNode());

  @override
  void dispose() {
    _internalController?.dispose();
    _internalFocusNode?.dispose();
    super.dispose();
  }

  void _handleChanged(String value) {
    widget.onChanged?.call(value);
    if (value.length == widget.length) {
      widget.onCompleted?.call(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final hasError = widget.errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(widget.label, style: theme.textTheme.labelLarge),
        const SizedBox(height: AafiatakSpacing.xs),
        Directionality(
          textDirection: TextDirection.ltr,
          child: AnimatedBuilder(
            animation: _focusNode,
            builder: (context, _) {
              return Stack(
                children: <Widget>[
                  ExcludeSemantics(
                    child: ValueListenableBuilder<TextEditingValue>(
                      valueListenable: _controller,
                      builder: (context, value, _) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List<Widget>.generate(widget.length, (
                              index,
                            ) {
                              final character = index < value.text.length
                                  ? value.text[index]
                                  : '';
                              final activeIndex =
                                  value.text.length >= widget.length
                                  ? widget.length - 1
                                  : value.text.length;
                              final isActive =
                                  widget.enabled &&
                                  _focusNode.hasFocus &&
                                  index == activeIndex;

                              return Padding(
                                padding: EdgeInsetsDirectional.only(
                                  end: index == widget.length - 1
                                      ? AafiatakSpacing.none
                                      : AafiatakSpacing.xs,
                                ),
                                child: AnimatedContainer(
                                  duration:
                                      MediaQuery.disableAnimationsOf(context)
                                      ? Duration.zero
                                      : AafiatakMotion.fast,
                                  width: AafiatakSizes.minimumTouchTarget,
                                  height: AafiatakSizes.inputMinHeight,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: scheme.surface,
                                    borderRadius: AafiatakRadii.input,
                                    border: Border.all(
                                      color: hasError
                                          ? scheme.error
                                          : isActive
                                          ? scheme.primary
                                          : scheme.outline,
                                      width: isActive
                                          ? AafiatakBorders.focus
                                          : AafiatakBorders.subtle,
                                    ),
                                  ),
                                  child: Text(
                                    character,
                                    style: theme.textTheme.titleLarge,
                                  ),
                                ),
                              );
                            }),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned.fill(
                    child: Semantics(
                      textField: true,
                      label: widget.semanticLabel ?? widget.label,
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        enabled: widget.enabled,
                        autofocus: widget.autofocus,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        autofillHints: const <String>[
                          AutofillHints.oneTimeCode,
                        ],
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(widget.length),
                        ],
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.center,
                        showCursor: false,
                        style: const TextStyle(
                          color: Colors.transparent,
                          fontSize: 1,
                          height: 1,
                        ),
                        decoration: const InputDecoration(
                          filled: false,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        onChanged: _handleChanged,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        if (widget.errorText != null) ...<Widget>[
          const SizedBox(height: AafiatakSpacing.xxs),
          Text(
            widget.errorText!,
            style: theme.textTheme.bodySmall?.copyWith(color: scheme.error),
          ),
        ] else if (widget.helperText != null) ...<Widget>[
          const SizedBox(height: AafiatakSpacing.xxs),
          Text(
            widget.helperText!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}

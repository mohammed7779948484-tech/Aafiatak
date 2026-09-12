import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';

/// Aafiatak search input built on Material 3 [SearchBar].
class AafiatakSearchField extends StatelessWidget {
  const AafiatakSearchField({
    super.key,
    required this.hintText,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.onTapOutside,
    this.leading,
    this.trailing = const <Widget>[],
    this.autoFocus = false,
    this.enabled = true,
    this.readOnly = false,
    this.textInputAction = TextInputAction.search,
    this.keyboardType = TextInputType.text,
  }) : assert(
         trailing.length <= 2,
         'Material SearchBar should not expose more than two trailing actions.',
       );

  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final GestureTapCallback? onTap;
  final TapRegionCallback? onTapOutside;
  final Widget? leading;
  final List<Widget> trailing;
  final bool autoFocus;
  final bool enabled;
  final bool readOnly;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: controller,
      focusNode: focusNode,
      hintText: hintText,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onTap: onTap,
      onTapOutside: onTapOutside,
      autoFocus: autoFocus,
      enabled: enabled,
      readOnly: readOnly,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      leading: leading ?? const Icon(Icons.search_rounded),
      trailing: trailing,
      constraints: const BoxConstraints(
        minHeight: AafiatakSizes.inputMinHeight,
      ),
    );
  }
}

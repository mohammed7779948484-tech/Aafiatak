import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:aafiatak/src/design_system/design_system.dart';

class OtpInput extends StatefulWidget {
  const OtpInput({
    super.key,
    required this.length,
    required this.onChanged,
    this.initialValue = '',
  });

  final int length;
  final String initialValue;
  final ValueChanged<String> onChanged;

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();

    _controllers = List<TextEditingController>.generate(widget.length, (
      int index,
    ) {
      final String initialCharacter = index < widget.initialValue.length
          ? widget.initialValue[index]
          : '';

      return TextEditingController(text: initialCharacter);
    });

    _focusNodes = List<FocusNode>.generate(widget.length, (_) => FocusNode());
  }

  String get _currentCode {
    return _controllers
        .map((TextEditingController controller) => controller.text)
        .join();
  }

  void _handleChanged(int index, String value) {
    if (value.isNotEmpty) {
      if (index < widget.length - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    } else if (index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    widget.onChanged(_currentCode);
  }

  @override
  void dispose() {
    for (final TextEditingController controller in _controllers) {
      controller.dispose();
    }

    for (final FocusNode focusNode in _focusNodes) {
      focusNode.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        children: <Widget>[
          for (int index = 0; index < widget.length; index++) ...<Widget>[
            Expanded(
              child: Semantics(
                label: 'الخانة ${index + 1} من رمز التحقق',
                textField: true,
                child: TextField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  keyboardType: TextInputType.number,
                  textInputAction: index == widget.length - 1
                      ? TextInputAction.done
                      : TextInputAction.next,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                  maxLength: 1,
                  obscureText: true,
                  obscuringCharacter: '•',
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(1),
                  ],
                  style: AafiatakTypography.h3,
                  decoration: const InputDecoration(counterText: ''),
                  onChanged: (String value) {
                    _handleChanged(index, value);
                  },
                ),
              ),
            ),
            if (index < widget.length - 1)
              const SizedBox(width: AafiatakSpacing.space8),
          ],
        ],
      ),
    );
  }
}

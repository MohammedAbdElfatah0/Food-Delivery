import 'package:flutter/material.dart';

class OtpDigitField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isError;
  final bool isCorrect;
  final bool isExpired;
  final ValueChanged<String> onChanged;
  final double width;
  final Animation<double>? scaleAnimation;

  const OtpDigitField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.isError,
    required this.isCorrect,
    required this.isExpired,
    required this.onChanged,
    required this.width,
    this.scaleAnimation,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor;

    if (isExpired) {
      borderColor = Colors.orange;
    } else if (isError) {
      borderColor = Colors.red;
    } else if (isCorrect) {
      borderColor = Colors.green;
    } else {
      borderColor = Colors.grey;
    }

    return ScaleTransition(
      scale: scaleAnimation ?? const AlwaysStoppedAnimation(0.9),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: SizedBox(
          width: width,
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            decoration: const InputDecoration(
              counterText: '',
              border: InputBorder.none,
            ),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}

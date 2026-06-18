import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.send_outlined, size: 18),
      label: const Text(AppTextConstants.requestMeeting),
      onPressed: onPressed,
      iconAlignment: IconAlignment.end,
    );
  }
}

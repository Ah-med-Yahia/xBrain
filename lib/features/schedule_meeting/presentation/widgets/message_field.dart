import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MessageField extends StatefulWidget {
  const MessageField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<MessageField> createState() => MessageFieldState();
}

class MessageFieldState extends State<MessageField> {
  int _chars = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(
      () => setState(() => _chars = widget.controller.text.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextFormField(
          controller: widget.controller,
          maxLength: 1000,
          maxLines: 4,
          buildCounter:
              (_, {required currentLength, required isFocused, maxLength}) =>
                  null,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Would love a quick walkthrough of your answer.',
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.outline,
              fontSize: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outlineVariant,
                width: 0.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.2,
              ),
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$_chars / 1000',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ],
    );
  }
}

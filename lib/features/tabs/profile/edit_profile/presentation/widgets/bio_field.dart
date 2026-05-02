import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BioField extends StatefulWidget {
  final TextEditingController controller;
  final int maxLength;

  const BioField({
    super.key,
    required this.controller,
    required this.maxLength,
  });

  @override
  State<BioField> createState() => _BioFieldState();
}

class _BioFieldState extends State<BioField> {
  late int _charCount;
  late TextTheme textTheme;

  @override
  void initState() {
    super.initState();
    _charCount = widget.controller.text.length;
    widget.controller.addListener(_onChanged);
  }

  void _onChanged() {
    setState(() => _charCount = widget.controller.text.length);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onChanged);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    textTheme = Theme.of(context).textTheme;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppTextConstants.bio,
              style: textTheme.titleMedium?.copyWith(color: AppColors.primary),
            ),
            Text(
              '$_charCount/${widget.maxLength}',
              style: textTheme.labelMedium?.copyWith(color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: widget.controller,
          maxLines: 3,
          maxLength: widget.maxLength,
          textCapitalization: TextCapitalization.sentences,
          style: const TextStyle(fontSize: 17, color: Colors.black),
          decoration: const InputDecoration(
            isDense: true,
            filled: true,
            fillColor: Colors.transparent,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            counterText: '',
          ),
        ),
      ],
    );
  }
}

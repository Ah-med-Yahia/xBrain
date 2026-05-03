import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/core/validators/app_validators.dart';
import 'package:flutter/material.dart';

class NameTextFormField extends StatelessWidget {
  const NameTextFormField({
    super.key,
    required this.labelText,
    required this.nameController,
    required this.formKey,
    required this.onChanged,
  });

  final TextEditingController nameController;
  final String labelText;
  final GlobalKey<FormState> formKey;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      decoration: InputDecoration(labelText: labelText),
      keyboardType: TextInputType.name,
      cursorColor: AppColors.primary,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.name],
      validator: (value) => AppValidators.validateRequired(value),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      onChanged: onChanged,
    );
  }
}

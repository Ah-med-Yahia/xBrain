import 'package:explaino/core/validators/app_validators.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NameTextFormField extends StatelessWidget {
  const NameTextFormField({
    super.key,
    required this.labelText,
    required this.nameController,
    required this.formKey,
  });

  final TextEditingController nameController;
  final String labelText;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      decoration: InputDecoration(labelText: labelText),
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.name],
      validator: (value) => AppValidators.validateRequired(value),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      onChanged: (value) {
        context.read<RegisterCubit>().doIntent(
          ValidateCreateAccountButtonIntent(
            enabled: formKey.currentState!.validate(),
          ),
        );
      },
    );
  }
}

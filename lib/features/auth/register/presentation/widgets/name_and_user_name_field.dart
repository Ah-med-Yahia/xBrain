import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/validators/app_validators.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_intents.dart';
import 'package:explaino/features/auth/register/presentation/widgets/name_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NameAndUserNameField extends StatelessWidget {
  const NameAndUserNameField({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.usernameController,
    required this.formKey,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController usernameController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: NameTextFormField(
                labelText: AppTextConstants.firstName,
                nameController: firstNameController,
                formKey: formKey,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: NameTextFormField(
                labelText: AppTextConstants.lastName,
                nameController: lastNameController,
                formKey: formKey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: usernameController,
          decoration: const InputDecoration(
            labelText: AppTextConstants.username,
            prefixIcon: Icon(Icons.person),
          ),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.username],
          validator: (value) => AppValidators.validateUserName(value),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          onChanged: (value) {
            context.read<RegisterCubit>().doIntent(
              ValidateCreateAccountButtonIntent(
                enabled: formKey.currentState!.validate(),
              ),
            );
          },
        ),
      ],
    );
  }
}

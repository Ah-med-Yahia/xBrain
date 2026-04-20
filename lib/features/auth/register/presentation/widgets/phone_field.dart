import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/core/validators/app_validators.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneField extends StatelessWidget {
  const PhoneField({
    super.key,
    required this.phoneController,
    required this.formKey,
  });
  final TextEditingController phoneController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: phoneController,
      cursorColor: AppColors.primary,
      decoration: const InputDecoration(
        labelText: AppTextConstants.phoneNumber,
        prefixIcon: Icon(Icons.phone_android),
      ),
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.telephoneNumber],
      validator: (value) => AppValidators.validatePhoneNumber(value),
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

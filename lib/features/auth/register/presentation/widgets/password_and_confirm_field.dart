import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/core/validators/app_validators.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_intents.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordAndConfirmField extends StatelessWidget {
  const PasswordAndConfirmField({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
    required this.onSubmit,
  });
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<RegisterCubit, RegisterState>(
          buildWhen: (previous, current) =>
              current.obscurePassword != previous.obscurePassword,
          builder: (context, state) {
            return TextFormField(
              controller: passwordController,
              obscureText: state.obscurePassword,
              obscuringCharacter: String.fromCharCode(0x2726),
              cursorColor: AppColors.primary,
              decoration: InputDecoration(
                labelText: AppTextConstants.password,
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: () {
                    context.read<RegisterCubit>().doIntent(
                      TogglePasswordVisibilityIntent(),
                    );
                  },
                  icon: Icon(
                    state.obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
              ),
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.password],
              validator: (value) => AppValidators.validatePassword(value),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onTapOutside: (_) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              onChanged: (value) {
                context.read<RegisterCubit>().doIntent(
                  ValidateCreateAccountButtonIntent(
                    enabled: formKey.currentState!.validate(),
                  ),
                );
              },
            );
          },
        ),
        const SizedBox(height: 20),
        BlocBuilder<RegisterCubit, RegisterState>(
          buildWhen: (previous, current) =>
              current.obscureConfirmPassword != previous.obscureConfirmPassword,
          builder: (context, state) {
            return TextFormField(
              controller: confirmPasswordController,
              obscureText: state.obscureConfirmPassword,
              obscuringCharacter: String.fromCharCode(0x2726),
              cursorColor: AppColors.primary,
              decoration: InputDecoration(
                labelText: AppTextConstants.confirmPassword,
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: () {
                    context.read<RegisterCubit>().doIntent(
                      ToggleConfirmPasswordVisibilityIntent(),
                    );
                  },
                  icon: Icon(
                    state.obscureConfirmPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
              ),
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.newPassword],
              validator: (value) => AppValidators.validateConfirmPassword(
                value,
                passwordController.text,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onTapOutside: (_) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              onChanged: (value) {
                context.read<RegisterCubit>().doIntent(
                  ValidateCreateAccountButtonIntent(
                    enabled: formKey.currentState!.validate(),
                  ),
                );
              },
              onFieldSubmitted: (value) {
                if (formKey.currentState!.validate()) {
                  onSubmit();
                }
              },
            );
          },
        ),
      ],
    );
  }
}

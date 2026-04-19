import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/core/validators/app_validators.dart';
import 'package:explaino/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:explaino/features/auth/login/presentation/cubit/login_intents.dart';
import 'package:explaino/features/auth/login/presentation/cubit/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailAndPasswordTextField extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  const EmailAndPasswordTextField({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  });

  @override
  State<EmailAndPasswordTextField> createState() =>
      _EmailAndPasswordTextFieldState();
}

class _EmailAndPasswordTextFieldState extends State<EmailAndPasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Column(
        children: [
          TextFormField(
            controller: widget.emailController,
            cursorColor: AppColors.primary,
            decoration: const InputDecoration(
              labelText: AppTextConstants.email,
              prefixIcon: Icon(Icons.email_outlined),
            ),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.email],
            validator: AppValidators.validateEmail,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            onChanged: (value) {
              context.read<LoginCubit>().doIntent(
                ValidateFieldsIntent(
                  formsValid: widget.formKey.currentState!.validate(),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          BlocBuilder<LoginCubit, LoginState>(
            buildWhen: (previous, current) =>
                previous.obscurePassword != current.obscurePassword,
            builder: (context, state) {
              return TextFormField(
                controller: widget.passwordController,
                cursorColor: AppColors.primary,
                decoration: InputDecoration(
                  labelText: AppTextConstants.password,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: AppColors.black,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      state.obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.black,
                    ),
                    onPressed: () {
                      context.read<LoginCubit>().doIntent(
                        TogglePasswordVisibilityIntent(),
                      );
                    },
                  ),
                ),
                onTapOutside: (_) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: state.obscurePassword,
                obscuringCharacter: String.fromCharCode(0x2726),
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.password],
                validator: AppValidators.validateLoginPassword,
                onChanged: (value) {
                  context.read<LoginCubit>().doIntent(
                    ValidateFieldsIntent(
                      formsValid: widget.formKey.currentState!.validate(),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

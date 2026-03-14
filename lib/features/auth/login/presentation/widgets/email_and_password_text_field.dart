import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/core/validators/app_validators.dart';
import 'package:flutter/material.dart';

class EmailAndPasswordTextField extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const EmailAndPasswordTextField({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<EmailAndPasswordTextField> createState() =>
      _EmailAndPasswordTextFieldState();
}

class _EmailAndPasswordTextFieldState extends State<EmailAndPasswordTextField> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Column(
        children: [
          TextFormField(
            controller: widget.emailController,
            decoration: const InputDecoration(
              labelText: AppTextConstants.email,
              prefixIcon: Icon(Icons.email_outlined, color: AppColors.black),
            ),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.email],
            validator: AppValidators.validateEmail,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: widget.passwordController,
            decoration: InputDecoration(
              labelText: AppTextConstants.password,
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: AppColors.black,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.black,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.password],
            validator: AppValidators.validateLoginPassword,
          ),
        ],
      ),
    );
  }
}

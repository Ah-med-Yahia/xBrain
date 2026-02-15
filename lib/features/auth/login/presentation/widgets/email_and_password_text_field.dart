import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class EmailAndPasswordTextField extends StatefulWidget {
  const EmailAndPasswordTextField({super.key});

  @override
  State<EmailAndPasswordTextField> createState() =>
      _EmailAndPasswordTextFieldState();
}

class _EmailAndPasswordTextFieldState extends State<EmailAndPasswordTextField> {
  bool _obscurePassword = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Form(
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: AppTextConstants.email,
              prefixIcon: Icon(Icons.email_outlined, color: AppColors.black),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: size.height * 0.02),
          TextFormField(
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
          ),
        ],
      ),
    );
  }
}

import 'package:explaino/core/constants/app_routes_constant.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/auth/login/presentation/widgets/auth_link_row.dart';
import 'package:explaino/features/auth/login/presentation/widgets/forget_password_avatar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.lightScaffoldGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
              vertical: size.height * 0.01,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.05),
                const ForgetPasswordAvatar(),
                SizedBox(height: size.height * 0.03),
                Text(
                  AppTextConstants.forgotPassword,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: size.height * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Text(
                    AppTextConstants.forgotPasswordInstructions,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text(AppTextConstants.email),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: AppColors.black,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: size.height * 0.25),
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.06,
                  child: ElevatedButton(
                    onPressed: () {
                      GoRouter.of(context).go(AppRoutesConstants.resetPassword);
                    },
                    child: Text(
                      AppTextConstants.sendResetLink,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                AuthLinkRow(
                  promptText: AppTextConstants.rememberPassword,
                  linkText: AppTextConstants.logIn,
                  onLinkTap: () {
                    GoRouter.of(context).go(AppRoutesConstants.login);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/auth/login/presentation/widgets/auth_link_row.dart';
import 'package:explaino/features/auth/login/presentation/widgets/email_and_password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_routes_constant.dart';
import '../../../../../core/constants/app_text_constants.dart';
import '../../../../../core/gen/assets.gen.dart';
import '../widgets/social_icon_row.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.lightScaffoldGradient),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.04,
              vertical: height * 0.01,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width * 0.2,
                  height: width * 0.2,
                  decoration: BoxDecoration(
                    gradient: AppColors.loginContainerGradient,
                    boxShadow: AppColors.loginContainerShadow,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Assets.loginLogo.svg(
                      width: width * 0.065,
                      height: width * 0.0825,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.03),
                Text(
                  AppTextConstants.welcomeBack,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: height * 0.01),
                Text(
                  AppTextConstants.signInToAccount,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: height * 0.04),
                EmailAndPasswordTextField(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.02),
                      child: InkWell(
                        onTap: () {
                          context.go(AppRoutesConstants.forgetPassword);
                        },
                        child: Text(
                          AppTextConstants.forgotPassword,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppColors.primary),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 56,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Log In',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(child: Divider(color: AppColors.divider)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                      child: Text(
                        AppTextConstants.orContinueWith,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const Expanded(child: Divider(color: AppColors.divider)),
                  ],
                ),
                SizedBox(height: height * 0.03),
                SocialIconRow(),
                SizedBox(height: height * 0.03),
                AuthLinkRow(
                  promptText: AppTextConstants.dontHaveAccount,
                  linkText: AppTextConstants.signUp,
                  onLinkTap: () {
                    GoRouter.of(context).go(AppRoutesConstants.forgetPassword);
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

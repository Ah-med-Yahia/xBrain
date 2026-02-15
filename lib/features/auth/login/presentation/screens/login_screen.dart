import 'package:explaino/core/constants/app_routes_constant.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/gen/assets.gen.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/auth/login/presentation/widgets/auth_link_row.dart';
import 'package:explaino/features/auth/login/presentation/widgets/email_and_password_text_field.dart';
import 'package:explaino/features/auth/login/presentation/widgets/social_icon_row.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.lightScaffoldGradient),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
              vertical: size.height * 0.01,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size.width * 0.2,
                  height: size.width * 0.2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.primary, AppColors.darkBlue],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.brightSkyBlue,
                        offset: Offset(0, 4),
                        blurRadius: 6,
                        spreadRadius: -4,
                      ),
                      BoxShadow(
                        color: AppColors.brightSkyBlue,
                        offset: Offset(0, 10),
                        blurRadius: 15,
                        spreadRadius: -3,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Assets.loginLogo.svg(
                      width: size.width * 0.06,
                      height: size.height * 0.05,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Text(
                  AppTextConstants.welcomeBack,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: size.height * 0.01),
                Text(
                  AppTextConstants.signInToAccount,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: size.height * 0.04),
                EmailAndPasswordTextField(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.02,
                      ),
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
                  height: size.height * 0.06,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      AppTextConstants.logIn,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(child: Divider(color: AppColors.divider)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.04,
                      ),
                      child: Text(
                        AppTextConstants.orContinueWith,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const Expanded(child: Divider(color: AppColors.divider)),
                  ],
                ),
                SizedBox(height: size.height * 0.03),
                SocialIconRow(),
                SizedBox(height: size.height * 0.03),
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

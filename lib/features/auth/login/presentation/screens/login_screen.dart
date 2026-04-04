import 'dart:async';
import 'package:explaino/config/di/di.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/routing/app_routes_constant.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/core/utils/ui_utils.dart';
import 'package:explaino/features/auth/login/data/models/login_request_model.dart';
import 'package:explaino/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:explaino/features/auth/login/presentation/cubit/login_intents.dart';
import 'package:explaino/features/auth/login/presentation/cubit/login_side_effects.dart';
import 'package:explaino/features/auth/login/presentation/widgets/auth_link_row.dart';
import 'package:explaino/features/auth/login/presentation/widgets/continue_divider.dart';
import 'package:explaino/features/auth/login/presentation/widgets/email_and_password_text_field.dart';
import 'package:explaino/features/auth/login/presentation/widgets/forget_password_row.dart';
import 'package:explaino/features/auth/login/presentation/widgets/login_logo_container.dart';
import 'package:explaino/features/auth/login/presentation/widgets/social_icon_row.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginCubit loginCubit;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    loginCubit = getIt<LoginCubit>();
    _subscription = loginCubit.sideEffects.listen((effect) {
      if (!mounted) return;
      switch (effect) {
        case ShowError():
          _handelError(effect.message);
        case NavigateToMainScreen():
          _handelNavigateToMainScreen();
        case ShowLoading():
          _handelLoading();
      }
    });
  }

  void _handelLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      UIUtils.showEasyLoading();
    });
  }

  void _handelError(String message) {
    UIUtils.hideEasyLoading();
    UIUtils.showMessage(
      message,
      backGroundColor: AppColors.error,
      textColor: AppColors.white,
    );
  }

  void _handelNavigateToMainScreen() {
    UIUtils.hideEasyLoading();
    GoRouter.of(context).go(AppRoutesConstants.forgotPasswordRoute);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    loginCubit.close();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.lightScaffoldGradient,
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
              vertical: size.height * 0.01,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LoginLogoContainer(),
                  SizedBox(height: size.height * 0.04),
                  EmailAndPasswordTextField(
                    emailController: _emailController,
                    passwordController: _passwordController,
                  ),
                  const ForgetPasswordRow(),
                  SizedBox(
                    height: size.height * 0.06,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState!.validate()) {
                          loginCubit.doIntent(
                            LoginSubmitIntent(
                              loginRequestModel: LoginRequestModel(
                                identifier: _emailController.text,
                                password: _passwordController.text,
                              ),
                            ),
                          );
                        }
                      },
                      child: Text(
                        AppTextConstants.logIn,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge!.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  const ContinueDivider(),
                  SizedBox(height: size.height * 0.03),
                  const SocialIconRow(),
                  SizedBox(height: size.height * 0.03),
                  AuthLinkRow(
                    promptText: AppTextConstants.dontHaveAccount,
                    linkText: AppTextConstants.signUp,
                    onLinkTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

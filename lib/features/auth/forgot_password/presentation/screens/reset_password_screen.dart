import 'dart:async';

import 'package:explaino/config/di/di.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/routing/app_routes_constant.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/core/utils/ui_utils.dart';
import 'package:explaino/core/validators/app_validators.dart';
import 'package:explaino/features/auth/forgot_password/data/models/reset_password_request_model.dart';
import 'package:explaino/features/auth/forgot_password/presentation/cubit/forgot_password_cubit.dart';
import 'package:explaino/features/auth/forgot_password/presentation/cubit/forgot_password_intents.dart';
import 'package:explaino/features/auth/forgot_password/presentation/cubit/forgot_password_side_effects.dart';
import 'package:explaino/features/auth/forgot_password/presentation/widgets/forgot_password_avatar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String resetToken;
  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.resetToken,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  late final ForgotPasswordCubit forgotPasswordCubit;
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  StreamSubscription? _subscription;
  @override
  void initState() {
    forgotPasswordCubit = getIt<ForgotPasswordCubit>();
    _subscription = forgotPasswordCubit.sideEffects.listen((effect) {
      if (!mounted) return;
      switch (effect) {
        case ShowError():
          _handelError(effect.message);
          break;
        case NavigateToLoginScreen():
          _handelNavigateToLoginScreen();
          break;
        case ShowLoading():
          _handelLoading();
          break;
        default:
      }
    });
    super.initState();
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

  void _handelNavigateToLoginScreen() {
    UIUtils.hideEasyLoading();
    GoRouter.of(context).go(AppRoutesConstants.loginRoute, extra: widget.email);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    forgotPasswordCubit.close();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

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
                const ForgotPasswordAvatar(isForgotPassword: false),
                SizedBox(height: size.height * 0.04),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: AppTextConstants.enterNewPassword,
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
                        keyboardType: TextInputType.visiblePassword,
                        validator: AppValidators.validatePassword,
                        obscureText: _obscurePassword,
                      ),
                      SizedBox(height: size.height * 0.02),
                      TextFormField(
                        controller: confirmPasswordController,
                        decoration: InputDecoration(
                          hintText: AppTextConstants.confirmNewPassword,
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: AppColors.black,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: AppColors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
                              });
                            },
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        validator: AppValidators.validatePassword,
                        obscureText: _obscureConfirmPassword,
                      ),
                      SizedBox(height: size.height * 0.25),
                      SizedBox(
                        width: double.infinity,
                        height: size.height * 0.06,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              forgotPasswordCubit.doIntent(
                                ResetPasswordIntent(
                                  resetPasswordRequestModel:
                                      ResetPasswordRequestModel(
                                        email: widget.email,
                                        token: widget.resetToken,
                                        newPassword: passwordController.text
                                            .trim(),
                                      ),
                                ),
                              );
                            }
                          },
                          child: Text(
                            AppTextConstants.resetPassword,
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

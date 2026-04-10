import 'package:explaino/config/di/di.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/routing/app_routes_constant.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/core/utils/ui_utils.dart';
import 'package:explaino/core/validators/app_validators.dart';
import 'package:explaino/features/auth/forgot_password/data/models/send_otp_code_models/forgot_password_request_model.dart';
import 'package:explaino/features/auth/forgot_password/presentation/cubit/forgot_password_cubit.dart';
import 'package:explaino/features/auth/forgot_password/presentation/cubit/forgot_password_intents.dart';
import 'package:explaino/features/auth/forgot_password/presentation/cubit/forgot_password_side_effects.dart';
import 'package:explaino/features/auth/forgot_password/presentation/widgets/forgot_password_avatar.dart';
import 'package:explaino/features/auth/login/presentation/widgets/auth_link_row.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late final ForgotPasswordCubit forgotPasswordCubit;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  

  @override
  void initState() {
    super.initState();
    forgotPasswordCubit = getIt<ForgotPasswordCubit>();
    forgotPasswordCubit.sideEffects.listen((effect) {
      if (!mounted) return;
      switch (effect) {
        case ShowError():
          _handelError(effect.message);
        case NavigateToOtpVerificationScreen(email: final email):
          _handelNavigateToOtpVerificationScreen(email);
        case ShowLoading():
          _handelLoading();
        default:
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

  void _handelNavigateToOtpVerificationScreen(String email) {
    UIUtils.hideEasyLoading();
    GoRouter.of(
      context,
    ).go(AppRoutesConstants.otpVerificationRoute, extra: email);
  }

  @override
  void dispose() {
    forgotPasswordCubit.close();
    emailController.dispose();
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
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.05),
                      const ForgotPasswordAvatar(isForgotPassword: true),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.05,
                        ),
                        child: Text(
                          AppTextConstants.forgotPasswordInstructions,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: size.height * 0.04),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          label: Text(AppTextConstants.email),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: AppColors.black,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: AppValidators.validateEmail,
                      ),
                      SizedBox(height: size.height * 0.25),
                      SizedBox(
                        width: double.infinity,
                        height: size.height * 0.06,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              forgotPasswordCubit.doIntent(
                                SendResetCodeIntent(
                                  forgotPasswordRequestModel:
                                      ForgotPasswordRequestModel(
                                        email: emailController.text.trim(),
                                      ),
                                ),
                              );
                            }
                          },
                          child: Text(
                            AppTextConstants.sendResetLink,
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                AuthLinkRow(
                  promptText: AppTextConstants.rememberPassword,
                  linkText: AppTextConstants.logIn,
                  onLinkTap: () {
                    GoRouter.of(context).go(AppRoutesConstants.loginRoute);
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

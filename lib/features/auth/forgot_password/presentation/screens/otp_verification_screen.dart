import 'package:explaino/config/di/di.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/routing/app_routes_constant.dart';
import 'package:explaino/core/shared/data/models/otp/verify_otp_request_model/verify_otp_request_model.dart';
import 'package:explaino/core/shared/domain/entities/otp/resend_otp_request_entity.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/core/utils/ui_utils.dart';
import 'package:explaino/features/auth/forgot_password/presentation/cubit/forgot_password_cubit.dart';
import 'package:explaino/features/auth/forgot_password/presentation/cubit/forgot_password_intents.dart';
import 'package:explaino/features/auth/forgot_password/presentation/cubit/forgot_password_side_effects.dart';
import 'package:explaino/features/auth/forgot_password/presentation/widgets/otp_fields.dart';
import 'package:explaino/features/auth/forgot_password/presentation/widgets/resend_section.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  const OtpVerificationScreen({super.key, required this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  late final ForgotPasswordCubit forgotPasswordCubit;

  String _otpCode = '';

  @override
  void initState() {
    super.initState();
    forgotPasswordCubit = getIt<ForgotPasswordCubit>();
    forgotPasswordCubit.sideEffects.listen((effect) {
      switch (effect) {
        case ShowLoading():
          _handleLoading();
        case ShowError():
          _handleError(effect.message);
        case NavigateToResetPasswordScreen(
          email: final email,
          resetToken: final resetToken,
        ):
          _handleNavigateToResetPasswordScreen(
            email: email,
            resetToken: resetToken,
          );
        case ShowMessage(message: final message):
          _handelMessage(message);
        default:
          break;
      }
    });
  }

  void _handleLoading() => UIUtils.showEasyLoading();

  void _handleError(String message) {
    UIUtils.hideEasyLoading();
    UIUtils.showMessage(
      message,
      backGroundColor: AppColors.error,
      textColor: AppColors.white,
    );
  }

  void _handelMessage(String message) {
    UIUtils.hideEasyLoading();
    UIUtils.showMessage(
      message,
      backGroundColor: AppColors.green,
      textColor: AppColors.white,
    );
  }

  void _handleNavigateToResetPasswordScreen({
    required String email,
    required String resetToken,
  }) {
    UIUtils.hideEasyLoading();
    GoRouter.of(context).go(
      AppRoutesConstants.resetPasswordRoute,
      extra: {'email': email, 'resetToken': resetToken},
    );
  }

  void _onVerifyPressed() {
    if (_otpCode.length < 6) return;
    forgotPasswordCubit.doIntent(
      VerifyOtpCodeIntent(
        verifyOtpRequestModel: VerifyOtpRequestModel(
          otp: _otpCode,
          email: widget.email,
        ),
      ),
    );
  }

  void _onResend() {
    forgotPasswordCubit.doIntent(
      ResendOtpCodeIntent(
        resendOtpRequestEntity: ResendOtpRequestEntity(email: widget.email),
      ),
    );
  }

  @override
  void dispose() {
    forgotPasswordCubit.close();
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.12),
                Text(
                  AppTextConstants.verificationCode,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    AppTextConstants.enterOtpCode,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 40),
                OtpFields(
                  onChanged: (value) => setState(() => _otpCode = value),
                ),
                const SizedBox(height: 24),
                ResendSection(onResend: _onResend),
                SizedBox(height: size.height * 0.4),
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.06,
                  child: ElevatedButton(
                    onPressed: _onVerifyPressed,
                    child: Text(
                      AppTextConstants.verify,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.copyWith(color: Colors.white),
                    ),
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

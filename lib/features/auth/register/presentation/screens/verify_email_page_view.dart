import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/shared/domain/entities/auth/otp/resend_otp_request_entity.dart';
import 'package:explaino/core/shared/domain/entities/auth/otp/verify_otp_request_entity.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/auth/forgot_password/presentation/widgets/otp_fields.dart';
import 'package:explaino/features/auth/forgot_password/presentation/widgets/resend_section.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_intents.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyEmailPageView extends StatefulWidget {
  const VerifyEmailPageView({super.key});

  @override
  State<VerifyEmailPageView> createState() => _VerifyEmailPageViewState();
}

class _VerifyEmailPageViewState extends State<VerifyEmailPageView> {
  late Size screenSize;
  late TextTheme textTheme;
  late String _otpCode;

  @override
  void initState() {
    super.initState();
    _otpCode = context.read<RegisterCubit>().state.otpCode;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenSize = MediaQuery.sizeOf(context);
    textTheme = Theme.of(context).textTheme;
  }

  void _onVerifyPressed() {
    if (_otpCode.length < 6) return;
    context.read<RegisterCubit>().doIntent(
      VerifyEmailAndRegisterIntent(
        VerifyOtpRequestEntity(
          otp: _otpCode,
          email: context.read<RegisterCubit>().state.email,
        ),
      ),
    );
  }

  void _onChanged() {
    context.read<RegisterCubit>().doIntent(
      ValidateOtpCodeIntent(enabled: _otpCode.length == 6),
    );
    context.read<RegisterCubit>().doIntent(
      UpdateOtpCodeIntent(otpCode: _otpCode),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: screenSize.height * 0.07),
          Text(
            AppTextConstants.verificationCode,
            style: textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            AppTextConstants.enterOtpCode,
            textAlign: TextAlign.center,
            style: textTheme.titleMedium,
          ),
          SizedBox(height: screenSize.height * 0.06),
          StatefulBuilder(
            builder: (context, setOtpState) {
              return OtpFields(
                initialValue: _otpCode,
                onChanged: (value) => setOtpState(() {
                  _otpCode = value;

                  _onChanged();
                }),
              );
            },
          ),
          const SizedBox(height: 24),
          ResendSection(
            onResend: () {
              context.read<RegisterCubit>().doIntent(
                ResendOtpIntent(
                  resendOtpRequestEntity: ResendOtpRequestEntity(
                    email: context.read<RegisterCubit>().state.email,
                  ),
                ),
              );
            },
          ),
          SizedBox(height: screenSize.height * 0.2),
          SizedBox(
            width: double.infinity,
            height: screenSize.height * 0.06,
            child: BlocBuilder<RegisterCubit, RegisterState>(
              buildWhen: (previous, current) =>
                  current.enabledVerifyButton != previous.enabledVerifyButton,
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: state.enabledVerifyButton
                      ? _onVerifyPressed
                      : null,
                  child: Text(
                    AppTextConstants.verify,
                    style: textTheme.bodyLarge!.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

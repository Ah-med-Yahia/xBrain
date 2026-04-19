import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:flutter/material.dart';

class VerifyEmailPageView extends StatefulWidget {
  const VerifyEmailPageView({super.key});

  @override
  State<VerifyEmailPageView> createState() => _VerifyEmailPageViewState();
}

class _VerifyEmailPageViewState extends State<VerifyEmailPageView> {
  late Size screenSize;
  late TextTheme textTheme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenSize = MediaQuery.sizeOf(context);
    textTheme = Theme.of(context).textTheme;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: screenSize.height * 0.12),
          Text(
            AppTextConstants.verificationCode,
            style: textTheme.headlineLarge,
          ),
          // const SizedBox(height: 12),
          // Center(
          //   child: Text(
          //     AppTextConstants.enterOtpCode,
          //     textAlign: TextAlign.center,
          //     style: textTheme.titleMedium,
          //   ),
          // ),
          // const SizedBox(height: 40),
          // OtpFields(onChanged: (value) => setState(() => _otpCode = value)),
          // const SizedBox(height: 24),
          // ResendSection(onResend: _onResend),
          // SizedBox(height: screenSize.height * 0.4),
          // SizedBox(
          //   width: double.infinity,
          //   height: screenSize.height * 0.06,
          //   child: ElevatedButton(
          //     onPressed: _onVerifyPressed,
          //     child: Text(
          //       AppTextConstants.verify,
          //       style: textTheme.bodyLarge!.copyWith(color: Colors.white),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

import 'dart:async';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ResendSection extends StatefulWidget {
  final VoidCallback onResend;
  const ResendSection({super.key, required this.onResend});

  @override
  State<ResendSection> createState() => _ResendSectionState();
}

class _ResendSectionState extends State<ResendSection> {
  static const int _resendSeconds = 55; //
  int _remainingSeconds = _resendSeconds;
  Timer? _resendTimer;
  bool _canResend = false;

  String get _formattedTimer {
    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _startResendTimer() {
    setState(() {
      _canResend = false;
      _remainingSeconds = _resendSeconds;
    });
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds == 0) {
        timer.cancel();
        setState(() => _canResend = true);
      } else {
        setState(() => _remainingSeconds--);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            AppTextConstants.didNotReceiveCode,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: _canResend
              ? GestureDetector(
                  onTap: () {
                    _startResendTimer();
                    widget.onResend();
                  },
                  child: Text(
                    AppTextConstants.resendCode,
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall!.copyWith(color: AppColors.primary),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 14,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formattedTimer,
                        style: Theme.of(context).textTheme.labelMedium!
                            .copyWith(color: AppColors.primary),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}

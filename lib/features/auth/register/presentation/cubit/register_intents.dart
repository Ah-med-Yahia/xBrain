import 'dart:io';

import 'package:explaino/core/shared/domain/entities/auth/otp/resend_otp_request_entity.dart';
import 'package:explaino/core/shared/domain/entities/auth/otp/verify_otp_request_entity.dart';
import 'package:explaino/features/auth/register/domain/entities/request/register_request_entity.dart';
import 'package:explaino/features/auth/register/presentation/ui_models/setup_profile_ui_model.dart';

sealed class RegisterIntent {}

// ==================== page view 1 ====================

class UpdateEmailIntent extends RegisterIntent {
  final String email;
  UpdateEmailIntent({required this.email});
}

class ValidateNextButtonIntent extends RegisterIntent {
  final bool enabled;
  ValidateNextButtonIntent({required this.enabled});
}

// ==================== page view 2 ====================

class UpdateSetupProfileIntent extends RegisterIntent {
  final SetupProfileUIModel setupProfileUIModel;
  UpdateSetupProfileIntent(this.setupProfileUIModel);
}

class SendOtpIntent extends RegisterIntent {
  final RegisterRequestEntity registerRequestEntity;
  SendOtpIntent(this.registerRequestEntity);
}

class ValidateCreateAccountButtonIntent extends RegisterIntent {
  final bool enabled;
  ValidateCreateAccountButtonIntent({required this.enabled});
}

class TogglePasswordVisibilityIntent extends RegisterIntent {
  TogglePasswordVisibilityIntent();
}

class ToggleConfirmPasswordVisibilityIntent extends RegisterIntent {
  ToggleConfirmPasswordVisibilityIntent();
}

// ==================== page view 3 ====================

class UpdateOtpCodeIntent extends RegisterIntent {
  final String otpCode;
  UpdateOtpCodeIntent({required this.otpCode});
}

class ResendOtpIntent extends RegisterIntent {
  final ResendOtpRequestEntity resendOtpRequestEntity;
  ResendOtpIntent({required this.resendOtpRequestEntity});
}

class VerifyEmailAndRegisterIntent extends RegisterIntent {
  final VerifyOtpRequestEntity verifyOtpRequestEntity;
  VerifyEmailAndRegisterIntent(this.verifyOtpRequestEntity);
}

class ValidateVerifyButtonIntent extends RegisterIntent {
  final bool enabled;
  ValidateVerifyButtonIntent({required this.enabled});
}

// ==================== page view 4 ====================

class PickImageIntent extends RegisterIntent {
  final File imageFile;
  PickImageIntent({required this.imageFile});
}

// ==================== shared ====================

class NavigateToPageIntent extends RegisterIntent {
  final int currentPage;
  NavigateToPageIntent({required this.currentPage});
}

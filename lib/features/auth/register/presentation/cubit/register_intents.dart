import 'package:explaino/core/shared/domain/entities/auth/otp/resend_otp_request_entity.dart';
import 'package:explaino/core/shared/domain/entities/auth/otp/verify_otp_request_entity.dart';
import 'package:explaino/features/auth/register/domain/entities/request/register_request_entity.dart';
import 'package:explaino/features/auth/register/presentation/ui_models/setup_profile_ui_model.dart';

sealed class RegisterIntent {}

class UpdateEmailIntent extends RegisterIntent {
  final String email;
  UpdateEmailIntent({required this.email});
}

class UpdateSetupProfileIntent extends RegisterIntent {
  final SetupProfileUIModel setupProfileUIModel;
  UpdateSetupProfileIntent(this.setupProfileUIModel);
}

class SendOtpIntent extends RegisterIntent {
  final RegisterRequestEntity registerRequestEntity;
  SendOtpIntent(this.registerRequestEntity);
}

class ResendOtpIntent extends RegisterIntent {
  final ResendOtpRequestEntity resendOtpRequestEntity;
  ResendOtpIntent(this.resendOtpRequestEntity);
}

class VerifyEmailAndRegisterIntent extends RegisterIntent {
  final VerifyOtpRequestEntity verifyOtpRequestEntity;
  VerifyEmailAndRegisterIntent(this.verifyOtpRequestEntity);
}

class ValidateNextButtonIntent extends RegisterIntent {
  final bool enabled;
  ValidateNextButtonIntent({required this.enabled});
}

class ValidateCreateAccountButtonIntent extends RegisterIntent {
  final bool enabled;
  ValidateCreateAccountButtonIntent({required this.enabled});
}

class ValidateVerifyButtonIntent extends RegisterIntent {
  final bool enabled;
  ValidateVerifyButtonIntent({required this.enabled});
}

class TogglePasswordVisibilityIntent extends RegisterIntent {
  TogglePasswordVisibilityIntent();
}

class ToggleConfirmPasswordVisibilityIntent extends RegisterIntent {
  ToggleConfirmPasswordVisibilityIntent();
}

class NavigateToPageIntent extends RegisterIntent {
  final int currentPage;
  NavigateToPageIntent({required this.currentPage});
}

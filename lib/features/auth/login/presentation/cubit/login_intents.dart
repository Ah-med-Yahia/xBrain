import 'package:explaino/features/auth/login/domain/entities/request/login_request_entity.dart';

sealed class LoginIntent {}

class LoginSubmitIntent extends LoginIntent {
  final LoginRequestEntity loginRequestEntity;
  LoginSubmitIntent({required this.loginRequestEntity});
}

class ValidateEmailIntent extends LoginIntent {
  final String email;
  ValidateEmailIntent({required this.email});
}

class ValidatePasswordIntent extends LoginIntent {
  final String password;
  ValidatePasswordIntent({required this.password});
}

class TogglePasswordVisibilityIntent extends LoginIntent {}

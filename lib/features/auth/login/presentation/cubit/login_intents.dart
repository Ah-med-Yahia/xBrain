import 'package:explaino/features/auth/login/domain/entities/login_request_entity.dart';

sealed class LoginIntent {}

class LoginSubmitIntent extends LoginIntent {
  final LoginRequestEntity loginRequestEntity;
  LoginSubmitIntent({required this.loginRequestEntity});
}

class ValidateFieldsIntent extends LoginIntent {
  final bool formsValid;
  ValidateFieldsIntent({required this.formsValid});
}

class TogglePasswordVisibilityIntent extends LoginIntent {}

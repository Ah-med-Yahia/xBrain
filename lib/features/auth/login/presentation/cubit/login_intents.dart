import 'package:explaino/features/auth/login/data/models/login_request_model.dart';

sealed class LoginIntent {}

class LoginSubmitIntent extends LoginIntent {
  final LoginRequestModel loginRequestModel;
  LoginSubmitIntent({required this.loginRequestModel});
}

class ValidateFieldsIntent extends LoginIntent {
  final bool formsValid;
  ValidateFieldsIntent({required this.formsValid});
}

class TogglePasswordVisibilityIntent extends LoginIntent {}

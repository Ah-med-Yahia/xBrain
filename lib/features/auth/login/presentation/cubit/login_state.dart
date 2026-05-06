import 'package:equatable/equatable.dart';
import 'package:explaino/config/base_state/base_state.dart';
import 'package:explaino/core/shared/domain/entities/auth/message_entity.dart';

class LoginState extends Equatable {
  final BaseState<MessageEntity>? loginBaseState;
  final bool validateEmail;
  final bool validatePassword;
  final bool fieldsValidation;
  final bool obscurePassword;
  const LoginState({
    this.loginBaseState,
    this.validateEmail = false,
    this.validatePassword = false,
    this.fieldsValidation = false,
    this.obscurePassword = true,
  });

  LoginState copyWith({
    BaseState<MessageEntity>? loginBaseState,
    bool? validateEmail,
    bool? validatePassword,
    bool? fieldsValidation,
    bool? obscurePassword,
  }) {
    return LoginState(
      loginBaseState: loginBaseState ?? this.loginBaseState,
      validateEmail: validateEmail ?? this.validateEmail,
      validatePassword: validatePassword ?? this.validatePassword,
      fieldsValidation: fieldsValidation ?? this.fieldsValidation,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }

  @override
  List<Object?> get props => [
    loginBaseState,
    validateEmail,
    validatePassword,
    fieldsValidation,
    obscurePassword,
  ];
}

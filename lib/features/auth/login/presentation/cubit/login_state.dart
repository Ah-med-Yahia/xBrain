import 'package:equatable/equatable.dart';
import 'package:explaino/config/base_state/base_state.dart';
import 'package:explaino/core/shared/domain/entities/auth/message_entity.dart';

class LoginState extends Equatable {
  final BaseState<MessageEntity>? loginBaseState;
  final bool fieldsValidation;
  final bool obscurePassword;
  const LoginState({
    this.loginBaseState,
    this.fieldsValidation = false,
    this.obscurePassword = true,
  });

  LoginState copyWith({
    BaseState<MessageEntity>? loginBaseState,
    bool? fieldsValidation,
    bool? obscurePassword,
  }) {
    return LoginState(
      loginBaseState: loginBaseState ?? this.loginBaseState,
      fieldsValidation: fieldsValidation ?? this.fieldsValidation,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }

  @override
  List<Object?> get props => [
    loginBaseState,
    fieldsValidation,
    obscurePassword,
  ];
}

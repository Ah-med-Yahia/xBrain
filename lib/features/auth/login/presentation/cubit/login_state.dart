import 'package:equatable/equatable.dart';
import 'package:explaino/config/base_state/base_state.dart';
import 'package:explaino/core/shared/domain/entities/message_entity.dart';

class LoginState extends Equatable {
  final BaseState<MessageEntity>? loginBaseState;
  final bool fieldsValidation;
  const LoginState({this.loginBaseState, this.fieldsValidation = false});

  LoginState copyWith({
    BaseState<MessageEntity>? loginBaseState,
    bool? fieldsValidation,
  }) {
    return LoginState(
      loginBaseState: loginBaseState ?? this.loginBaseState,
      fieldsValidation: fieldsValidation ?? this.fieldsValidation,
    );
  }

  @override
  List<Object?> get props => [loginBaseState, fieldsValidation];
}

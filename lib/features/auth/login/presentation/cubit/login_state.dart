import 'package:equatable/equatable.dart';
import 'package:explaino/config/base_state/base_state.dart';
import 'package:explaino/core/shared/domain/entities/message_entity.dart';

class LoginState extends Equatable {
  final BaseState<MessageEntity>? loginBaseState;
  const LoginState({this.loginBaseState});

  LoginState copyWith({BaseState<MessageEntity>? loginBaseState}) {
    return LoginState(loginBaseState: loginBaseState ?? this.loginBaseState);
  }

  @override
  List<Object?> get props => [loginBaseState];
}

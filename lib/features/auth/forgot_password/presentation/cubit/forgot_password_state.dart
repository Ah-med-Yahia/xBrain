import 'package:equatable/equatable.dart';
import 'package:explaino/config/base_state/base_state.dart';
import 'package:explaino/core/shared/domain/entities/message_entity.dart';

class ForgotPasswordState extends Equatable {
  final BaseState<MessageEntity>? forgotPasswordBaseState;

  const ForgotPasswordState({this.forgotPasswordBaseState});

  ForgotPasswordState copyWith({
    BaseState<MessageEntity>? forgotPasswordBaseState,
  }) {
    return ForgotPasswordState(
      forgotPasswordBaseState:
          forgotPasswordBaseState ?? this.forgotPasswordBaseState,
    );
  }

  @override
  List<Object?> get props => [forgotPasswordBaseState];
}

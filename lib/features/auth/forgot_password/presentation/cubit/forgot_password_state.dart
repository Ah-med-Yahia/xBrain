import 'package:equatable/equatable.dart';
import 'package:explaino/config/base_state/base_state.dart';
import 'package:explaino/core/shared/domain/entities/message_entity.dart';

class ForgotPasswordState extends Equatable {
  final BaseState<MessageEntity>? forgotPasswordBaseState;
  final bool obscurePassword;
  final bool obscureConfirmPassword;

  const ForgotPasswordState({
    this.forgotPasswordBaseState,
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
  });

  ForgotPasswordState copyWith({
    BaseState<MessageEntity>? forgotPasswordBaseState,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
  }) {
    return ForgotPasswordState(
      forgotPasswordBaseState:
          forgotPasswordBaseState ?? this.forgotPasswordBaseState,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword:
          obscureConfirmPassword ?? this.obscureConfirmPassword,
    );
  }

  @override
  List<Object?> get props => [
    forgotPasswordBaseState,
    obscurePassword,
    obscureConfirmPassword,
  ];
}

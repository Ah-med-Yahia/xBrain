import 'dart:async';
import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/validators/app_validators.dart';
import 'package:explaino/features/auth/login/domain/entities/request/login_request_entity.dart';
import 'package:explaino/features/auth/login/domain/usecase/login_use_case.dart';
import 'package:explaino/features/auth/login/presentation/cubit/login_intents.dart';
import 'package:explaino/features/auth/login/presentation/cubit/login_side_effects.dart';
import 'package:explaino/features/auth/login/presentation/cubit/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final _sideEffectController = StreamController<LoginSideEffect>.broadcast();
  Stream<LoginSideEffect> get sideEffects => _sideEffectController.stream;
  LoginCubit(this.loginUseCase) : super(const LoginState());

  void doIntent(LoginIntent intent) {
    switch (intent) {
      case LoginSubmitIntent(loginRequestEntity: final loginRequestEntity):
        _login(loginRequestEntity);
      case ValidateEmailIntent(email: final email):
        _validateEmail(email);
      case ValidatePasswordIntent(password: final password):
        _validatePassword(password);
      case TogglePasswordVisibilityIntent():
        _togglePasswordVisibility();
    }
  }

  Future<void> _login(LoginRequestEntity loginRequestModel) async {
    _sideEffectController.add(ShowLoading());
    final result = await loginUseCase(loginRequestModel);
    result.when(
      success: (data) {
        _sideEffectController.add(HideLoading());
        _sideEffectController.add(NavigateToMainScreen());
      },
      failure: (failure) {
        _sideEffectController.add(HideLoading());
        _sideEffectController.add(ShowError(failure.message));
      },
    );
  }

  void _validateEmail(String email) {
    final bool validateEmail = AppValidators.validateEmail(email) == null;
    emit(
      state.copyWith(
        validateEmail: validateEmail,
        fieldsValidation: validateEmail && state.validatePassword,
      ),
    );
  }

  void _validatePassword(String password) {
    final bool validatePassword =
        AppValidators.validateLoginPassword(password) == null;
    emit(
      state.copyWith(
        validatePassword: validatePassword,
        fieldsValidation: state.validateEmail && validatePassword,
      ),
    );
  }

  void _togglePasswordVisibility() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  @override
  Future<void> close() {
    _sideEffectController.close();
    return super.close();
  }
}

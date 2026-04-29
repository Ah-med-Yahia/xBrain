import 'dart:async';
import 'dart:io';

import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/base_state/base_state.dart';
import 'package:explaino/core/shared/domain/entities/auth/otp/resend_otp_request_entity.dart';
import 'package:explaino/core/shared/domain/entities/auth/otp/verify_otp_request_entity.dart';
import 'package:explaino/core/shared/domain/use_cases/auth/resend_otp_use_case.dart';
import 'package:explaino/features/auth/register/domain/entities/request/register_request_entity.dart';
import 'package:explaino/features/auth/register/domain/usecases/get_specializations_use_case.dart';
import 'package:explaino/features/auth/register/domain/usecases/send_opt_use_case.dart';
import 'package:explaino/features/auth/register/domain/usecases/upload_profile_pic_use_case.dart';
import 'package:explaino/features/auth/register/domain/usecases/verify_email_and_register.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_intents.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_side_effects.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_state.dart';
import 'package:explaino/features/auth/register/presentation/model_ui/get_specializations_response_model_ui.dart';
import 'package:explaino/features/auth/register/presentation/ui_models/setup_profile_ui_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final SendOptUseCase _sendOtpUseCase;
  final ResendOtpUseCase _resendOtpUseCase;
  final VerifyEmailAndRegisterUseCase _verifyEmailAndRegisterUseCase;
  final UploadProfilePicUseCase _uploadProfilePicUseCase;
  final GetSpecializationsUseCase _getspecializationsUseCase;

  final StreamController<RegisterSideEffect> _sideEffectsController =
      StreamController<RegisterSideEffect>.broadcast();
  Stream<RegisterSideEffect> get sideEffects => _sideEffectsController.stream;

  RegisterCubit(
    this._sendOtpUseCase,
    this._resendOtpUseCase,
    this._verifyEmailAndRegisterUseCase,
    this._uploadProfilePicUseCase,
    this._getspecializationsUseCase,
  ) : super(RegisterState());

  void doIntent(RegisterIntent intent) {
    switch (intent) {
      // ==================== page view 1 ====================
      case UpdateEmailIntent(email: final email):
        _updateEmail(email);
      case ValidateNextButtonIntent(enabled: final enabled):
        _validateNextButton(enabled: enabled);
      // ==================== page view 2 ====================
      case UpdateSetupProfileIntent(
        setupProfileUIModel: final setupProfileUIModel,
      ):
        _updateSetupProfile(setupProfileUIModel);
      case SendOtpIntent(registerRequestEntity: final registerRequestEntity):
        _sendOtp(registerRequestEntity);
      case ValidateCreateAccountButtonIntent(enabled: final enabled):
        _validateCreateAccountButton(enabled: enabled);
      case TogglePasswordVisibilityIntent():
        _togglePasswordVisibility();
      case ToggleConfirmPasswordVisibilityIntent():
        _toggleConfirmPasswordVisibility();
      // ==================== page view 3 ====================
      case UpdateOtpCodeIntent(otpCode: final otpCode):
        _updateOtpCode(otpCode);
      case ResendOtpIntent(
        resendOtpRequestEntity: final resendOtpRequestEntity,
      ):
        _resendOtp(resendOtpRequestEntity);
      case VerifyEmailAndRegisterIntent(
        verifyOtpRequestEntity: final verifyOtpRequestEntity,
      ):
        _verifyEmailAndRegister(verifyOtpRequestEntity);
      case ValidateVerifyButtonIntent(enabled: final enabled):
        _validateVerifyButton(enabled: enabled);
      // ==================== page view 4 ====================
      case PickImageIntent(imageFile: final imageFile):
        _pickImage(imageFile);
      case UploadProfilePicIntent(imageFile: final imageFile):
        _uploadProfilePic(imageFile);
      // ==================== page view 5 ====================
      case GetSpecializationsIntent():
        _getSpecializations();
      case SelectSpecializationIntent(specializationId: final specializationId):
        _selectSpecialization(specializationId: specializationId);
      // ==================== shared ====================
      case NavigateToPageIntent(currentPage: final currentPage):
        _navigateToPage(currentPage: currentPage);
    }
  }

  void _updateEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void _validateNextButton({required bool enabled}) {
    emit(state.copyWith(enabledNextButton: enabled));
  }

  void _updateSetupProfile(SetupProfileUIModel setupProfileUIModel) {
    emit(state.copyWith(setupProfileUIModel: setupProfileUIModel));
  }

  void _sendOtp(RegisterRequestEntity request) async {
    _sideEffectsController.add(ShowLoading());
    final response = await _sendOtpUseCase(request);
    _sideEffectsController.add(HideLoading());
    response.when(
      success: (data) {
        _sideEffectsController.add(NavigateToNextPage(successMessage: data));
      },
      failure: (failure) {
        _sideEffectsController.add(ShowError(failure.message));
      },
    );
  }

  void _validateCreateAccountButton({required bool enabled}) {
    emit(state.copyWith(enabledCreateAccountButton: enabled));
  }

  void _togglePasswordVisibility() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void _toggleConfirmPasswordVisibility() {
    emit(state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword));
  }

  void _updateOtpCode(String otpCode) {
    emit(state.copyWith(otpCode: otpCode));
  }

  void _resendOtp(ResendOtpRequestEntity request) async {
    _sideEffectsController.add(ShowLoading());
    final response = await _resendOtpUseCase(request);
    _sideEffectsController.add(HideLoading());
    response.when(
      success: (data) {
        _sideEffectsController.add(ShowMessage(data));
      },
      failure: (failure) {
        _sideEffectsController.add(ShowError(failure.message));
      },
    );
  }

  void _verifyEmailAndRegister(VerifyOtpRequestEntity request) async {
    _sideEffectsController.add(ShowLoading());
    final response = await _verifyEmailAndRegisterUseCase(request);
    _sideEffectsController.add(HideLoading());
    response.when(
      success: (data) {
        _sideEffectsController.add(NavigateToNextPage(successMessage: data));
      },
      failure: (failure) {
        _sideEffectsController.add(ShowError(failure.message));
      },
    );
  }

  void _validateVerifyButton({required bool enabled}) {
    emit(state.copyWith(enabledVerifyButton: enabled));
  }

  void _pickImage(File imageFile) {
    emit(state.copyWith(imageFile: imageFile));
  }

  void _uploadProfilePic(File imageFile) async {
    _sideEffectsController.add(ShowLoading());
    final response = await _uploadProfilePicUseCase(imageFile);
    _sideEffectsController.add(HideLoading());
    response.when(
      success: (data) {
        _sideEffectsController.add(NavigateToNextPage());
      },
      failure: (failure) {
        _sideEffectsController.add(ShowError(failure.message));
      },
    );
  }

  void _getSpecializations() async {
    _sideEffectsController.add(ShowLoading());
    final response = await _getspecializationsUseCase();
    _sideEffectsController.add(HideLoading());
    response.when(
      success: (data) {
        emit(
          state.copyWith(
            specializations: BaseState<GetSpecializationsResponseModelUi>(
              data: data,
            ),
          ),
        );
      },
      failure: (failure) {
        emit(
          state.copyWith(
            specializations: BaseState<GetSpecializationsResponseModelUi>(
              errorMessage: failure.message,
            ),
          ),
        );
      },
    );
  }

  void _selectSpecialization({required String specializationId}) {
    final currentSpecializations = List<String>.from(
      state.selectedSpecializations,
    );

    if (currentSpecializations.contains(specializationId)) {
      currentSpecializations.remove(specializationId);
    } else {
      currentSpecializations.add(specializationId);
    }

    emit(state.copyWith(selectedSpecializations: currentSpecializations));
  }

  void _navigateToPage({required int currentPage}) {
    emit(state.copyWith(currentPage: currentPage));
  }

  @override
  Future<void> close() {
    _sideEffectsController.close();
    return super.close();
  }
}

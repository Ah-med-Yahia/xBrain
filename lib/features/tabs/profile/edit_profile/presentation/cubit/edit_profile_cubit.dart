import 'dart:async';
import 'dart:io';

import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/tabs/profile/edit_profile/data/models/request/edit_profile_request_model.dart';
import 'package:explaino/features/tabs/profile/edit_profile/domain/usecase/edit_profile_use_case.dart';
import 'package:explaino/features/tabs/profile/edit_profile/presentation/cubit/edit_profile_intents.dart';
import 'package:explaino/features/tabs/profile/edit_profile/presentation/cubit/edit_profile_side_effects.dart';
import 'package:explaino/features/tabs/profile/edit_profile/presentation/cubit/edit_profile_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileUseCase profileUseCase;
  final _sideEffectController =
      StreamController<EditProfileSideEffects>.broadcast();
  Stream<EditProfileSideEffects> get sideEffects =>
      _sideEffectController.stream;
  EditProfileCubit(this.profileUseCase) : super(const EditProfileState());

  void doIntent(EditProfileIntents intent) {
    switch (intent) {
      case EditProfileIntent(editProfileRequestModel: final request):
        _editProfile(request);
      case PickImageIntent(imageFile: final file):
        _pickImage(file);
        break;
      case BioCharCountIntent(bioCharCount: final bioCharCount):
        _bioCharCount(bioCharCount);
        break;
    }
  }

  void _editProfile(EditProfileRequestModel editProfileRequestModel) async {
    _sideEffectController.add(ShowLoading());
    final result = await profileUseCase(editProfileRequestModel);
    result.when(
      success: (data) {
        _sideEffectController.add(HideLoading());
        _sideEffectController.add(PopScreen());
      },
      failure: (failure) {
        _sideEffectController.add(HideLoading());
        _sideEffectController.add(ShowError(failure.message));
      },
    );
  }

  void _pickImage(File imageFile) {
    emit(state.copyWith(selectedImage: imageFile));
  }

  void _bioCharCount(int bioCharCount) {
    emit(state.copyWith(bioCharCount: bioCharCount));
  }

  @override
  Future<void> close() {
    _sideEffectController.close();
    return super.close();
  }
}

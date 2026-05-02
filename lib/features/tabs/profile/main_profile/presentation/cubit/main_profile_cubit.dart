import 'dart:async';

import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/tabs/profile/main_profile/domain/usecase/get_main_profile_use_case.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/cubit/main_profile_intents.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/cubit/main_profile_side_effects.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/cubit/main_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class MainProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase _getUserUseCase;
  final _sideEffectController =
      StreamController<MainProfileSideEffects>.broadcast();
  Stream<MainProfileSideEffects> get sideEffects =>
      _sideEffectController.stream;
  MainProfileCubit(this._getUserUseCase) : super(const ProfileState());

  void doIntent(MainProfileIntents intent) {
    switch (intent) {
      case GetProfileDataIntent():
        _getProfileData();
        break;
      case NavigateToEditProfileImageScreenIntent():
        _handleNavigateToEditProfileImageScreenIntent(intent);
        break;
      case NavigateToEditProfileScreenIntent():
        _handleNavigateToEditProfileScreenIntent(intent);
        break;
    }
  }

  void _handleNavigateToEditProfileImageScreenIntent(
    NavigateToEditProfileImageScreenIntent intent,
  ) {
    _sideEffectController.add(
      NavigationToEditProfileImageScreen(intent.imageUrl),
    );
  }

  void _handleNavigateToEditProfileScreenIntent(
    NavigateToEditProfileScreenIntent intent,
  ) {
    _sideEffectController.add(NavigateToEditProfileScreen(intent.user));
  }

  Future<void> _getProfileData() async {
    emit(
      state.copyWith(
        profileBaseState: state.profileBaseState?.copyWith(isFetching: true),
      ),
    );
    final result = await _getUserUseCase();
    result.when(
      success: (data) {
        _sideEffectController.add(HideLoading());
        emit(
          state.copyWith(
            profileBaseState: state.profileBaseState?.copyWith(data: data),
          ),
        );
      },
      failure: (failure) {
        emit(
          state.copyWith(
            profileBaseState: state.profileBaseState?.copyWith(
              errorMessage: failure.message,
            ),
          ),
        );
      },
    );
  }
}

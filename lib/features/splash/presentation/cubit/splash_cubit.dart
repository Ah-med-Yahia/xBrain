import 'dart:async';
import 'package:explaino/core/shared/domain/use_cases/auth/user_app_status_use_case.dart';
import 'package:explaino/features/splash/presentation/cubit/splash_intents.dart';
import 'package:explaino/features/splash/presentation/cubit/splash_side_effects.dart';
import 'package:explaino/features/splash/presentation/cubit/splash_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SplashCubit extends Cubit<SplashStates> {
  final GetUserStatusUseCase getUserStatusUseCase;
  SplashCubit({required this.getUserStatusUseCase})
    : super(const SplashStates());
  final StreamController<SplashSideEffects> _splashSideEffectsController =
      StreamController<SplashSideEffects>.broadcast();
  Stream<SplashSideEffects> get splashSideEffectsStream =>
      _splashSideEffectsController.stream;

  void doIntent(SplashIntent intent) {
    switch (intent) {
      case GetUserStatusIntent():
        _getUserStatus();
    }
  }

  void _getUserStatus() async {
    final result = await getUserStatusUseCase();
    _splashSideEffectsController.add(NavigateToNextScreenSideEffect(result));
  }

  @override
  Future<void> close() {
    _splashSideEffectsController.close();
    return super.close();
  }
}

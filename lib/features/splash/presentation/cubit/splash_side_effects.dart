import 'package:explaino/features/splash/presentation/cubit/splash_states.dart';

sealed class SplashSideEffects {
  const SplashSideEffects();
}

class NavigateToNextScreenSideEffect extends SplashSideEffects {
  final UserInitialStatus status;
  const NavigateToNextScreenSideEffect(this.status);
}

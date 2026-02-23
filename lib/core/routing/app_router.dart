import 'package:explaino/core/constants/app_routes_constant.dart';
import 'package:explaino/features/main/presentation/screens/main_screen.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/login/presentation/screens/forget_password_screen.dart';
import '../../features/auth/login/presentation/screens/login_screen.dart';
import '../../features/auth/login/presentation/screens/reset_password_screen.dart';

abstract class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: AppRoutesConstants.main,
    routes: [
      GoRoute(
        path: AppRoutesConstants.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.forgetPassword,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.resetPassword,
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.main,
        builder: (context, state) => const MainScreen(),
      ),
    ],
  );
}

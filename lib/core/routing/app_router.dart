import 'package:explaino/core/constants/app_routes_constant.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/login/presentation/screens/login_screen.dart';

abstract class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: AppRoutesConstants.login,
    routes: [
      GoRoute(
        path: AppRoutesConstants.login,
        builder: (context, state) => const LoginScreen(),
      ),
    ],
  );
}

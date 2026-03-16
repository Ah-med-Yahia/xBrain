import 'package:explaino/core/routing/app_routes_constant.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutesConstants.loginRoute,
    routes: [
      GoRoute(
        path: AppRoutesConstants.loginRoute,
        // builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.registerRoute,
        // builder: (context, state) => const RegisterScreen(),
      ),
    ],
  );
}

import 'package:explaino/core/routing/app_routes_constant.dart';
import 'package:explaino/features/auth/forgot_password/presentation/screens/forgot_password_screen.dart';
import 'package:explaino/features/auth/forgot_password/presentation/screens/otp_verification_screen.dart';
import 'package:explaino/features/auth/forgot_password/presentation/screens/reset_password_screen.dart';
import 'package:explaino/features/auth/login/presentation/screens/login_screen.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: AppRoutesConstants.loginRoute,
    routes: [
      GoRoute(
        path: AppRoutesConstants.loginRoute,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.forgotPasswordRoute,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.resetPassword,
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.otpVerificationRoute,
        builder: (context, state) => const OtpVerificationScreen(),
      ),
    ],
  );
}

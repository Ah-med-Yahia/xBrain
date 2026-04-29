import 'package:explaino/core/routing/app_routes_constant.dart';
import 'package:explaino/features/auth/forgot_password/presentation/screens/forgot_password_screen.dart';
import 'package:explaino/features/auth/forgot_password/presentation/screens/otp_verification_screen.dart';
import 'package:explaino/features/auth/forgot_password/presentation/screens/reset_password_screen.dart';
import 'package:explaino/features/auth/login/presentation/screens/login_screen.dart';
import 'package:explaino/features/auth/register/presentation/screens/register_screen.dart';
import 'package:explaino/features/main/presentation/screens/main_screen.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: AppRoutesConstants.loginRoute,
    routes: [
      GoRoute(
        path: AppRoutesConstants.registerRoute,
        name: AppRoutesConstants.registerRoute,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.loginRoute,
        name: AppRoutesConstants.loginRoute,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.forgotPasswordRoute,
        name: AppRoutesConstants.forgotPasswordRoute,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.resetPasswordRoute,
        name: AppRoutesConstants.resetPasswordRoute,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;

          return ResetPasswordScreen(
            email: data[AppRoutesConstants.emailKey] as String,
            resetToken: data[AppRoutesConstants.resetTokenKey] as String,
          );
        },
      ),
      GoRoute(
        path: AppRoutesConstants.otpVerificationRoute,
        name: AppRoutesConstants.otpVerificationRoute,

        builder: (context, state) =>
            OtpVerificationScreen(email: state.extra as String),
      ),
      GoRoute(
        path: AppRoutesConstants.mainScreenRoute,
        name: AppRoutesConstants.mainScreenRoute,
        builder: (context, state) => const MainScreen(),
      ),
    ],
  );
}

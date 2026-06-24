import 'package:explaino/core/routing/app_routes_constant.dart';
import 'package:explaino/core/shared/domain/entities/auth/user_entity/user_entity.dart';
import 'package:explaino/features/add_answer/presentation/screens/add_answer_screen.dart';
import 'package:explaino/features/auth/forgot_password/presentation/screens/forgot_password_screen.dart';
import 'package:explaino/features/auth/forgot_password/presentation/screens/otp_verification_screen.dart';
import 'package:explaino/features/auth/forgot_password/presentation/screens/reset_password_screen.dart';
import 'package:explaino/features/auth/login/presentation/screens/login_screen.dart';
import 'package:explaino/features/auth/register/presentation/screens/register_screen.dart';
import 'package:explaino/features/main/presentation/screens/main_screen.dart';
import 'package:explaino/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/response/schedule_meeting_response_entity.dart';
import 'package:explaino/features/schedule_meeting/presentation/screens/schedule_meeting_screen.dart';
import 'package:explaino/features/splash/presentation/screens/splash_screen.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/screens/add_posts_questions_certificates_screen.dart';
import 'package:explaino/features/tabs/chatbot/presentation/screens/chat_bot_screen.dart';
import 'package:explaino/features/tabs/meetings/presentation/screens/meeting_confirmed_screen.dart';
import 'package:explaino/features/tabs/profile/edit_profile/presentation/screens/edit_profile_image_screen.dart';
import 'package:explaino/features/tabs/profile/edit_profile/presentation/screens/edit_profile_screen.dart';
import 'package:explaino/features/post_action/presentation/screens/post_details.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: AppRoutesConstants.splashRoute,
    routes: [
      GoRoute(
        path: AppRoutesConstants.splashRoute,
        name: AppRoutesConstants.splashRoute,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.onBoardingRoute,
        name: AppRoutesConstants.onBoardingRoute,
        builder: (context, state) => const OnBoardingScreen(),
      ),
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
      GoRoute(
        path: AppRoutesConstants.addPostsQuestionsCertificatesRoute,
        name: AppRoutesConstants.addPostsQuestionsCertificatesRoute,
        builder: (context, state) =>
            const AddPostsQuestionsCertificatesScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.editProfileImageRoute,
        name: AppRoutesConstants.editProfileImageRoute,
        builder: (context, state) =>
            EditProfileImageScreen(imageUrl: state.extra as String? ?? ''),
      ),
      GoRoute(
        path: AppRoutesConstants.editProfileRoute,
        name: AppRoutesConstants.editProfileRoute,
        builder: (context, state) =>
            EditProfileScreen(user: state.extra as UserEntity),
      ),
      GoRoute(
        path: AppRoutesConstants.addAnswerRoute,
        name: AppRoutesConstants.addAnswerRoute,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          final questionId = data[AppRoutesConstants.questionIdKey] as String;
          final hasQuestion = data[AppRoutesConstants.hasQuestionKey] as bool;

          return AddAnswerScreen(
            questionId: questionId,
            hasQuestion: hasQuestion,
          );
        },
      ),
      GoRoute(
        path: AppRoutesConstants.postDetailsRoute,
        name: AppRoutesConstants.postDetailsRoute,
        builder: (context, state) {
          final postId = state.extra as String;
          return PostDetailsScreen(postId: postId);
        },
      ),
      GoRoute(
        path: AppRoutesConstants.scheduleMeetingRoute,
        name: AppRoutesConstants.scheduleMeetingRoute,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          final id = data[AppRoutesConstants.idKey] as String;
          final authorName = data[AppRoutesConstants.authorNameKey] as String;

          return ScheduleMeetingScreen(id: id, authorName: authorName);
        },
      ),
      GoRoute(
        path: AppRoutesConstants.meetingConfirmedRoute,
        name: AppRoutesConstants.meetingConfirmedRoute,
        builder: (context, state) {
          final meeting = state.extra as ScheduleMeetingResponseEntity;

          return MeetingConfirmedScreen(meeting: meeting);
        },
      ),
      GoRoute(
        path: AppRoutesConstants.chatbotRoute,
        name: AppRoutesConstants.chatbotRoute,
        builder: (context, state) => const ChatBotScreen(),
      ),
    ],
  );
}

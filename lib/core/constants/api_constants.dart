class ApiConstants {
  ApiConstants._();
  //====================Headers============================
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer';
  //====================Keys============================
  static const String refreshTokenKey = 'refreshToken';
  static const String accessTokenKey = 'accessToken';
  //==================== Base URL============================
  static const String baseUrl =
      'https://xbrain-backend-chbfe7hscpbqergn.francecentral-01.azurewebsites.net/api/';
  //==================== Auth============================
  static const String login = 'auth/login/';
  static const String register = 'auth/register/';
  static const String forgotPassword = 'auth/forgot-password/';
  static const String resetPassword = 'auth/reset-password/';
  static const String verifyEmail = 'auth/verify-email/';
  static const String refreshToken = 'auth/token/refresh/';
  static const String resendOtp = 'auth/resend-otp/';
  static const String verifyResetOtp = 'auth/verify-reset-otp/';
}

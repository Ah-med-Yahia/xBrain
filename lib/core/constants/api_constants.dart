class ApiConstants {
  ApiConstants._();
  //====================Headers============================
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer';
  //====================Keys============================
  static const String refreshTokenKey = 'refresh';
  //==================== Base URL============================
  static const String baseUrl =
      'https://xbrain-backend-chbfe7hscpbqergn.francecentral-01.azurewebsites.net/api/';
  //==================== Public Endpoints============================
  static const List<String> publicEndpoints = [
    ApiConstants.login,
    ApiConstants.register,
    ApiConstants.forgotPassword,
    ApiConstants.resetPassword,
    ApiConstants.verifyEmail,
    ApiConstants.refreshToken,
    ApiConstants.resendOtp,
    ApiConstants.verifyResetOtp,
  ];
  //==================== Auth============================
  static const String login = 'auth/login/';
  static const String register = 'auth/register/';
  static const String forgotPassword = 'auth/forgot-password/';
  static const String resetPassword = 'auth/reset-password/';
  static const String verifyEmail = 'auth/verify-email/';
  static const String refreshToken = 'auth/token/refresh/';
  static const String resendOtp = 'auth/resend-otp/';
  static const String verifyResetOtp = 'auth/verify-reset-otp/';
  //==================== Profile============================
  static const String updateProfile = 'users/me/';
  //==================== Specializations============================
  static const String specializations = 'specializations/';
  static const String selectSpecializations = 'users/me/specializations/';
}

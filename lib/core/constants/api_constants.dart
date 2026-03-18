class ApiConstants {
  ApiConstants._();
  static const String baseUrl =
      'https://xbrain-backend-chbfe7hscpbqergn.francecentral-01.azurewebsites.net';
  //==================== Auth============================
  static const String login = '/api/auth/login/';
  static const String register = 'api/v1/auth/register';
  static const String forgotPassword = '/api/auth/forgot-password/';
  static const String resetPassword = '/api/auth/reset-password/';
  static const String verifyResetOtp = '/api/auth/verify-reset-otp/';
}

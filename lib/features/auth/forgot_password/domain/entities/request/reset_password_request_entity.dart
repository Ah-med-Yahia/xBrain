class ResetPasswordRequestEntity {
  final String email;
  final String token;
  final String newPassword;

  ResetPasswordRequestEntity({
    required this.email,
    required this.token,
    required this.newPassword,
  });
}

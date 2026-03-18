class RegisterRequestEntity {
  final String email;
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String? bio;
  final String? profileImage;

  RegisterRequestEntity({
    required this.email,
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.bio,
    this.profileImage,
  });
}

class SetupProfileUIModel {
  final String firstName;
  final String lastName;
  final String userName;
  final String phoneNumber;
  final String password;
  final String confirmPassword;

  const SetupProfileUIModel({
    this.firstName = '',
    this.lastName = '',
    this.userName = '',
    this.phoneNumber = '',
    this.password = '',
    this.confirmPassword = '',
  });

  SetupProfileUIModel copyWith({
    String? firstName,
    String? lastName,
    String? userName,
    String? phoneNumber,
    String? password,
    String? confirmPassword,
  }) {
    return SetupProfileUIModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }
}

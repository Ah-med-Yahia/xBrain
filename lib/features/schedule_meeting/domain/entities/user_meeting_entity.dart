class UserMeetingEntity {
  final String id;
  final String username;
  final String firstName;
  final String lastName;
  final String? profileImageUrl;

  const UserMeetingEntity({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    this.profileImageUrl,
  });
}

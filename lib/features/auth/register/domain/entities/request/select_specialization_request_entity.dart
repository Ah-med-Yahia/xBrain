class SelectSpecializationRequestEntity {
  final List<String> specializationIds;
  final bool skip;

  SelectSpecializationRequestEntity({
    required this.specializationIds,
    this.skip = false,
  });
}

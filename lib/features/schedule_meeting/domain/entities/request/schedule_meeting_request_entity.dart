class ScheduleMeetingRequestEntity {
  final int durationMinutes;
  final List<String> proposedSlots;
  final String? message;

  ScheduleMeetingRequestEntity({
    required this.durationMinutes,
    required this.proposedSlots,
    this.message,
  });
}

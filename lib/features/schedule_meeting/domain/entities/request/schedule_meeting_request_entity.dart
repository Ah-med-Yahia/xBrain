class ScheduleMeetingRequestEntity {
  final int durationMinutes;
  final List<DateTime> proposedSlots;
  final String? message;

  ScheduleMeetingRequestEntity({
    required this.durationMinutes,
    required this.proposedSlots,
    this.message,
  });
}

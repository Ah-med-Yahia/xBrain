import 'package:explaino/features/schedule_meeting/domain/entities/request/schedule_meeting_request_entity.dart';

sealed class ScheduleMettingIntents {
  const ScheduleMettingIntents();
}

class ScheduleMettingIntent extends ScheduleMettingIntents {
  final ScheduleMeetingRequestEntity scheduleMeetingRequestEntity;
  const ScheduleMettingIntent({required this.scheduleMeetingRequestEntity});
}

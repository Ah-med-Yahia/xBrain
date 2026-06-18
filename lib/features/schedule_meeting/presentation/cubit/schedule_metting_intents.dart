import 'package:explaino/features/schedule_meeting/domain/entities/request/schedule_meeting_request_entity.dart';

sealed class ScheduleMettingIntents {}

class ScheduleMettingIntent extends ScheduleMettingIntents {
  final String id;
  final ScheduleMeetingRequestEntity scheduleMeetingRequestEntity;
  ScheduleMettingIntent({
    required this.id,
    required this.scheduleMeetingRequestEntity,
  });
}

class AddSlotIntent extends ScheduleMettingIntents {
  final DateTime slot;
  AddSlotIntent({required this.slot});
}

class RemoveSlotIntent extends ScheduleMettingIntents {
  final int index;
  RemoveSlotIntent({required this.index});
}

class SelectDurationIntent extends ScheduleMettingIntents {
  final int duration;
  SelectDurationIntent({required this.duration});
}

class MessageChangedIntent extends ScheduleMettingIntents {
  final String message;
  MessageChangedIntent({required this.message});
}

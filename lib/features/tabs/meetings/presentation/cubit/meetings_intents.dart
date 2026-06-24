import 'package:explaino/features/tabs/meetings/domain/entities/request/accept_meeting_request_entity.dart';
import 'package:explaino/features/tabs/meetings/domain/entities/request/decline_meeting_request_entity.dart';

sealed class MeetingsIntent {}

class CancelMeetingIntent extends MeetingsIntent {
  final String id;

  CancelMeetingIntent({required this.id});
}

class AcceptMyMeetingsIntent extends MeetingsIntent {
  final String id;
  final AcceptMeetingRequestEntity acceptMeetingRequestEntity;

  AcceptMyMeetingsIntent({
    required this.id,
    required this.acceptMeetingRequestEntity,
  });
}

class DeclineMyMeetingsIntent extends MeetingsIntent {
  final String id;
  final DeclineMeetingRequestEntity declineMeetingRequestEntity;

  DeclineMyMeetingsIntent({
    required this.id,
    required this.declineMeetingRequestEntity,
  });
}

class GetOutgoingMeetingsIntent extends MeetingsIntent {}

class GetIncomingMeetingsIntent extends MeetingsIntent {}

class GetSingleMeetingDetailsIntent extends MeetingsIntent {
  final String id;

  GetSingleMeetingDetailsIntent({required this.id});
}

class IncomingMeetingsChangedIntent extends MeetingsIntent {
  final bool incomingSelected;
  IncomingMeetingsChangedIntent({required this.incomingSelected});
}

class SelectMeetingSlotIntent extends MeetingsIntent {
  final DateTime slot;
  SelectMeetingSlotIntent({required this.slot});
}

class DeclineMessageLengthChangedIntent extends MeetingsIntent {
  final int length;
  DeclineMessageLengthChangedIntent({required this.length});
}

class RefreshOutGoingMeetingsIntent extends MeetingsIntent {}

class RefreshIncomingMeetingsIntent extends MeetingsIntent {}

sealed class MeetingsIntent {}

class CancelMeetingIntent extends MeetingsIntent {
  final String id;

  CancelMeetingIntent({required this.id});
}

class AcceptMyMeetingsIntent extends MeetingsIntent {
  final String id;
  final String createdAt;
  AcceptMyMeetingsIntent({required this.id, required this.createdAt});
}

class DeclineMyMeetingsIntent extends MeetingsIntent {
  final String id;
  final String message;

  DeclineMyMeetingsIntent({required this.id, required this.message});
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

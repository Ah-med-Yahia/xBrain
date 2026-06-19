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

class GetOutgoingMeetingsIntent extends MeetingsIntent {
  final String id;

  GetOutgoingMeetingsIntent({required this.id});
}

class GetIncomingMeetingsIntent extends MeetingsIntent {
  final String id;

  GetIncomingMeetingsIntent({required this.id});
}

class GetSingleMeetingDetailsIntent extends MeetingsIntent {
  final String id;

  GetSingleMeetingDetailsIntent({required this.id});
}

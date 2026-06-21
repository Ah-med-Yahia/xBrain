import 'package:explaino/features/schedule_meeting/domain/entities/response/schedule_meeting_response_entity.dart';

sealed class MeetingsSideEffect {}

class ShowError extends MeetingsSideEffect {
  final String message;

  ShowError(this.message);
}

class ShowLoading extends MeetingsSideEffect {}

class HideLoading extends MeetingsSideEffect {}

class ShowSuccessMessage extends MeetingsSideEffect {
  final String message;

  ShowSuccessMessage(this.message);
}

class NavigateToMeetingConfirmed extends MeetingsSideEffect {
  final ScheduleMeetingResponseEntity meeting;

  NavigateToMeetingConfirmed(this.meeting);
}

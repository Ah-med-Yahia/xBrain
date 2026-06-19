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

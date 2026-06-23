sealed class ScheduleMettingSideEffect {}

class ShowError extends ScheduleMettingSideEffect {
  final String message;

  ShowError(this.message);
}

class ShowLoading extends ScheduleMettingSideEffect {}

class HideLoading extends ScheduleMettingSideEffect {}

class ShowSuccessMessage extends ScheduleMettingSideEffect {
  final String message;

  ShowSuccessMessage(this.message);
}

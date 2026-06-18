import 'package:equatable/equatable.dart';
import 'package:explaino/config/base_state/base_state.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/response/schedule_meeting_response_entity.dart';

class ScheduleMeetingState extends Equatable {
  final BaseState<ScheduleMeetingResponseEntity> scheduleMeetingState;
  final List<DateTime> slots;
  final int durationMinutes;
  final int messageLength;
  const ScheduleMeetingState({
    this.scheduleMeetingState =
        const BaseState<ScheduleMeetingResponseEntity>(),
    this.slots = const [],
    this.durationMinutes = 15,
    this.messageLength = 0,
  });

  ScheduleMeetingState copyWith({
    BaseState<ScheduleMeetingResponseEntity>? scheduleMeetingState,
    List<DateTime>? slots,
    int? durationMinutes,
    int? messageLength,
  }) {
    return ScheduleMeetingState(
      scheduleMeetingState: scheduleMeetingState ?? this.scheduleMeetingState,
      slots: slots ?? this.slots,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      messageLength: messageLength ?? this.messageLength,
    );
  }

  @override
  List<Object?> get props => [
    scheduleMeetingState,
    slots,
    durationMinutes,
    messageLength,
  ];
}

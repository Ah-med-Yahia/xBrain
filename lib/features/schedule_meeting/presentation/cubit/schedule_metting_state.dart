import 'package:equatable/equatable.dart';
import 'package:explaino/config/base_state/base_state.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/request/schedule_meeting_response_entity.dart';

class ScheduleMeetingState extends Equatable {
  final BaseState<ScheduleMeetingResponseEntity> scheduleMeetingState;

  const ScheduleMeetingState({
    this.scheduleMeetingState =
        const BaseState<ScheduleMeetingResponseEntity>(),
  });

  ScheduleMeetingState copyWith({
    BaseState<ScheduleMeetingResponseEntity>? scheduleMeetingState,
  }) {
    return ScheduleMeetingState(
      scheduleMeetingState: scheduleMeetingState ?? this.scheduleMeetingState,
    );
  }

  @override
  List<Object?> get props => [scheduleMeetingState];
}

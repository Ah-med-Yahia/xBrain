import 'package:equatable/equatable.dart';
import 'package:explaino/config/base_state/base_state.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/response/schedule_meeting_response_entity.dart';
import 'package:explaino/features/tabs/meetings/domain/entities/response/meetings_response_entity.dart';

class MeetingsState extends Equatable {
  final BaseState<ScheduleMeetingResponseEntity> cancelMeetingstate;
  final BaseState<ScheduleMeetingResponseEntity> acceptMyMeetingsState;
  final BaseState<ScheduleMeetingResponseEntity> declineMyMeetingsState;
  final BaseState<MeetingsResponseEntity> getOutgoingMeetingsState;
  final BaseState<MeetingsResponseEntity> getIncomingMeetingsState;
  final BaseState<ScheduleMeetingResponseEntity> getSingleMeetingDetailsState;

  const MeetingsState({
    this.cancelMeetingstate = const BaseState<ScheduleMeetingResponseEntity>(),
    this.acceptMyMeetingsState =
        const BaseState<ScheduleMeetingResponseEntity>(),
    this.declineMyMeetingsState =
        const BaseState<ScheduleMeetingResponseEntity>(),
    this.getOutgoingMeetingsState = const BaseState<MeetingsResponseEntity>(),
    this.getIncomingMeetingsState = const BaseState<MeetingsResponseEntity>(),
    this.getSingleMeetingDetailsState =
        const BaseState<ScheduleMeetingResponseEntity>(),
  });

  MeetingsState copyWith({
    BaseState<ScheduleMeetingResponseEntity>? cancelMeetingstate,
    BaseState<ScheduleMeetingResponseEntity>? acceptMyMeetingsState,
    BaseState<ScheduleMeetingResponseEntity>? declineMyMeetingsState,
    BaseState<MeetingsResponseEntity>? getOutgoingMeetingsState,
    BaseState<MeetingsResponseEntity>? getIncomingMeetingsState,
    BaseState<ScheduleMeetingResponseEntity>? getSingleMeetingDetailsState,
  }) {
    return MeetingsState(
      cancelMeetingstate: cancelMeetingstate ?? this.cancelMeetingstate,
      acceptMyMeetingsState:
          acceptMyMeetingsState ?? this.acceptMyMeetingsState,
      declineMyMeetingsState:
          declineMyMeetingsState ?? this.declineMyMeetingsState,
      getOutgoingMeetingsState:
          getOutgoingMeetingsState ?? this.getOutgoingMeetingsState,
      getIncomingMeetingsState:
          getIncomingMeetingsState ?? this.getIncomingMeetingsState,
      getSingleMeetingDetailsState:
          getSingleMeetingDetailsState ?? this.getSingleMeetingDetailsState,
    );
  }

  @override
  List<Object?> get props => [
    cancelMeetingstate,
    acceptMyMeetingsState,
    declineMyMeetingsState,
    getOutgoingMeetingsState,
    getIncomingMeetingsState,
    getSingleMeetingDetailsState,
  ];
}

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
  final bool incomingSelected;
  final int incomingCurrentPage;
  final bool incomingHasMore;
  final int outgoingCurrentPage;
  final bool outgoingHasMore;

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
    this.incomingSelected = true,
    this.incomingCurrentPage = 1,
    this.incomingHasMore = true,
    this.outgoingCurrentPage = 1,
    this.outgoingHasMore = true,
  });

  MeetingsState copyWith({
    BaseState<ScheduleMeetingResponseEntity>? cancelMeetingstate,
    BaseState<ScheduleMeetingResponseEntity>? acceptMyMeetingsState,
    BaseState<ScheduleMeetingResponseEntity>? declineMyMeetingsState,
    BaseState<MeetingsResponseEntity>? getOutgoingMeetingsState,
    BaseState<MeetingsResponseEntity>? getIncomingMeetingsState,
    BaseState<ScheduleMeetingResponseEntity>? getSingleMeetingDetailsState,
    bool? incomingSelected,
    int? incomingCurrentPage,
    bool? incomingHasMore,
    int? outgoingCurrentPage,
    bool? outgoingHasMore,
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
      incomingSelected: incomingSelected ?? this.incomingSelected,
      incomingCurrentPage: incomingCurrentPage ?? this.incomingCurrentPage,
      incomingHasMore: incomingHasMore ?? this.incomingHasMore,
      outgoingCurrentPage: outgoingCurrentPage ?? this.outgoingCurrentPage,
      outgoingHasMore: outgoingHasMore ?? this.outgoingHasMore,
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
    incomingSelected,
    incomingCurrentPage,
    incomingHasMore,
    outgoingCurrentPage,
    outgoingHasMore,
  ];
}

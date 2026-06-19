import 'dart:async';

import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/tabs/meetings/domain/usecase/accept_meeting_use_case.dart';
import 'package:explaino/features/tabs/meetings/domain/usecase/cancel_meeting_use_case.dart';
import 'package:explaino/features/tabs/meetings/domain/usecase/decline_meeting_use_case.dart';
import 'package:explaino/features/tabs/meetings/domain/usecase/get_incoming_meetings_use_case.dart';
import 'package:explaino/features/tabs/meetings/domain/usecase/get_outgoing_meetings_use_case.dart';
import 'package:explaino/features/tabs/meetings/domain/usecase/get_single_meeting_details_use_case.dart';
import 'package:explaino/features/tabs/meetings/presentation/cubit/meetings_intents.dart';
import 'package:explaino/features/tabs/meetings/presentation/cubit/meetings_side_effects.dart';
import 'package:explaino/features/tabs/meetings/presentation/cubit/meetings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeetingsCubit extends Cubit<MeetingsState> {
  final CancelMeetingUseCase _cancelMeetingUseCase;
  final AcceptMeetingUseCase _acceptMeetingUseCase;
  final DeclineMeetingUseCase _declineMeetingUseCase;
  final GetIncomingMeetingsUseCase _getIncomingMeetingsUseCase;
  final GetOutgoingMeetingsUseCase _getOutgoingMeetingsUseCase;
  final GetSingleMeetingDetailsUseCase _getSingleMeetingDetailsUseCase;
  final _sideEffectController =
      StreamController<MeetingsSideEffect>.broadcast();
  Stream<MeetingsSideEffect> get sideEffects => _sideEffectController.stream;

  MeetingsCubit({
    required CancelMeetingUseCase cancelMeetingUseCase,
    required AcceptMeetingUseCase acceptMeetingUseCase,
    required DeclineMeetingUseCase declineMeetingUseCase,
    required GetIncomingMeetingsUseCase getIncomingMeetingsUseCase,
    required GetOutgoingMeetingsUseCase getOutgoingMeetingsUseCase,
    required GetSingleMeetingDetailsUseCase getSingleMeetingDetailsUseCase,
  }) : _cancelMeetingUseCase = cancelMeetingUseCase,
       _acceptMeetingUseCase = acceptMeetingUseCase,
       _declineMeetingUseCase = declineMeetingUseCase,
       _getIncomingMeetingsUseCase = getIncomingMeetingsUseCase,
       _getOutgoingMeetingsUseCase = getOutgoingMeetingsUseCase,
       _getSingleMeetingDetailsUseCase = getSingleMeetingDetailsUseCase,
       super(const MeetingsState());

  void doIntent(MeetingsIntent intent) {
    switch (intent) {
      case CancelMeetingIntent(id: final id):
        _handleCancelMeetingIntent(id);
        break;
      case AcceptMyMeetingsIntent(id: final id, createdAt: final createdAt):
        _handleAcceptMyMeetingsIntent(id, createdAt);
        break;
      case DeclineMyMeetingsIntent(id: final id, message: final message):
        _handleDeclineMyMeetingsIntent(id, message);
        break;
      case GetOutgoingMeetingsIntent():
        _handleGetOutgoingMeetingsIntent();
        break;
      case GetIncomingMeetingsIntent():
        _handleGetIncomingMeetingsIntent();
        break;
      case GetSingleMeetingDetailsIntent(id: final id):
        _handleGetSingleMeetingDetailsIntent(id);
        break;
    }
  }

  void _handleCancelMeetingIntent(String id) async {
    _sideEffectController.add(HideLoading());
    final result = await _cancelMeetingUseCase.call(id);
    result.when(
      success: (data) {
        _sideEffectController.add(
          ShowSuccessMessage('Meeting Cancelled Successfully'),
        );
      },
      failure: (failure) =>
          _sideEffectController.add(ShowError(failure.message)),
    );
  }

  void _handleAcceptMyMeetingsIntent(String id, String createdAt) async {
    final result = await _acceptMeetingUseCase.call(id, createdAt);
    result.when(
      success: (data) {
        _sideEffectController.add(
          ShowSuccessMessage('Meeting Accepted Successfully'),
        );
      },
      failure: (failure) =>
          _sideEffectController.add(ShowError(failure.message)),
    );
  }

  void _handleDeclineMyMeetingsIntent(String id, String message) async {
    final result = await _declineMeetingUseCase.call(id, message);
    result.when(
      success: (data) {
        _sideEffectController.add(
          ShowSuccessMessage('Meeting Declined Successfully'),
        );
      },
      failure: (failure) =>
          _sideEffectController.add(ShowError(failure.message)),
    );
  }

  void _handleGetOutgoingMeetingsIntent() async {
    emit(
      state.copyWith(
        getOutgoingMeetingsState: state.getOutgoingMeetingsState.copyWith(
          isFetching: true,
          errorMessage: null,
        ),
      ),
    );
    final result = await _getOutgoingMeetingsUseCase.call();
    result.when(
      success: (data) {
        emit(
          state.copyWith(
            getOutgoingMeetingsState: state.getOutgoingMeetingsState.copyWith(
              isFetching: false,
              data: data,
            ),
          ),
        );
      },
      failure: (failure) => emit(
        state.copyWith(
          getOutgoingMeetingsState: state.getOutgoingMeetingsState.copyWith(
            isFetching: false,
            errorMessage: failure.message,
          ),
        ),
      ),
    );
  }

  void _handleGetIncomingMeetingsIntent() async {
    emit(
      state.copyWith(
        getIncomingMeetingsState: state.getIncomingMeetingsState.copyWith(
          isFetching: true,
          errorMessage: null,
        ),
      ),
    );
    final result = await _getIncomingMeetingsUseCase.call();
    result.when(
      success: (data) {
        emit(
          state.copyWith(
            getIncomingMeetingsState: state.getIncomingMeetingsState.copyWith(
              isFetching: false,
              data: data,
            ),
          ),
        );
      },
      failure: (failure) => emit(
        state.copyWith(
          getIncomingMeetingsState: state.getIncomingMeetingsState.copyWith(
            isFetching: false,
            errorMessage: failure.message,
          ),
        ),
      ),
    );
  }

  void _handleGetSingleMeetingDetailsIntent(String id) async {
    emit(
      state.copyWith(
        getSingleMeetingDetailsState: state.getSingleMeetingDetailsState
            .copyWith(isFetching: true, errorMessage: null),
      ),
    );
    final result = await _getSingleMeetingDetailsUseCase.call(id);
    result.when(
      success: (data) {
        emit(
          state.copyWith(
            getSingleMeetingDetailsState: state.getSingleMeetingDetailsState
                .copyWith(isFetching: false, data: data),
          ),
        );
      },
      failure: (failure) => emit(
        state.copyWith(
          getSingleMeetingDetailsState: state.getSingleMeetingDetailsState
              .copyWith(isFetching: false, errorMessage: failure.message),
        ),
      ),
    );
  }
}

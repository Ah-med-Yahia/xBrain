import 'dart:async';
import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/features/tabs/meetings/domain/entities/request/accept_meeting_request_entity.dart';
import 'package:explaino/features/tabs/meetings/domain/entities/request/decline_meeting_request_entity.dart';
import 'package:explaino/features/tabs/meetings/domain/entities/response/meetings_response_entity.dart';
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
import 'package:injectable/injectable.dart';

@injectable
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
      case AcceptMyMeetingsIntent(
        id: final id,
        acceptMeetingRequestEntity: final acceptMeetingRequestEntity,
      ):
        _handleAcceptMyMeetingsIntent(id, acceptMeetingRequestEntity);
        break;
      case DeclineMyMeetingsIntent(
        id: final id,
        declineMeetingRequestEntity: final declineMeetingRequestEntity,
      ):
        _handleDeclineMyMeetingsIntent(id, declineMeetingRequestEntity);
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
      case IncomingMeetingsChangedIntent(
        incomingSelected: final incomingSelected,
      ):
        _handleTabChangedIntent(incomingSelected);
        break;
      case SelectMeetingSlotIntent(slot: final slot):
        _handleSelectMeetingSlotIntent(slot);
        break;
    }
  }

  void _handleCancelMeetingIntent(String id) async {
    _sideEffectController.add(ShowLoading());
    final result = await _cancelMeetingUseCase.call(id);
    result.when(
      success: (data) {
        _sideEffectController.add(HideLoading());
        _sideEffectController.add(
          ShowSuccessMessage(AppTextConstants.meetingCancelledSuccessfully),
        );
        _refreshOutgoingMeetings();
      },
      failure: (failure) {
        _sideEffectController.add(HideLoading());
        _sideEffectController.add(ShowError(failure.message));
      },
    );
  }

  void _handleAcceptMyMeetingsIntent(
    String id,
    AcceptMeetingRequestEntity acceptMeetingRequestEntity,
  ) async {
    _sideEffectController.add(ShowLoading());
    final result = await _acceptMeetingUseCase.call(
      id,
      acceptMeetingRequestEntity,
    );
    result.when(
      success: (data) {
        _sideEffectController.add(HideLoading());
        _sideEffectController.add(
          ShowSuccessMessage(AppTextConstants.meetingAcceptedSuccessfully),
        );
        _refreshIncomingMeetings();
        _sideEffectController.add(NavigateToMeetingConfirmed(data));
      },
      failure: (failure) {
        _sideEffectController.add(HideLoading());
        _sideEffectController.add(ShowError(failure.message));
      },
    );
  }

  void _handleDeclineMyMeetingsIntent(
    String id,
    DeclineMeetingRequestEntity request,
  ) async {
    _sideEffectController.add(ShowLoading());
    final result = await _declineMeetingUseCase.call(id, request);
    result.when(
      success: (data) {
        _sideEffectController.add(HideLoading());
        _sideEffectController.add(
          ShowSuccessMessage(AppTextConstants.meetingDeclinedSuccessfully),
        );
        _refreshIncomingMeetings();
      },
      failure: (failure) {
        _sideEffectController.add(HideLoading());
        _sideEffectController.add(ShowError(failure.message));
      },
    );
  }

  void _handleGetOutgoingMeetingsIntent() async {
    if (state.getOutgoingMeetingsState.isFetching || !state.outgoingHasMore) {
      return;
    }

    emit(
      state.copyWith(
        getOutgoingMeetingsState: state.getOutgoingMeetingsState.copyWith(
          isFetching: true,
          errorMessage: null,
        ),
      ),
    );
    final result = await _getOutgoingMeetingsUseCase.call(
      page: state.outgoingCurrentPage,
    );
    result.when(
      success: (data) {
        final existingResults =
            state.getOutgoingMeetingsState.data?.results ?? [];
        final updatedData = MeetingsResponseEntity(
          count: data.count,
          next: data.next,
          previous: data.previous,
          results: [...existingResults, ...data.results],
        );
        emit(
          state.copyWith(
            getOutgoingMeetingsState: state.getOutgoingMeetingsState.copyWith(
              isFetching: false,
              data: updatedData,
            ),
            outgoingCurrentPage: state.outgoingCurrentPage + 1,
            outgoingHasMore: data.next != null,
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
    if (state.getIncomingMeetingsState.isFetching || !state.incomingHasMore) {
      return;
    }

    emit(
      state.copyWith(
        getIncomingMeetingsState: state.getIncomingMeetingsState.copyWith(
          isFetching: true,
          errorMessage: null,
        ),
      ),
    );
    final result = await _getIncomingMeetingsUseCase.call(
      page: state.incomingCurrentPage,
    );
    result.when(
      success: (data) {
        final existingResults =
            state.getIncomingMeetingsState.data?.results ?? [];
        final updatedData = MeetingsResponseEntity(
          count: data.count,
          next: data.next,
          previous: data.previous,
          results: [...existingResults, ...data.results],
        );
        emit(
          state.copyWith(
            getIncomingMeetingsState: state.getIncomingMeetingsState.copyWith(
              isFetching: false,
              data: updatedData,
            ),
            incomingCurrentPage: state.incomingCurrentPage + 1,
            incomingHasMore: data.next != null,
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

  void _handleTabChangedIntent(bool incomingSelected) {
    emit(state.copyWith(incomingSelected: incomingSelected));
    if (!incomingSelected) {
      doIntent(GetOutgoingMeetingsIntent());
    }
  }

  void _refreshIncomingMeetings() async {
    emit(
      state.copyWith(
        incomingCurrentPage: 1,
        incomingHasMore: true,
        getIncomingMeetingsState: state.getIncomingMeetingsState.copyWith(
          data: null,
          isFetching: true,
          errorMessage: null,
        ),
      ),
    );

    final result = await _getIncomingMeetingsUseCase.call(page: 1);

    result.when(
      success: (data) {
        emit(
          state.copyWith(
            getIncomingMeetingsState: state.getIncomingMeetingsState.copyWith(
              isFetching: false,
              data: data,
            ),
            incomingCurrentPage: 2,
            incomingHasMore: data.next != null,
          ),
        );
      },
      failure: (failure) {
        emit(
          state.copyWith(
            getIncomingMeetingsState: state.getIncomingMeetingsState.copyWith(
              isFetching: false,
              errorMessage: failure.message,
            ),
          ),
        );
      },
    );
  }

  void _refreshOutgoingMeetings() async {
    emit(
      state.copyWith(
        outgoingCurrentPage: 1,
        outgoingHasMore: true,
        getOutgoingMeetingsState: state.getOutgoingMeetingsState.copyWith(
          data: null,
          isFetching: true,
          errorMessage: null,
        ),
      ),
    );

    final result = await _getOutgoingMeetingsUseCase.call(page: 1);

    result.when(
      success: (data) {
        emit(
          state.copyWith(
            getOutgoingMeetingsState: state.getOutgoingMeetingsState.copyWith(
              isFetching: false,
              data: data,
            ),
            outgoingCurrentPage: 2,
            outgoingHasMore: data.next != null,
          ),
        );
      },
      failure: (failure) {
        emit(
          state.copyWith(
            getOutgoingMeetingsState: state.getOutgoingMeetingsState.copyWith(
              isFetching: false,
              errorMessage: failure.message,
            ),
          ),
        );
      },
    );
  }

  void _handleSelectMeetingSlotIntent(DateTime slot) {
    emit(state.copyWith(selectedSlot: slot));
  }
}

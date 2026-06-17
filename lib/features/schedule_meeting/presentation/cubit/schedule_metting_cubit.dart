import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/request/schedule_meeting_request_entity.dart';
import 'package:explaino/features/schedule_meeting/domain/usecase/schedule_meeting_use_case.dart';
import 'package:explaino/features/schedule_meeting/presentation/cubit/schedule_metting_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ScheduleMeetingCubit extends Cubit<ScheduleMeetingState> {
  final ScheduleMeetingUseCase _scheduleMeetingUseCase;

  ScheduleMeetingCubit({required ScheduleMeetingUseCase scheduleMeetingUseCase})
    : _scheduleMeetingUseCase = scheduleMeetingUseCase,
      super(const ScheduleMeetingState());

  Future<void> scheduleMeeting(ScheduleMeetingRequestEntity request) async {
    emit(
      state.copyWith(
        scheduleMeetingState: state.scheduleMeetingState.copyWith(
          isFetching: true,
          errorMessage: null,
        ),
      ),
    );

    final result = await _scheduleMeetingUseCase(request);

    result.when(
      success: (data) {
        emit(
          state.copyWith(
            scheduleMeetingState: state.scheduleMeetingState.copyWith(
              isFetching: false,
              data: data,
            ),
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            scheduleMeetingState: state.scheduleMeetingState.copyWith(
              isFetching: false,
              errorMessage: error.message,
            ),
          ),
        );
      },
    );
  }
}

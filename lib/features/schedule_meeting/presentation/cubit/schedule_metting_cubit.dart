import 'dart:async';

import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/request/schedule_meeting_request_entity.dart';
import 'package:explaino/features/schedule_meeting/domain/usecase/schedule_meeting_use_case.dart';
import 'package:explaino/features/schedule_meeting/presentation/cubit/schedule_metting_intents.dart';
import 'package:explaino/features/schedule_meeting/presentation/cubit/schedule_metting_side_effects.dart';
import 'package:explaino/features/schedule_meeting/presentation/cubit/schedule_metting_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ScheduleMeetingCubit extends Cubit<ScheduleMeetingState> {
  final ScheduleMeetingUseCase _scheduleMeetingUseCase;
  final _sideEffectController =
      StreamController<ScheduleMettingSideEffect>.broadcast();
  Stream<ScheduleMettingSideEffect> get sideEffects =>
      _sideEffectController.stream;

  ScheduleMeetingCubit({required ScheduleMeetingUseCase scheduleMeetingUseCase})
    : _scheduleMeetingUseCase = scheduleMeetingUseCase,
      super(const ScheduleMeetingState());

  void doIntent(ScheduleMettingIntents intent) {
    switch (intent) {
      case ScheduleMettingIntent(
        id: final id,
        scheduleMeetingRequestEntity: final scheduleMeetingRequestEntity,
      ):
        _scheduleMeeting(id, scheduleMeetingRequestEntity);
        break;
      case AddSlotIntent(slot: final slot):
        _onAddSlot(slot);
        break;
      case RemoveSlotIntent(index: final index):
        _onRemoveSlot(index);
        break;
      case SelectDurationIntent(duration: final duration):
        _onSelectDuration(duration);
        break;
      case MessageChangedIntent(message: final message):
        _onMessageChanged(message);
        break;
    }
  }

  void _onMessageChanged(String message) {
    emit(state.copyWith(messageLength: message.length));
  }

  void _onSelectDuration(int duration) {
    emit(state.copyWith(durationMinutes: duration));
  }

  void _onAddSlot(DateTime slot) {
    if (state.slots.any((s) => s.isAtSameMomentAs(slot))) return;
    final updated = [...state.slots, slot];
    updated.sort();
    emit(state.copyWith(slots: updated));
  }

  void _onRemoveSlot(int index) {
    final updated = [...state.slots]..removeAt(index);
    emit(state.copyWith(slots: updated));
  }

  Future<void> _scheduleMeeting(
    String id,
    ScheduleMeetingRequestEntity request,
  ) async {
    _sideEffectController.add(ShowLoading());
    final result = await _scheduleMeetingUseCase(id, request);

    result.when(
      success: (data) {
        _sideEffectController.add(HideLoading());
        _sideEffectController.add(
          ShowSuccessMessage(
            '${AppTextConstants.meetingScheduledSuccessfully} ${data.status.name}',
          ),
        );
      },
      failure: (error) {
        _sideEffectController.add(HideLoading());
        _sideEffectController.add(ShowError(error.message));
      },
    );
  }

  @override
  Future<void> close() {
    _sideEffectController.close();
    return super.close();
  }
}

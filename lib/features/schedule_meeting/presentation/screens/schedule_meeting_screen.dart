import 'package:explaino/config/di/di.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/constants/schedule_meeting_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/core/utils/ui_utils.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/request/schedule_meeting_request_entity.dart';
import 'package:explaino/features/schedule_meeting/presentation/cubit/schedule_metting_cubit.dart';
import 'package:explaino/features/schedule_meeting/presentation/cubit/schedule_metting_intents.dart';
import 'package:explaino/features/schedule_meeting/presentation/cubit/schedule_metting_side_effects.dart';
import 'package:explaino/features/schedule_meeting/presentation/cubit/schedule_metting_state.dart';
import 'package:explaino/features/schedule_meeting/presentation/widgets/add_slot_button.dart';
import 'package:explaino/features/schedule_meeting/presentation/widgets/duration_selector.dart';
import 'package:explaino/features/schedule_meeting/presentation/widgets/empty_slot_hint.dart';
import 'package:explaino/features/schedule_meeting/presentation/widgets/message_field.dart';
import 'package:explaino/features/schedule_meeting/presentation/widgets/section_label.dart';
import 'package:explaino/features/schedule_meeting/presentation/widgets/slot_list.dart';
import 'package:explaino/features/schedule_meeting/presentation/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleMeetingScreen extends StatefulWidget {
  final String id;
  const ScheduleMeetingScreen({super.key, required this.id});

  @override
  State<ScheduleMeetingScreen> createState() => _ScheduleMeetingScreenState();
}

class _ScheduleMeetingScreenState extends State<ScheduleMeetingScreen> {
  final TextEditingController _messageCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late ScheduleMeetingCubit _scheduleMeetingCubit;

  @override
  void initState() {
    super.initState();
    _scheduleMeetingCubit = getIt<ScheduleMeetingCubit>();
    _scheduleMeetingCubit.sideEffects.listen((effect) {
      if (!mounted) return;
      switch (effect) {
        case ShowError():
          _handelError(effect.message);
        case ShowLoading():
          _handelLoading();
        case HideLoading():
          _handelHideLoading();
        case ShowSuccessMessage():
          _handelSuccess(effect.message);
      }
    });
  }

  Future<void> _pickSlot(List<DateTime> currentSlots) async {
    final now = DateTime.now();
    final firstDate = now.add(const Duration(hours: 1));
    final lastDate = now.add(const Duration(days: 30));

    final date = await showDatePicker(
      context: context,
      initialDate: firstDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) => _primaryDatePickerTheme(context, child),
    );
    if (date == null || !mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(firstDate),
    );
    if (time == null || !mounted) return;

    final slot = DateTime.utc(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    if (currentSlots.any((s) => s.isAtSameMomentAs(slot))) return;

    _scheduleMeetingCubit.doIntent(AddSlotIntent(slot: slot));
  }

  Widget _primaryDatePickerTheme(BuildContext context, Widget? child) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: AppColors.primary,
          onPrimary: Colors.white,
        ),
      ),
      child: child!,
    );
  }

  void _removeSlot(int index) {
    _scheduleMeetingCubit.doIntent(RemoveSlotIntent(index: index));
  }

  void _submit(List<DateTime> currentSlots, int duration) {
    _scheduleMeetingCubit.doIntent(
      ScheduleMettingIntent(
        id: widget.id,
        scheduleMeetingRequestEntity: ScheduleMeetingRequestEntity(
          durationMinutes: duration,
          proposedSlots: currentSlots,
          message: _messageCtrl.text.trim(),
        ),
      ),
    );
  }

  void _handelLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      UIUtils.showEasyLoading();
    });
  }

  void _handelError(String message) {
    UIUtils.showMessage(
      message,
      backGroundColor: AppColors.error,
      textColor: AppColors.white,
    );
  }

  void _handelHideLoading() {
    UIUtils.hideEasyLoading();
  }

  void _handelSuccess(String message) {
    UIUtils.showMessage(
      message,
      backGroundColor: AppColors.green,
      textColor: AppColors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTextConstants.scheduleAMeeting),
        centerTitle: false,
        foregroundColor: AppColors.primary,
        scrolledUnderElevation: 0,
      ),
      body: BlocProvider(
        create: (_) => _scheduleMeetingCubit,
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            children: [
              const SectionLabel(label: AppTextConstants.duration),
              const SizedBox(height: 8),
              BlocBuilder<ScheduleMeetingCubit, ScheduleMeetingState>(
                buildWhen: (prev, curr) =>
                    prev.durationMinutes != curr.durationMinutes,
                builder: (context, state) {
                  return DurationSelector(
                    durations: ScheduleMeetingConstants.durations,
                    selected: state.durationMinutes,
                    onChanged: (val) => _scheduleMeetingCubit.doIntent(
                      SelectDurationIntent(duration: val),
                    ),
                  );
                },
              ),
              const SizedBox(height: 28),
              const SectionLabel(
                label: AppTextConstants.proposedTimeSlots,
                note: '${ScheduleMeetingConstants.maxSlots}',
              ),
              const SizedBox(height: 8),
              BlocBuilder<ScheduleMeetingCubit, ScheduleMeetingState>(
                buildWhen: (prev, curr) => prev.slots != curr.slots,
                builder: (context, state) {
                  final slots = state.slots;
                  return Column(
                    children: [
                      if (slots.isEmpty)
                        const EmptySlotsHint()
                      else
                        SlotList(slots: slots, onRemove: _removeSlot),
                      const SizedBox(height: 8),
                      if (slots.length < ScheduleMeetingConstants.maxSlots)
                        AddSlotButton(onTap: () => _pickSlot(slots)),
                    ],
                  );
                },
              ),
              const SizedBox(height: 28),
              const SectionLabel(
                label: AppTextConstants.message,
                note: AppTextConstants.optional,
              ),
              const SizedBox(height: 8),
              MessageField(controller: _messageCtrl),
              const SizedBox(height: 32),
              SubmitButton(
                onPressed: () {
                  final slots = _scheduleMeetingCubit.state.slots;

                  final duration = _scheduleMeetingCubit.state.durationMinutes;

                  _submit(slots, duration);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageCtrl.dispose();
    super.dispose();
  }
}

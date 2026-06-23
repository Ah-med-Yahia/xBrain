import 'package:explaino/config/di/di.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/extensions/meeting_status_x.dart';
import 'package:explaino/core/helpers/date_time_helper.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/tabs/meetings/domain/entities/request/accept_meeting_request_entity.dart';
import 'package:explaino/features/tabs/meetings/presentation/cubit/meetings_cubit.dart';
import 'package:explaino/features/tabs/meetings/presentation/cubit/meetings_intents.dart';
import 'package:explaino/features/tabs/meetings/presentation/cubit/meetings_state.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/base_buttom_sheet.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/meeting_card_widgets/glass_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SlotsSelectionSheet extends StatefulWidget {
  final List<DateTime> slots;

  const SlotsSelectionSheet({super.key, required this.slots});

  @override
  State<SlotsSelectionSheet> createState() => _SlotsSelectionSheetState();
}

class _SlotsSelectionSheetState extends State<SlotsSelectionSheet> {
  late final MeetingsCubit _meetingsCubit;
  late final TextTheme textTheme;

  @override
  void initState() {
    super.initState();
    _meetingsCubit = getIt<MeetingsCubit>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    textTheme = Theme.of(context).textTheme;
  }

  void _handleConfirm(DateTime slot) {
    Navigator.pop(context, AcceptMeetingRequestEntity(scheduledAt: slot));
  }

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      icon: Icons.event_available_rounded,
      iconColor: AppColors.primary.withValues(alpha: 0.7),
      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
      title: AppTextConstants.selectAMeetingSlot,
      description: AppTextConstants.chooseSlot,
      children: [_buildSlotsSelection()],
    );
  }

  Widget _buildSlotsSelection() {
    return BlocProvider(
      create: (context) => _meetingsCubit,
      child: BlocBuilder<MeetingsCubit, MeetingsState>(
        buildWhen: (previous, current) =>
            previous.selectedSlot != current.selectedSlot,
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...widget.slots.map((slot) {
                final isSelected = state.selectedSlot == slot;

                return GestureDetector(
                  onTap: () {
                    _meetingsCubit.doIntent(
                      SelectMeetingSlotIntent(slot: slot),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary.withValues(alpha: 0.08)
                          : AppColors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.athensGray,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.event_available_rounded,
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.grey,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            '${slot.dayName}, ${slot.shortDate} at ${slot.time12Hour}',
                            style: textTheme.bodyMedium?.copyWith(
                              fontSize: 15,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.oxdordBlue,
                            ),
                          ),
                        ),
                        if (isSelected)
                          const Icon(
                            Icons.check_circle_rounded,
                            color: AppColors.primary,
                            size: 22,
                          ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 24),
              _buildConfirmButton(state),
              const SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }

  Widget _buildConfirmButton(MeetingsState state) {
    return GlassActionButton(
      label: AppTextConstants.confirmSlot,
      icon: Icons.check_rounded,
      variant: state.selectedSlot == null
          ? ButtonVariant.outline
          : ButtonVariant.filled,
      onTap: () {
        if (state.selectedSlot == null) return;
        _handleConfirm(state.selectedSlot!);
      },
    );
  }
}

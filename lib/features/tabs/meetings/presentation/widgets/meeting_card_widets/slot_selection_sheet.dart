import 'package:explaino/config/di/di.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/extensions/meeting_status_x.dart';
import 'package:explaino/core/helpers/date_time_helper.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/tabs/meetings/presentation/cubit/meetings_cubit.dart';
import 'package:explaino/features/tabs/meetings/presentation/cubit/meetings_intents.dart';
import 'package:explaino/features/tabs/meetings/presentation/cubit/meetings_state.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/meeting_card_widets/glass_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SlotsSelectionSheet extends StatefulWidget {
  final List<DateTime> slots;
  final ValueChanged<DateTime> onSlotSelected;

  const SlotsSelectionSheet({
    super.key,
    required this.slots,
    required this.onSlotSelected,
  });

  @override
  State<SlotsSelectionSheet> createState() => _SlotsSelectionSheetState();
}

class _SlotsSelectionSheetState extends State<SlotsSelectionSheet> {
  late final MeetingsCubit _meetingsCubit;

  @override
  void initState() {
    super.initState();
    _meetingsCubit = getIt<MeetingsCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        24,
        24,
        24 + MediaQuery.of(context).padding.bottom,
      ),
      child: BlocProvider(
        create: (context) => _meetingsCubit,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppTextConstants.selectAMeetingSlot,
              style: textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              AppTextConstants.chooseSlot,
              style: textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),

            BlocBuilder<MeetingsCubit, MeetingsState>(
              buildWhen: (previous, current) =>
                  previous.selectedSlot != current.selectedSlot,
              builder: (context, state) {
                return Column(
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
                            borderRadius: BorderRadius.circular(12),
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
                                ),
                            ],
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 24),
                    GlassActionButton(
                      label: AppTextConstants.confirmSlot,
                      icon: Icons.check_rounded,
                      variant: state.selectedSlot == null
                          ? ButtonVariant.outline
                          : ButtonVariant.filled,
                      onTap: () {
                        if (state.selectedSlot == null) return;
                        widget.onSlotSelected(state.selectedSlot!);
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

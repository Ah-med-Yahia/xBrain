import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/helpers/date_time_helper.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/meeting_card.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/meeting_card_widets/glass_action_button.dart';
import 'package:flutter/material.dart';

class SlotsSelectionSheet extends StatefulWidget {
  final List<DateTime> slots;
  final ValueChanged<DateTime> onSlotSelected;

  const SlotsSelectionSheet({
    super.key,
    required this.slots,
    required this.onSlotSelected,
  });

  @override
  State<SlotsSelectionSheet> createState() => SlotsSelectionSheetState();
}

class SlotsSelectionSheetState extends State<SlotsSelectionSheet> {
  DateTime? _selectedSlot;

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
          ...widget.slots.map((slot) {
            final isSelected = _selectedSlot == slot;
            return GestureDetector(
              onTap: () => setState(() => _selectedSlot = slot),
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
                      color: isSelected ? AppColors.primary : AppColors.grey,
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
            variant: _selectedSlot == null
                ? ButtonVariant.outline
                : ButtonVariant.filled,
            onTap: () {
              if (_selectedSlot != null) {
                widget.onSlotSelected(_selectedSlot!);
              }
            },
          ),
        ],
      ),
    );
  }
}

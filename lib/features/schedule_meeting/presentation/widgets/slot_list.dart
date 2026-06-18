import 'package:explaino/core/helpers/date_time_helper.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SlotList extends StatelessWidget {
  const SlotList({
    super.key,
    required this.slots,
    required this.onRemove,
    required this.onReorder,
  });

  final List<DateTime> slots;
  final void Function(int) onRemove;
  final void Function(int oldIndex, int newIndex) onReorder;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      color: Colors.transparent,
      child: ReorderableListView.builder(
        itemCount: slots.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        onReorder: onReorder,
        buildDefaultDragHandles: false,
        proxyDecorator: (child, index, animation) {
          return Material(
            color: Colors.transparent,
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, childWidget) {
                return Transform.scale(
                  scale: 1.03,
                  child: Opacity(opacity: 0.95, child: childWidget),
                );
              },
              child: child,
            ),
          );
        },
        itemBuilder: (context, i) {
          final slot = slots[i];
          return Material(
            key: ValueKey(slot.toIso8601String()),
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ReorderableDragStartListener(
                index: i,
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.18),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.calendar_today_outlined,
                        size: 18,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            slot.shortDate,
                            style: textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.jetBlack,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            slot.shortDayName,
                            style: textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary.withValues(alpha: 0.65),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.16),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        slot.time12Hour,
                        style: textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => onRemove(i),
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.16),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          size: 14,
                          color: AppColors.primary.withValues(alpha: 0.75),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

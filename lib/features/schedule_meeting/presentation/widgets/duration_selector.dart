import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DurationSelector extends StatelessWidget {
  const DurationSelector({
    super.key,
    required this.durations,
    required this.selected,
    required this.onChanged,
  });

  final List<int> durations;
  final int selected;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Wrap(
      spacing: 8,
      children: durations.map((d) {
        final isSelected = d == selected;
        return ChoiceChip(
          label: Text('$d ${AppTextConstants.minutes}'),
          selected: isSelected,
          onSelected: (_) => onChanged(d),
          selectedColor: AppColors.primary,
          labelStyle: textTheme.bodyMedium?.copyWith(
            color: isSelected ? Colors.white : null,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
          shape: const StadiumBorder(),
          side: BorderSide(
            color: isSelected ? AppColors.primary : AppColors.grayishPurple,
            width: isSelected ? 1.5 : 0.5,
          ),
          backgroundColor: AppColors.white,
          showCheckmark: false,
        );
      }).toList(),
    );
  }
}

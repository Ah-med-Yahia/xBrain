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
    return Wrap(
      spacing: 8,
      children: durations.map((d) {
        final isSelected = d == selected;
        return ChoiceChip(
          label: Text('$d min'),
          selected: isSelected,
          onSelected: (_) => onChanged(d),
          selectedColor: AppColors.primary,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : null,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
          // Full pill shape
          shape: const StadiumBorder(),
          side: BorderSide(
            color: isSelected
                ? AppColors.primary
                : Theme.of(context).colorScheme.outlineVariant,
            width: isSelected ? 1.5 : 0.5,
          ),
          backgroundColor: Colors.white,
          showCheckmark: false,
        );
      }).toList(),
    );
  }
}

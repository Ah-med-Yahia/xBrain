import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AddSpecializationChips extends StatelessWidget {
  const AddSpecializationChips({
    super.key,
    required this.specializations,
    required this.selectedSpecializations,
    required this.onToggle,
  });

  final List<String> specializations;
  final Set<String> selectedSpecializations;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: specializations.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final specialization = specializations[index];
          final isSelected = selectedSpecializations.contains(specialization);

          return ChoiceChip(
            selected: isSelected,
            onSelected: (_) => onToggle(specialization),
            label: Text(specialization),
            labelStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: isSelected ? AppColors.white : AppColors.grey200,
              fontWeight: FontWeight.w700,
            ),
            selectedColor: AppColors.primary,
            backgroundColor: AppColors.shimmerBaseColor,
            showCheckmark: false,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            side: BorderSide.none,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
          );
        },
      ),
    );
  }
}

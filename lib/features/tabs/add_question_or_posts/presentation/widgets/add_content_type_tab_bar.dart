import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/cubit/add_posts_questions_certificates_state.dart';
import 'package:flutter/material.dart';

class AddContentTypeTabBar extends StatelessWidget {
  const AddContentTypeTabBar({
    super.key,
    required this.onChanged,
    required this.selectedType,
  });

  final ValueChanged<AddContentType> onChanged;
  final AddContentType selectedType;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: AddContentType.values.map((type) {
        final isSelected = type == selectedType;
        return Expanded(
          child: InkWell(
            onTap: () => onChanged(type),
            borderRadius: BorderRadius.circular(4),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    type.label,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: isSelected ? AppColors.primary : AppColors.grey,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    height: 3,
                    width: isSelected ? 24 : 0,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

enum AddContentType { question, post, certificate }

extension AddContentTypeX on AddContentType {
  String get label {
    return switch (this) {
      AddContentType.question => 'Question',
      AddContentType.post => 'Post',
      AddContentType.certificate => 'Certificate',
    };
  }

  String get title {
    return switch (this) {
      AddContentType.question => 'New Question',
      AddContentType.post => 'New Post',
      AddContentType.certificate => 'New Certificate',
    };
  }
}

class AddContentTypeTabBar extends StatelessWidget {
  const AddContentTypeTabBar({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  final AddContentType selectedType;
  final ValueChanged<AddContentType> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: AddContentType.values.map((type) {
        final isSelected = type == selectedType;

        return Padding(
          padding: const EdgeInsets.only(right: 28),
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
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
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

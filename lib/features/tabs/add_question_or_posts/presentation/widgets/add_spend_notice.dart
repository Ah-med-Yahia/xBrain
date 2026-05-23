import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AddSpendNotice extends StatelessWidget {
  const AddSpendNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.lightPeriwinkle)),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_rounded, color: AppColors.primary, size: 19),
          const SizedBox(width: 10),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: AppTextConstants.spendNoticePrefix,
                children: [
                  TextSpan(
                    text: AppTextConstants.spendNoticePoints,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const TextSpan(text: AppTextConstants.spendNoticeSuffix),
                ],
              ),
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

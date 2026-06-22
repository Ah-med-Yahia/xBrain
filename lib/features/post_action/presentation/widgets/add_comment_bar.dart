import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AddCommentBar extends StatelessWidget {
  const AddCommentBar({
    super.key,
    required this.commentController,
    required this.commentFocusNode,
    required this.submitComment,
  });
  final TextEditingController commentController;
  final FocusNode commentFocusNode;
  final VoidCallback submitComment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
        top: 10,
        bottom: MediaQuery.of(context).viewInsets.bottom + 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.kLight,
        border: Border(
          top: BorderSide(
            color: AppColors.lightTextSecondary.withValues(alpha: 0.15),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: commentController,
              focusNode: commentFocusNode,
              minLines: 1,
              maxLines: 4,
              onTapOutside: (_) {
                commentFocusNode.unfocus();
              },
              textInputAction: TextInputAction.newline,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.lightTextPrimary,
              ),
              decoration: InputDecoration(
                hintText: AppTextConstants.addComment,
                hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.lightTextSecondary,
                ),
                filled: true,
                fillColor: AppColors.lightTextSecondary.withValues(alpha: 0.08),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(
                    color: AppColors.primary.withValues(alpha: 0.5),
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Material(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(24),
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: submitComment,
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.send_rounded, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

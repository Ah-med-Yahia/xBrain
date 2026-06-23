import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/extensions/extensions.dart';
import 'package:explaino/core/gen/assets.gen.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ChatbotAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onHistoryPressed;
  final VoidCallback onNewChatPressed;

  const ChatbotAppBar({
    super.key,
    required this.title,
    required this.onHistoryPressed,
    required this.onNewChatPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.lightScaffold,
      centerTitle: false,
      leading: IconButton(
        tooltip: AppTextConstants.history,
        onPressed: onHistoryPressed,
        icon: Image.asset(
          Assets.icons.menuIcon.path,
          color: AppColors.primary,
          width: 21,
          height: 21,
          fit: BoxFit.scaleDown,
        ),
      ),
      titleSpacing: 0,
      title: Text(
        title.capitalize(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
      ),
      actions: [
        IconButton(
          tooltip: AppTextConstants.newChat,
          onPressed: onNewChatPressed,
          icon: const Icon(Icons.add_circle_sharp, color: AppColors.primary),
        ),
      ],
    );
  }
}

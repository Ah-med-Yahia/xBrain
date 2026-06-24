import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/extensions/extensions.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/tabs/chatbot/domain/entities/response/session_entity.dart';
import 'package:flutter/material.dart';

class ChatbotHistoryTile extends StatelessWidget {
  final SessionEntity session;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const ChatbotHistoryTile({
    super.key,
    required this.session,
    required this.selected,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: selected,
      selectedTileColor: AppColors.lightSkyBlue,
      tileColor: Colors.transparent,
      contentPadding: const EdgeInsets.only(left: 16, right: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Text(
        session.title.isNotEmpty ? session.title.capitalize() : session.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: selected ? AppColors.primary : AppColors.black,
          fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      trailing: IconButton(
        tooltip: AppTextConstants.delete,
        onPressed: onDelete,
        icon: Icon(
          Icons.delete_outline_rounded,
          size: 20,
          color: selected ? AppColors.primary : AppColors.black,
        ),
      ),
      onTap: onTap,
    );
  }
}

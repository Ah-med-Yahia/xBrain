import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/gen/assets.gen.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/tabs/chatbot/domain/entities/response/session_entity.dart';
import 'package:explaino/features/tabs/chatbot/presentation/widgets/chatbot_history_tile.dart';
import 'package:flutter/material.dart';

class ChatbotHistoryDrawer extends StatelessWidget {
  final List<SessionEntity> sessions;
  final String? selectedChatId;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback onNewChat;
  final VoidCallback onRetry;
  final ValueChanged<String> onChatSelected;
  final ValueChanged<String> onChatDeleted;

  const ChatbotHistoryDrawer({
    super.key,
    required this.sessions,
    required this.selectedChatId,
    required this.isLoading,
    required this.errorMessage,
    required this.onNewChat,
    required this.onRetry,
    required this.onChatSelected,
    required this.onChatDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.lightScaffold,
      shape: const RoundedRectangleBorder(),
      child: SafeArea(
        child: Column(
          children: [
            _DrawerHeader(onNewChat: onNewChat),
            const Divider(height: 1, color: AppColors.athensGray),
            Expanded(child: _buildBody(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (isLoading && sessions.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (errorMessage != null && sessions.isEmpty) {
      return _HistoryError(message: errorMessage!, onRetry: onRetry);
    }
    if (sessions.isEmpty) {
      return const Center(
        child: Text(
          AppTextConstants.noChatsYet,
          style: TextStyle(color: AppColors.lightTextSecondary),
        ),
      );
    }
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: sessions.length,
            separatorBuilder: (_, index) => const SizedBox(height: 2),
            itemBuilder: (context, index) {
              final session = sessions[index];
              final selected = session.id == selectedChatId;
              return ChatbotHistoryTile(
                session: session,
                selected: selected,
                onTap: () => onChatSelected(session.id),
                onDelete: () => onChatDeleted(session.id),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.images.appLogo.path,
              width: 28,
              height: 28,
              fit: BoxFit.scaleDown,
            ),
            const SizedBox(width: 8),
            Text(
              'xBrain',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.lightTextSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  final VoidCallback onNewChat;

  const _DrawerHeader({required this.onNewChat});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
      child: Row(
        children: [
          Text(
            AppTextConstants.chats,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const Spacer(),
          IconButton(
            tooltip: AppTextConstants.newChat,
            onPressed: onNewChat,
            icon: const Icon(Icons.add_circle_sharp, color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}

class _HistoryError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _HistoryError({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            TextButton(
              onPressed: onRetry,
              child: const Text(AppTextConstants.tryAgain),
            ),
          ],
        ),
      ),
    );
  }
}

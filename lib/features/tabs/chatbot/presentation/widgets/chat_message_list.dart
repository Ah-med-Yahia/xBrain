import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/tabs/chatbot/presentation/models/chat_message_ui_model.dart';
import 'package:explaino/features/tabs/chatbot/presentation/widgets/chat_message_bubble.dart';
import 'package:flutter/material.dart';

class ChatMessageList extends StatelessWidget {
  final List<ChatMessageUiModel> messages;
  final ScrollController scrollController;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback onRetry;
  final ValueChanged<String> onDeeperQuestionSelected;

  const ChatMessageList({
    super.key,
    required this.messages,
    required this.scrollController,
    required this.isLoading,
    required this.errorMessage,
    required this.onRetry,
    required this.onDeeperQuestionSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading && messages.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (errorMessage != null && messages.isEmpty) {
      return _ChatLoadError(message: errorMessage!, onRetry: onRetry);
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      controller: scrollController,
      padding: const EdgeInsets.only(top: 12, bottom: 16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return ChatMessageBubble(
          message: messages[index],
          onDeeperQuestionSelected: onDeeperQuestionSelected,
        );
      },
    );
  }
}

class _ChatLoadError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ChatLoadError({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: AppColors.error,
              size: 34,
            ),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            FilledButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}

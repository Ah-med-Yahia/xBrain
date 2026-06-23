import 'package:explaino/features/tabs/chatbot/domain/entities/request/start_new_chat_request_entity.dart';

sealed class ChatbotIntents {}

// ======================= Chat Management =======================

class ListMyChatsIntent extends ChatbotIntents {}

class OpenNewChatIntent extends ChatbotIntents {}

class ToggleChatHistoryIntent extends ChatbotIntents {
  final bool isOpen;
  ToggleChatHistoryIntent({required this.isOpen});
}

class StartNewChatIntent extends ChatbotIntents {
  final StartNewChatRequestEntity? request;
  StartNewChatIntent({this.request});
}

class GetChatDetailsIntent extends ChatbotIntents {
  final String id;
  GetChatDetailsIntent({required this.id});
}

class RenameChatIntent extends ChatbotIntents {
  final String id;
  final StartNewChatRequestEntity request;
  RenameChatIntent({required this.id, required this.request});
}

class DeleteChatIntent extends ChatbotIntents {
  final String id;
  DeleteChatIntent({required this.id});
}

// ======================= Chat Messaging =======================

class AskQuestionIntent extends ChatbotIntents {
  final String chatId;
  final String question;
  AskQuestionIntent({required this.chatId, required this.question});
}

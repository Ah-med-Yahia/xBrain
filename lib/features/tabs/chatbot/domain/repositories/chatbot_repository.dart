import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/tabs/chatbot/domain/entities/request/start_new_chat_request_entity.dart';
import 'package:explaino/features/tabs/chatbot/domain/entities/response/get_my_chats_response_entity.dart';
import 'package:explaino/features/tabs/chatbot/domain/entities/response/session_details_entity.dart';
import 'package:explaino/features/tabs/chatbot/domain/entities/response/session_entity.dart';

abstract interface class ChatbotRepository {
  Future<BaseResponse<GetMyChatsResponseEntity>> listMyChats();

  Future<BaseResponse<SessionEntity>> startNewChat(
    StartNewChatRequestEntity? request,
  );

  Stream<String> askQuestion({
    required String chatId,
    required String question,
  });

  Future<BaseResponse<SessionDetailsEntity>> getChatDetails(String id);

  Future<BaseResponse<SessionEntity>> renameChat(
    String id,
    StartNewChatRequestEntity request,
  );

  Future<BaseResponse<void>> deleteChat(String id);
}

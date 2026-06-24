import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/tabs/chatbot/data/models/request/start_new_chat_request.dart';
import 'package:explaino/features/tabs/chatbot/data/models/response/chat_stream_result_model.dart';
import 'package:explaino/features/tabs/chatbot/data/models/response/get_my_chats_response_model.dart';
import 'package:explaino/features/tabs/chatbot/data/models/response/session_details_model.dart';
import 'package:explaino/features/tabs/chatbot/data/models/response/session_model.dart';

abstract interface class RemoteChatbotDataSource {
  Future<BaseResponse<GetMyChatsResponse>> listMyChats();

  Future<BaseResponse<SessionModel>> startNewChat(StartNewChatRequest? request);

  Stream<BaseResponse<ChatStreamResult>> askQuestion({
    required String chatId,
    required String question,
  });

  Future<BaseResponse<SessionDetailsModel>> getChatDetails(String id);

  Future<BaseResponse<SessionModel>> renameChat(
    String id,
    StartNewChatRequest request,
  );

  Future<BaseResponse<void>> deleteChat(String id);
}

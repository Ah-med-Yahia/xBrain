import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/network/safe_api_call.dart';
import 'package:explaino/features/tabs/chatbot/api/api_clients/chatbot_api_client.dart';
import 'package:explaino/features/tabs/chatbot/data/datasources/remote/remote_chatbot_data_source.dart';
import 'package:explaino/features/tabs/chatbot/data/models/request/start_new_chat_request.dart';
import 'package:explaino/features/tabs/chatbot/data/models/response/get_my_chats_response_model.dart';
import 'package:explaino/features/tabs/chatbot/data/models/response/session_details_model.dart';
import 'package:explaino/features/tabs/chatbot/data/models/response/session_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RemoteChatbotDataSource)
class RemoteChatbotDataSourceImpl implements RemoteChatbotDataSource {
  final ChatbotApiClient _chatbotApiClient;

  RemoteChatbotDataSourceImpl(this._chatbotApiClient);

  @override
  Future<BaseResponse<GetMyChatsResponse>> listMyChats() async {
    return await safeApiCall(() => _chatbotApiClient.listMyChats());
  }

  @override
  Future<BaseResponse<SessionModel>> startNewChat(
    StartNewChatRequest? request,
  ) async {
    return await safeApiCall(() => _chatbotApiClient.startNewChat(request));
  }

  @override
  Future<BaseResponse<SessionDetailsModel>> getChatDetails(String id) async {
    return await safeApiCall(() => _chatbotApiClient.getChatDetails(id));
  }

  @override
  Future<BaseResponse<SessionModel>> renameChat(
    String id,
    StartNewChatRequest request,
  ) async {
    return await safeApiCall(() => _chatbotApiClient.renameChat(id, request));
  }

  @override
  Future<BaseResponse<void>> deleteChat(String id) async {
    return await safeApiCall(() => _chatbotApiClient.deleteChat(id));
  }
}

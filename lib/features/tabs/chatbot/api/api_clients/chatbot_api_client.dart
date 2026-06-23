import 'package:dio/dio.dart';
import 'package:explaino/core/constants/api_constants.dart';
import 'package:explaino/features/tabs/chatbot/data/models/request/start_new_chat_request.dart';
import 'package:explaino/features/tabs/chatbot/data/models/response/get_my_chats_response_model.dart';
import 'package:explaino/features/tabs/chatbot/data/models/response/session_details_model.dart';
import 'package:explaino/features/tabs/chatbot/data/models/response/session_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'chatbot_api_client.g.dart';

@injectable
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ChatbotApiClient {
  @factoryMethod
  factory ChatbotApiClient(Dio dio) = _ChatbotApiClient;

  @GET(ApiConstants.listMyChats)
  Future<GetMyChatsResponse> listMyChats();

  @POST(ApiConstants.startNewChat)
  Future<SessionModel> startNewChat(@Body() StartNewChatRequest? request);

  @GET(ApiConstants.getChatDetails)
  Future<SessionDetailsModel> getChatDetails(@Path() String id);

  @PATCH(ApiConstants.renameChat)
  Future<SessionModel> renameChat(
    @Path('id') String id,
    @Body() StartNewChatRequest request,
  );

  @DELETE(ApiConstants.deleteChat)
  Future<void> deleteChat(@Path('id') String id);
}

import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/tabs/chatbot/data/datasources/remote/remote_chatbot_data_source.dart';
import 'package:explaino/features/tabs/chatbot/data/mappers/get_my_chats_response_mapper.dart';
import 'package:explaino/features/tabs/chatbot/data/mappers/session_details_mapper.dart';
import 'package:explaino/features/tabs/chatbot/data/mappers/session_mapper.dart';
import 'package:explaino/features/tabs/chatbot/data/mappers/start_new_chat_request_mapper.dart';
import 'package:explaino/features/tabs/chatbot/domain/entities/request/start_new_chat_request_entity.dart';
import 'package:explaino/features/tabs/chatbot/domain/entities/response/get_my_chats_response_entity.dart';
import 'package:explaino/features/tabs/chatbot/domain/entities/response/session_details_entity.dart';
import 'package:explaino/features/tabs/chatbot/domain/entities/response/session_entity.dart';
import 'package:explaino/features/tabs/chatbot/domain/repositories/chatbot_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChatbotRepository)
class ChatbotRepositoryImpl implements ChatbotRepository {
  final RemoteChatbotDataSource _remoteChatbotDataSource;

  ChatbotRepositoryImpl(this._remoteChatbotDataSource);

  @override
  Future<BaseResponse<GetMyChatsResponseEntity>> listMyChats() async {
    final result = await _remoteChatbotDataSource.listMyChats();
    return result.when(
      success: (data) => BaseResponse.success(data.toEntity()),
      failure: (error) => BaseResponse.failure(error),
    );
  }

  @override
  Future<BaseResponse<SessionEntity>> startNewChat(
    StartNewChatRequestEntity? request,
  ) async {
    final result = await _remoteChatbotDataSource.startNewChat(
      request?.toModel(),
    );
    return result.when(
      success: (data) => BaseResponse.success(data.toEntity()),
      failure: (error) => BaseResponse.failure(error),
    );
  }

  @override
  Future<BaseResponse<SessionDetailsEntity>> getChatDetails(String id) async {
    final result = await _remoteChatbotDataSource.getChatDetails(id);
    return result.when(
      success: (data) => BaseResponse.success(data.toEntity()),
      failure: (error) => BaseResponse.failure(error),
    );
  }

  @override
  Future<BaseResponse<SessionEntity>> renameChat(
    String id,
    StartNewChatRequestEntity request,
  ) async {
    final result = await _remoteChatbotDataSource.renameChat(
      id,
      request.toModel(),
    );
    return result.when(
      success: (data) => BaseResponse.success(data.toEntity()),
      failure: (error) => BaseResponse.failure(error),
    );
  }

  @override
  Future<BaseResponse<void>> deleteChat(String id) async {
    final result = await _remoteChatbotDataSource.deleteChat(id);
    return result.when(
      success: (data) => const BaseResponse<void>.success(null),
      failure: (error) => BaseResponse.failure(error),
    );
  }
}

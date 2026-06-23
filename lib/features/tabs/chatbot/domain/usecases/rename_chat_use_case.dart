import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/tabs/chatbot/domain/entities/request/start_new_chat_request_entity.dart';
import 'package:explaino/features/tabs/chatbot/domain/entities/response/session_entity.dart';
import 'package:explaino/features/tabs/chatbot/domain/repositories/chatbot_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class RenameChatUseCase {
  final ChatbotRepository _chatbotRepository;

  RenameChatUseCase(this._chatbotRepository);

  Future<BaseResponse<SessionEntity>> call(
    String id,
    StartNewChatRequestEntity request,
  ) async {
    return await _chatbotRepository.renameChat(id, request);
  }
}

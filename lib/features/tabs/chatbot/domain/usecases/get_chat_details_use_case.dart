import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/tabs/chatbot/domain/entities/response/session_details_entity.dart';
import 'package:explaino/features/tabs/chatbot/domain/repositories/chatbot_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetChatDetailsUseCase {
  final ChatbotRepository _chatbotRepository;

  GetChatDetailsUseCase(this._chatbotRepository);

  Future<BaseResponse<SessionDetailsEntity>> call(String id) async {
    return await _chatbotRepository.getChatDetails(id);
  }
}

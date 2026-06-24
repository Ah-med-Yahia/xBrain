import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/tabs/chatbot/domain/repositories/chatbot_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteChatUseCase {
  final ChatbotRepository _chatbotRepository;

  DeleteChatUseCase(this._chatbotRepository);

  Future<BaseResponse<void>> call(String id) async {
    return await _chatbotRepository.deleteChat(id);
  }
}

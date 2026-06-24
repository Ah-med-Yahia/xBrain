import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/tabs/chatbot/domain/entities/response/get_my_chats_response_entity.dart';
import 'package:explaino/features/tabs/chatbot/domain/repositories/chatbot_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ListMyChatsUseCase {
  final ChatbotRepository _chatbotRepository;

  ListMyChatsUseCase(this._chatbotRepository);

  Future<BaseResponse<GetMyChatsResponseEntity>> call() async {
    return await _chatbotRepository.listMyChats();
  }
}

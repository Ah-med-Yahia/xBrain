import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/tabs/chatbot/domain/entities/response/chat_stream_result_entity.dart';
import 'package:explaino/features/tabs/chatbot/domain/repositories/chatbot_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AskQuestionUseCase {
  final ChatbotRepository _chatbotRepository;

  AskQuestionUseCase(this._chatbotRepository);

  Stream<BaseResponse<ChatStreamResultEntity>> call({
    required String chatId,
    required String question,
  }) {
    return _chatbotRepository.askQuestion(chatId: chatId, question: question);
  }
}

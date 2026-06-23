import 'package:explaino/features/tabs/chatbot/domain/repositories/chatbot_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AskQuestionUseCase {
  final ChatbotRepository _chatbotRepository;

  AskQuestionUseCase(this._chatbotRepository);

  Stream<String> call({required String chatId, required String question}) {
    return _chatbotRepository.askQuestion(chatId: chatId, question: question);
  }
}

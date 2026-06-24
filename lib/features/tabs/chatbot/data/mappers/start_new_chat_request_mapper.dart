import 'package:explaino/features/tabs/chatbot/data/models/request/start_new_chat_request.dart';
import 'package:explaino/features/tabs/chatbot/domain/entities/request/start_new_chat_request_entity.dart';

extension StartNewChatRequestMapper on StartNewChatRequestEntity {
  StartNewChatRequest toModel() {
    return StartNewChatRequest(title: title);
  }
}

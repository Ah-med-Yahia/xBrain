import 'package:equatable/equatable.dart';
import 'package:explaino/features/tabs/chatbot/domain/entities/response/session_details_entity.dart';

enum ChatMessageAuthor { user, assistant }

class ChatMessageUiModel extends Equatable {
  final String id;
  final String content;
  final ChatMessageAuthor author;
  final bool isStreaming;

  const ChatMessageUiModel({
    required this.id,
    required this.content,
    required this.author,
    this.isStreaming = false,
  });

  bool get isUser => author == ChatMessageAuthor.user;

  ChatMessageUiModel copyWith({String? content, bool? isStreaming}) {
    return ChatMessageUiModel(
      id: id,
      content: content ?? this.content,
      author: author,
      isStreaming: isStreaming ?? this.isStreaming,
    );
  }

  factory ChatMessageUiModel.fromHistory(
    HistoryElementEntity history,
    int index,
  ) {
    final normalizedRole = history.role.toLowerCase();
    return ChatMessageUiModel(
      id: 'history-$index-$normalizedRole',
      content: history.content,
      author: normalizedRole == 'user'
          ? ChatMessageAuthor.user
          : ChatMessageAuthor.assistant,
    );
  }

  @override
  List<Object?> get props => [id, content, author, isStreaming];
}

import 'package:equatable/equatable.dart';
import 'package:explaino/config/base_state/base_state.dart';
import 'package:explaino/features/tabs/chatbot/domain/entities/response/get_my_chats_response_entity.dart';
import 'package:explaino/features/tabs/chatbot/domain/entities/response/session_details_entity.dart';
import 'package:explaino/features/tabs/chatbot/presentation/models/chat_message_ui_model.dart';

class ChatbotState extends Equatable {
  final BaseState<GetMyChatsResponseEntity> chatsState;
  final BaseState<SessionDetailsEntity> chatDetailsState;
  final List<ChatMessageUiModel> messages;
  final String? selectedChatId;
  final String? selectedChatTitle;
  final bool isSending;
  final bool isDrawerOpen;
  final String? sendErrorMessage;

  const ChatbotState({
    this.chatsState = const BaseState<GetMyChatsResponseEntity>(),
    this.chatDetailsState = const BaseState<SessionDetailsEntity>(),
    this.messages = const [],
    this.selectedChatId,
    this.selectedChatTitle,
    this.isSending = false,
    this.isDrawerOpen = false,
    this.sendErrorMessage,
  });

  bool get hasActiveChat => selectedChatId != null;

  ChatbotState copyWith({
    BaseState<GetMyChatsResponseEntity>? chatsState,
    BaseState<SessionDetailsEntity>? chatDetailsState,
    List<ChatMessageUiModel>? messages,
    String? selectedChatId,
    String? selectedChatTitle,
    bool clearSelectedChat = false,
    bool? isSending,
    bool? isDrawerOpen,
    String? sendErrorMessage,
    bool clearSendError = false,
  }) {
    return ChatbotState(
      chatsState: chatsState ?? this.chatsState,
      chatDetailsState: chatDetailsState ?? this.chatDetailsState,
      messages: messages ?? this.messages,
      selectedChatId: clearSelectedChat
          ? null
          : selectedChatId ?? this.selectedChatId,
      selectedChatTitle: clearSelectedChat
          ? null
          : selectedChatTitle ?? this.selectedChatTitle,
      isSending: isSending ?? this.isSending,
      isDrawerOpen: isDrawerOpen ?? this.isDrawerOpen,
      sendErrorMessage: clearSendError
          ? null
          : sendErrorMessage ?? this.sendErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    chatsState,
    chatDetailsState,
    messages,
    selectedChatId,
    selectedChatTitle,
    isSending,
    isDrawerOpen,
    sendErrorMessage,
  ];
}

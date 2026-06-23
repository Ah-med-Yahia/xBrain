import 'dart:async';

import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/base_state/base_state.dart';
import 'package:explaino/features/tabs/chatbot/domain/entities/request/start_new_chat_request_entity.dart';
import 'package:explaino/features/tabs/chatbot/domain/usecases/ask_question_use_case.dart';
import 'package:explaino/features/tabs/chatbot/domain/usecases/delete_chat_use_case.dart';
import 'package:explaino/features/tabs/chatbot/domain/usecases/get_chat_details_use_case.dart';
import 'package:explaino/features/tabs/chatbot/domain/usecases/list_my_chats_use_case.dart';
import 'package:explaino/features/tabs/chatbot/domain/usecases/rename_chat_use_case.dart';
import 'package:explaino/features/tabs/chatbot/domain/usecases/start_new_chat_use_case.dart';
import 'package:explaino/features/tabs/chatbot/presentation/cubit/chat_bot_intents.dart';
import 'package:explaino/features/tabs/chatbot/presentation/cubit/chatbot_state.dart';
import 'package:explaino/features/tabs/chatbot/presentation/models/chat_message_ui_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChatbotCubit extends Cubit<ChatbotState> {
  final AskQuestionUseCase _askQuestionUseCase;
  final DeleteChatUseCase _deleteChatUseCase;
  final GetChatDetailsUseCase _getChatDetailsUseCase;
  final ListMyChatsUseCase _listMyChatsUseCase;
  final RenameChatUseCase _renameChatUseCase;
  final StartNewChatUseCase _startNewChatUseCase;
  StreamSubscription<String>? _answerSubscription;

  ChatbotCubit({
    required AskQuestionUseCase askQuestionUseCase,
    required DeleteChatUseCase deleteChatUseCase,
    required GetChatDetailsUseCase getChatDetailsUseCase,
    required ListMyChatsUseCase listMyChatsUseCase,
    required RenameChatUseCase renameChatUseCase,
    required StartNewChatUseCase startNewChatUseCase,
  }) : _askQuestionUseCase = askQuestionUseCase,
       _deleteChatUseCase = deleteChatUseCase,
       _getChatDetailsUseCase = getChatDetailsUseCase,
       _listMyChatsUseCase = listMyChatsUseCase,
       _renameChatUseCase = renameChatUseCase,
       _startNewChatUseCase = startNewChatUseCase,
       super(const ChatbotState());

  void doIntent(ChatbotIntents intent) {
    switch (intent) {
      case ListMyChatsIntent():
        _handleListMyChats();
        break;
      case OpenNewChatIntent():
        _handleOpenNewChat();
        break;
      case ToggleChatHistoryIntent(isOpen: final isOpen):
        emit(state.copyWith(isDrawerOpen: isOpen));
        break;
      case StartNewChatIntent(request: final request):
        _handleStartNewChat(request);
        break;
      case GetChatDetailsIntent(id: final id):
        _handleGetChatDetails(id);
        break;
      case RenameChatIntent(id: final id, request: final request):
        _handleRenameChat(id, request);
        break;
      case DeleteChatIntent(id: final id):
        _handleDeleteChat(id);
        break;
      case AskQuestionIntent(chatId: final chatId, question: final question):
        _handleAskQuestion(chatId: chatId, question: question);
        break;
    }
  }

  Future<void> _handleListMyChats() async {
    if (state.chatsState.isFetching) return;
    emit(
      state.copyWith(
        chatsState: state.chatsState.copyWith(
          isFetching: true,
          clearError: true,
        ),
      ),
    );

    final result = await _listMyChatsUseCase();
    result.when(
      success: (data) {
        emit(
          state.copyWith(
            chatsState: state.chatsState.copyWith(
              data: data,
              isFetching: false,
            ),
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            chatsState: state.chatsState.copyWith(
              errorMessage: error.message,
              isFetching: false,
            ),
          ),
        );
      },
    );
  }

  void _handleOpenNewChat() {
    _answerSubscription?.cancel();
    emit(
      state.copyWith(
        clearSelectedChat: true,
        messages: const [],
        isSending: false,
        isDrawerOpen: false,
        chatDetailsState: const BaseState(),
        clearSendError: true,
      ),
    );
  }

  Future<void> _handleStartNewChat(StartNewChatRequestEntity? request) async {
    final chatRequest = request ?? StartNewChatRequestEntity(title: 'New chat');
    emit(state.copyWith(isSending: true, clearSendError: true));

    final result = await _startNewChatUseCase(chatRequest);
    result.when(
      success: (session) {
        emit(
          state.copyWith(
            selectedChatId: session.id,
            selectedChatTitle: session.title,
            isSending: false,
          ),
        );
        _handleListMyChats();
      },
      failure: (error) {
        emit(state.copyWith(isSending: false, sendErrorMessage: error.message));
      },
    );
  }

  Future<void> _handleGetChatDetails(String id) async {
    if (state.selectedChatId == id && state.messages.isNotEmpty) {
      emit(state.copyWith(isDrawerOpen: false));
      return;
    }
    _answerSubscription?.cancel();
    emit(
      state.copyWith(
        selectedChatId: id,
        isDrawerOpen: false,
        messages: const [],
        clearSendError: true,
        chatDetailsState: state.chatDetailsState.copyWith(
          isFetching: true,
          clearError: true,
        ),
      ),
    );

    final result = await _getChatDetailsUseCase(id);
    result.when(
      success: (details) {
        final history = details.history.history;
        emit(
          state.copyWith(
            selectedChatTitle: details.title,
            messages: [
              for (var i = 0; i < history.length; i++)
                ChatMessageUiModel.fromHistory(history[i], i),
            ],
            chatDetailsState: state.chatDetailsState.copyWith(
              data: details,
              isFetching: false,
            ),
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            chatDetailsState: state.chatDetailsState.copyWith(
              errorMessage: error.message,
              isFetching: false,
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleRenameChat(
    String id,
    StartNewChatRequestEntity request,
  ) async {
    final result = await _renameChatUseCase(id, request);
    result.when(
      success: (session) {
        emit(state.copyWith(selectedChatTitle: session.title));
        _handleListMyChats();
      },
      failure: (error) {
        emit(state.copyWith(sendErrorMessage: error.message));
      },
    );
  }

  Future<void> _handleDeleteChat(String id) async {
    final result = await _deleteChatUseCase(id);
    result.when(
      success: (_) {
        if (state.selectedChatId == id) _handleOpenNewChat();
        _handleListMyChats();
      },
      failure: (error) {
        emit(state.copyWith(sendErrorMessage: error.message));
      },
    );
  }

  Future<void> _handleAskQuestion({
    required String chatId,
    required String question,
  }) async {
    final trimmedQuestion = question.trim();
    if (trimmedQuestion.isEmpty || state.isSending) return;

    final targetChatId = chatId.isEmpty
        ? await _createChatForQuestion(trimmedQuestion)
        : chatId;
    if (targetChatId == null) return;

    final userMessage = ChatMessageUiModel(
      id: 'user-${DateTime.now().microsecondsSinceEpoch}',
      content: trimmedQuestion,
      author: ChatMessageAuthor.user,
    );
    final assistantMessage = ChatMessageUiModel(
      id: 'assistant-${DateTime.now().microsecondsSinceEpoch}',
      content: '',
      author: ChatMessageAuthor.assistant,
      isStreaming: true,
    );

    emit(
      state.copyWith(
        messages: [...state.messages, userMessage, assistantMessage],
        isSending: true,
        clearSendError: true,
      ),
    );

    await _answerSubscription?.cancel();
    _answerSubscription =
        _askQuestionUseCase(
          chatId: targetChatId,
          question: trimmedQuestion,
        ).listen(
          (chunk) => _updateStreamingMessage(assistantMessage.id, chunk),
          onError: (Object error) {
            emit(
              state.copyWith(
                isSending: false,
                sendErrorMessage: error.toString(),
                messages: _finishStreamingMessage(assistantMessage.id),
              ),
            );
          },
          onDone: () {
            emit(
              state.copyWith(
                isSending: false,
                messages: _finishStreamingMessage(assistantMessage.id),
              ),
            );
            _handleListMyChats();
          },
        );
  }

  Future<String?> _createChatForQuestion(String question) async {
    emit(state.copyWith(isSending: true, clearSendError: true));
    final result = await _startNewChatUseCase(
      StartNewChatRequestEntity(title: _titleFromQuestion(question)),
    );

    return result.when(
      success: (session) {
        emit(
          state.copyWith(
            selectedChatId: session.id,
            selectedChatTitle: session.title,
          ),
        );
        _handleListMyChats();
        return session.id;
      },
      failure: (error) {
        emit(state.copyWith(isSending: false, sendErrorMessage: error.message));
        return null;
      },
    );
  }

  void _updateStreamingMessage(String messageId, String chunk) {
    emit(
      state.copyWith(
        messages: [
          for (final message in state.messages)
            if (message.id == messageId)
              message.copyWith(content: '${message.content}$chunk')
            else
              message,
        ],
      ),
    );
  }

  List<ChatMessageUiModel> _finishStreamingMessage(String messageId) {
    return [
      for (final message in state.messages)
        if (message.id == messageId)
          message.copyWith(isStreaming: false)
        else
          message,
    ];
  }

  String _titleFromQuestion(String question) {
    final normalized = question.replaceAll(RegExp(r'\s+'), ' ').trim();
    if (normalized.length <= 36) return normalized;
    return '${normalized.substring(0, 36)}...';
  }

  @override
  Future<void> close() async {
    await _answerSubscription?.cancel();
    return super.close();
  }
}

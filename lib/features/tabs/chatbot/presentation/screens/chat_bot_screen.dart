import 'package:explaino/config/di/di.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/tabs/chatbot/presentation/cubit/chat_bot_intents.dart';
import 'package:explaino/features/tabs/chatbot/presentation/cubit/chatbot_cubit.dart';
import 'package:explaino/features/tabs/chatbot/presentation/cubit/chatbot_state.dart';
import 'package:explaino/features/tabs/chatbot/presentation/widgets/chat_input_bar.dart';
import 'package:explaino/features/tabs/chatbot/presentation/widgets/chat_message_list.dart';
import 'package:explaino/features/tabs/chatbot/presentation/widgets/chatbot_app_bar.dart';
import 'package:explaino/features/tabs/chatbot/presentation/widgets/chatbot_history_drawer.dart';
import 'package:explaino/features/tabs/chatbot/presentation/widgets/chatbot_welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ChatInputBarState> _inputKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  late final ChatbotCubit _chatbotCubit;

  @override
  void initState() {
    super.initState();
    _chatbotCubit = getIt<ChatbotCubit>()..doIntent(ListMyChatsIntent());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _chatbotCubit.close();
    super.dispose();
  }

  void _sendMessage(String text) {
    _chatbotCubit.doIntent(
      AskQuestionIntent(
        chatId: _chatbotCubit.state.selectedChatId ?? '',
        question: text,
      ),
    );
  }

  void _fillPrompt(String prompt) {
    _inputKey.currentState?.fillPrompt(prompt);
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _chatbotCubit,
      child: BlocListener<ChatbotCubit, ChatbotState>(
        listenWhen: (previous, current) =>
            previous.messages.length != current.messages.length ||
            previous.messages.lastOrNull?.content !=
                current.messages.lastOrNull?.content ||
            previous.sendErrorMessage != current.sendErrorMessage,
        listener: (context, state) {
          _scrollToBottom();
          final error = state.sendErrorMessage;
          if (error != null) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(error)));
          }
        },
        child: BlocBuilder<ChatbotCubit, ChatbotState>(
          builder: (context, state) {
            return Scaffold(
              key: _scaffoldKey,
              backgroundColor: AppColors.lightScaffold,
              appBar: ChatbotAppBar(
                title:
                    state.selectedChatTitle ??
                    AppTextConstants.chatbotAppBarTitle,
                onHistoryPressed: () => _scaffoldKey.currentState?.openDrawer(),
                onNewChatPressed: () =>
                    context.read<ChatbotCubit>().doIntent(OpenNewChatIntent()),
              ),
              drawer: ChatbotHistoryDrawer(
                sessions: state.chatsState.data?.results ?? const [],
                selectedChatId: state.selectedChatId,
                isLoading: state.chatsState.isFetching,
                errorMessage: state.chatsState.errorMessage,
                onNewChat: () {
                  Navigator.of(context).pop();
                  context.read<ChatbotCubit>().doIntent(OpenNewChatIntent());
                },
                onRetry: () =>
                    context.read<ChatbotCubit>().doIntent(ListMyChatsIntent()),
                onChatSelected: (id) => context.read<ChatbotCubit>().doIntent(
                  GetChatDetailsIntent(id: id),
                ),
                onChatDeleted: (id) => context.read<ChatbotCubit>().doIntent(
                  DeleteChatIntent(id: id),
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child:
                        state.messages.isEmpty &&
                            !state.chatDetailsState.isFetching
                        ? ChatbotWelcome(onPromptSelected: _fillPrompt)
                        : ChatMessageList(
                            messages: state.messages,
                            scrollController: _scrollController,
                            isLoading: state.chatDetailsState.isFetching,
                            errorMessage: state.chatDetailsState.errorMessage,
                            onDeeperQuestionSelected: _fillPrompt,
                            onRetry: () {
                              final id = state.selectedChatId;
                              if (id == null) return;
                              context.read<ChatbotCubit>().doIntent(
                                GetChatDetailsIntent(id: id),
                              );
                            },
                          ),
                  ),
                  ChatInputBar(
                    key: _inputKey,
                    isSending: state.isSending,
                    onSend: _sendMessage,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

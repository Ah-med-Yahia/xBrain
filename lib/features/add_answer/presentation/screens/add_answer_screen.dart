import 'package:explaino/config/base_state/base_state.dart';
import 'package:explaino/config/di/di.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/helpers/image_picker_helper.dart';
import 'package:explaino/core/shared/presentation/widgets/custom_error_widget.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/add_answer/domain/entities/request/add_answer_request_entity.dart';
import 'package:explaino/features/add_answer/presentation/cubit/add_answer_cubit.dart';
import 'package:explaino/features/add_answer/presentation/cubit/add_answer_intents.dart';
import 'package:explaino/features/add_answer/presentation/cubit/add_answer_state.dart';
import 'package:explaino/features/add_answer/presentation/widgets/answer_card.dart';
import 'package:explaino/features/add_answer/presentation/widgets/comment_input_bar.dart';
import 'package:explaino/features/add_answer/presentation/widgets/shimmer/answer_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAnswerScreen extends StatefulWidget {
  final String questionId;
  final bool hasQuestion;

  const AddAnswerScreen({
    super.key,
    required this.questionId,
    required this.hasQuestion,
  });

  @override
  State<AddAnswerScreen> createState() => _AddAnswerScreenState();
}

class _AddAnswerScreenState extends State<AddAnswerScreen> {
  late AddAnswerCubit _addAnswerCubit;
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _addAnswerCubit = getIt<AddAnswerCubit>();
    _addAnswerCubit.doIntent(GetAnswersIntent(questionId: widget.questionId));
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final isAtBottom =
        _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200;
    if (isAtBottom) {
      _addAnswerCubit.doIntent(GetAnswersIntent(questionId: widget.questionId));
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onSend(AddAnswerState state) {
    _addAnswerCubit.doIntent(
      AddAnswerIntent(
        questionId: widget.questionId,
        addAnswerRequestEntity: AddAnswerRequestEntity(
          content: _commentController.text,
          attachments: [
            if (state.selectedImageFile != null) state.selectedImageFile!,
            if (state.selectedFile != null) state.selectedFile!,
          ].nullIfEmpty,
        ),
      ),
    );
    _commentController.clear();
    _focusNode.unfocus();
    _addAnswerCubit.doIntent(RemoveImageIntent());
    _addAnswerCubit.doIntent(RemoveFileIntent());
    _addAnswerCubit.doIntent(GetAnswersIntent(questionId: widget.questionId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _addAnswerCubit,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: AppColors.white,
          elevation: 0,
          title: const Text(
            AppTextConstants.answers,
            style: TextStyle(
              color: AppColors.jetBlack,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0.5),
            child: Container(color: AppColors.shimmerBaseColor, height: 0.5),
          ),
        ),
        body: Column(
          children: [
            Expanded(child: _buildAnswersList()),
            _buildCommentInputBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentInputBar() {
    return BlocBuilder<AddAnswerCubit, AddAnswerState>(
      buildWhen: (prev, next) =>
          prev.selectedImageFile != next.selectedImageFile ||
          prev.selectedFile != next.selectedFile,
      builder: (context, state) {
        return CommentInputBar(
          controller: _commentController,
          focusNode: _focusNode,
          selectedImage: state.selectedImageFile,
          selectedFile: state.selectedFile,
          onRemoveImage: () => _addAnswerCubit.doIntent(RemoveImageIntent()),
          onRemoveFile: () => _addAnswerCubit.doIntent(RemoveFileIntent()),
          onSend: () => _onSend(state),
          onImagePick: () {
            showImagePickerDialog(context).then((file) {
              if (file != null) {
                _addAnswerCubit.doIntent(
                  SelectImageFileIntent(imageFile: file),
                );
              }
            });
          },
          onFilePick: () {
            showFilePickerDialog(context).then((file) {
              if (file != null) {
                _addAnswerCubit.doIntent(SelectFileIntent(file: file));
              }
            });
          },
        );
      },
    );
  }

  Widget _buildAnswersList() {
    return BlocBuilder<AddAnswerCubit, AddAnswerState>(
      buildWhen: (prev, next) => prev.getAnswersState != next.getAnswersState,
      builder: (context, state) {
        return _buildListContent(
          state: state.getAnswersState,
          items: state.getAnswersState.data?.answers ?? [],
          onRetry: () => context.read<AddAnswerCubit>().doIntent(
            GetAnswersIntent(questionId: widget.questionId),
          ),
          itemBuilder: (answer) => AnswerCard(answer: answer),
          scrollController: _scrollController,
        );
      },
    );
  }

  Widget _buildListContent<T>({
    required BaseState<dynamic> state,
    required List<T> items,
    required Widget Function(T item) itemBuilder,
    required VoidCallback onRetry,
    required ScrollController scrollController,
  }) {
    if (state.isFetching && items.isEmpty && widget.hasQuestion) {
      return ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 80),
        itemCount: 7,
        itemBuilder: (_, index) => const AnswerShimmer(),
      );
    }
    if (state.errorMessage != null) {
      return CustomErrorWidget(error: state.errorMessage!, onTryAgain: onRetry);
    }
    if (items.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppTextConstants.noAnswersYet,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.jetBlack,
                ),
              ),
              SizedBox(height: 6),
              Text(
                AppTextConstants.beTheFirstToAnswerThisQuestion,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: AppColors.spanishGray),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.only(bottom: 80),
      itemCount: items.length + (state.isFetching ? 1 : 0),
      itemBuilder: (_, index) {
        if (index == items.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        }
        return itemBuilder(items[index]);
      },
    );
  }
}

extension _ListExt<T> on List<T> {
  List<T>? get nullIfEmpty => isEmpty ? null : this;
}

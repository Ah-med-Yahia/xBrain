import 'dart:io';

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
  int _currentPage = 1;
  static const int _pageSize = 10;
  File? _selectedImageFile;
  File? _selectedFile;

  @override
  void initState() {
    super.initState();
    _addAnswerCubit = getIt<AddAnswerCubit>();
    if (widget.hasQuestion) {
      _addAnswerCubit.doIntent(
        GetAnswersIntent(questionId: widget.questionId, page: 1),
      );
    }
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final state = _addAnswerCubit.state;
    final isAtBottom =
        _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200;

    final hasMore =
        (state.getAnswersState.data?.answers.length ?? 0) >=
        _currentPage * _pageSize;
    final isAlreadyLoading = state.getAnswersState.isFetching;

    if (isAtBottom && hasMore && !isAlreadyLoading) {
      _currentPage++;
      _addAnswerCubit.doIntent(
        GetAnswersIntent(questionId: widget.questionId, page: _currentPage),
      );
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: BlocProvider(
        create: (context) => _addAnswerCubit,
        child: Column(
          children: [
            Expanded(child: _buildAnswersList()),
            CommentInputBar(
              controller: _commentController,
              focusNode: _focusNode,
              selectedImage: _selectedImageFile,
              selectedFile: _selectedFile,
              onRemoveImage: () => setState(() => _selectedImageFile = null),
              onRemoveFile: () => setState(() => _selectedFile = null),
              onSend: () {
                _addAnswerCubit.doIntent(
                  AddAnswerIntent(
                    questionId: widget.questionId,
                    addAnswerRequestEntity: AddAnswerRequestEntity(
                      content: _commentController.text,
                      attachments:
                          _selectedImageFile != null || _selectedFile != null
                          ? [
                              if (_selectedImageFile != null)
                                _selectedImageFile!,
                              if (_selectedFile != null) _selectedFile!,
                            ]
                          : null,
                    ),
                  ),
                );
                _commentController.clear();
                setState(() {
                  _selectedImageFile = null;
                  _selectedFile = null;
                });
                _focusNode.unfocus();
              },
              onImagePick: () {
                showImagePickerDialog(context).then((file) {
                  setState(() => _selectedImageFile = file);
                });
              },
              onFilePick: () {
                showFilePickerDialog(context).then((file) {
                  setState(() => _selectedFile = file);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswersList() {
    return BlocBuilder<AddAnswerCubit, AddAnswerState>(
      buildWhen: (prev, next) => prev.getAnswersState != next.getAnswersState,
      builder: (context, state) => _buildListContent(
        state: state.getAnswersState,
        items: state.getAnswersState.data?.answers ?? [],
        onRetry: () => context.read<AddAnswerCubit>().doIntent(
          GetAnswersIntent(questionId: widget.questionId, page: 1),
        ),
        itemBuilder: (answer) => AnswerCard(answer: answer),
        scrollController: _scrollController,
      ),
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

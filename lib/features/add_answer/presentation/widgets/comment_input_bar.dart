import 'dart:io';

import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/add_answer/presentation/cubit/add_answer_cubit.dart';
import 'package:explaino/features/add_answer/presentation/cubit/add_answer_intents.dart';
import 'package:explaino/features/add_answer/presentation/cubit/add_answer_state.dart';
import 'package:explaino/features/add_answer/presentation/widgets/answer_button.dart';
import 'package:explaino/features/add_answer/presentation/widgets/attachment_previews.dart';
import 'package:explaino/features/add_answer/presentation/widgets/attachment_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentInputBar extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onSend;

  final VoidCallback? onImagePick;
  final VoidCallback? onFilePick;

  final File? selectedImage;
  final File? selectedFile;

  final VoidCallback? onRemoveImage;
  final VoidCallback? onRemoveFile;

  const CommentInputBar({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onSend,
    this.onImagePick,
    this.onFilePick,
    this.selectedImage,
    this.selectedFile,
    this.onRemoveImage,
    this.onRemoveFile,
  });

  @override
  State<CommentInputBar> createState() => _CommentInputBarState();
}

class _CommentInputBarState extends State<CommentInputBar> {
  bool get _hasAttachments =>
      widget.selectedImage != null || widget.selectedFile != null;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChanged);
    super.dispose();
  }

  void _onFocusChanged() {
    context.read<AddAnswerCubit>().doIntent(
      UpdateFocusStatusIntent(isFocused: widget.focusNode.hasFocus),
    );
  }

  void _onTextChanged(String value) {
    context.read<AddAnswerCubit>().doIntent(
      UpdateFileValidationIntent(
        content: value,
        file: widget.selectedFile,
        imageFile: widget.selectedImage,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [_inputSection(), _toolbarSection()],
    );
  }

  Widget _inputSection() {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      child: BlocBuilder<AddAnswerCubit, AddAnswerState>(
        buildWhen: (previous, current) =>
            previous.isFocused != current.isFocused,
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: state.isFocused
                    ? AppColors.primary
                    : AppColors.shimmerBaseColor,
                width: state.isFocused ? 1.5 : 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                  maxLines: null,

                  textCapitalization: TextCapitalization.sentences,
                  onChanged: _onTextChanged,
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.jetBlack,
                  ),
                  decoration: InputDecoration(
                    hintText: AppTextConstants.addAnAnswer,
                    hintStyle: textTheme.bodyMedium?.copyWith(
                      color: AppColors.spanishGray,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                ),
                if (_hasAttachments)
                  AttachmentPreviews(
                    selectedImage: widget.selectedImage,
                    selectedFile: widget.selectedFile,
                    onRemoveImage: widget.onRemoveImage,
                    onRemoveFile: widget.onRemoveFile,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _toolbarSection() {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: BlocBuilder<AddAnswerCubit, AddAnswerState>(
        buildWhen: (previous, current) =>
            previous.isFocused != current.isFocused,
        builder: (context, state) {
          if (!state.isFocused) {
            return const SizedBox.shrink();
          }
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            color: AppColors.white,
            child: Row(
              children: [
                AttachmentToolbar(
                  onImagePick: widget.onImagePick,
                  onFilePick: widget.onFilePick,
                ),
                const Spacer(),
                AnswerButton(
                  controller: widget.controller,
                  hasAttachments: _hasAttachments,
                  onTap: widget.onSend,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

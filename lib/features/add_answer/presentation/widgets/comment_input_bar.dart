import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CommentInputBar extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onSend;
  final VoidCallback? onImagePick;
  final VoidCallback? onFilePick;

  const CommentInputBar({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onSend,
    this.onImagePick,
    this.onFilePick,
  });

  @override
  State<CommentInputBar> createState() => _CommentInputBarState();
}

class _CommentInputBarState extends State<CommentInputBar> {
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() => _isFocused = widget.focusNode.hasFocus);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Color(0xFFE0E0E0), width: 0.5),
            ),
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            maxLines: null,
            textCapitalization: TextCapitalization.sentences,
            style: const TextStyle(fontSize: 14, color: Color(0xFF1A1A1A)),
            decoration: InputDecoration(
              hintText: 'Add an answer...',
              hintStyle: const TextStyle(
                fontSize: 14,
                color: Color(0xFF888888),
              ),
              filled: true,
              fillColor: const Color(0xFFF3F2EF),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: _isFocused
              ? Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(
                    16,
                    8,
                    16,
                    8 + MediaQuery.of(context).padding.bottom,
                  ),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Row(
                    children: [
                      _ToolbarButton(
                        icon: Icons.image_outlined,
                        label: 'Photo',
                        onTap: widget.onImagePick,
                      ),
                      const SizedBox(width: 8),
                      _ToolbarButton(
                        icon: Icons.insert_drive_file_outlined,
                        label: 'File',
                        onTap: widget.onFilePick,
                      ),
                      const Spacer(),
                      ValueListenableBuilder<TextEditingValue>(
                        valueListenable: widget.controller,
                        builder: (context, value, child) {
                          final hasText = value.text.isNotEmpty;
                          return GestureDetector(
                            onTap: hasText ? widget.onSend : null,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: hasText
                                    ? AppColors.primary
                                    : const Color(0xFFE0E0E0),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Answer',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: hasText
                                          ? Colors.white
                                          : const Color(0xFF999999),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Icon(
                                    Icons.send_rounded,
                                    color: hasText
                                        ? Colors.white
                                        : const Color(0xFF999999),
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _ToolbarButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _ToolbarButton({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, color: AppColors.kSoftBlueGray, size: 25),
    );
  }
}

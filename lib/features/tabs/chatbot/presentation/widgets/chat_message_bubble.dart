import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/tabs/chatbot/presentation/models/chat_message_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatMessageBubble extends StatelessWidget {
  final ChatMessageUiModel message;
  final ValueChanged<String>? onDeeperQuestionSelected;

  const ChatMessageBubble({
    super.key,
    required this.message,
    this.onDeeperQuestionSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (!message.isUser) {
      return _AssistantMessage(
        message: message,
        onDeeperQuestionSelected: onDeeperQuestionSelected,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 680),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: message.content.isEmpty && message.isStreaming
                  ? const _TypingDots()
                  : Text(
                      message.content,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.45,
                        color: AppColors.onPrimary,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AssistantMessage extends StatelessWidget {
  final ChatMessageUiModel message;
  final ValueChanged<String>? onDeeperQuestionSelected;

  const _AssistantMessage({
    required this.message,
    required this.onDeeperQuestionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: message.content.isEmpty && message.isStreaming
              ? const _TypingDots()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _FormattedAssistantText(content: message.content),
                    if (!message.isStreaming) ...[
                      if (message.hasMetadata) ...[
                        const SizedBox(height: 8),
                        _AssistantMetadata(
                          message: message,
                          onDeeperQuestionSelected: onDeeperQuestionSelected,
                        ),
                      ],
                      const SizedBox(height: 10),
                      _CopyResponseButton(content: message.content),
                    ],
                  ],
                ),
        ),
      ),
    );
  }
}

class _FormattedAssistantText extends StatelessWidget {
  final String content;

  const _FormattedAssistantText({required this.content});

  @override
  Widget build(BuildContext context) {
    final lines = content.trim().split('\n');
    final blocks = <Widget>[];

    for (var index = 0; index < lines.length; index++) {
      final trimmedLine = lines[index].trim();

      if (trimmedLine.startsWith('```')) {
        final language = trimmedLine.replaceFirst('```', '').trim();
        final codeLines = <String>[];

        index++;
        while (index < lines.length && !lines[index].trim().startsWith('```')) {
          codeLines.add(lines[index]);
          index++;
        }

        blocks.add(
          _CodeBlock(
            code: codeLines.join('\n').trimRight(),
            language: language.isEmpty ? null : language,
          ),
        );
        continue;
      }

      blocks.add(
        _MarkdownLine(
          line: lines[index],
          previousLine: index == 0 ? null : lines[index - 1],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: blocks,
    );
  }
}

class _CodeBlock extends StatelessWidget {
  final String code;
  final String? language;

  const _CodeBlock({required this.code, required this.language});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 14),
      child: SizedBox(
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.aliceBlue,
            border: Border.all(color: AppColors.athensGray),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (language != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                  child: Text(
                    language!,
                    style: textTheme.labelSmall?.copyWith(
                      color: AppColors.lightTextSecondary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(12),
                child: Text(
                  code,
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.lightTextPrimary,
                    fontFamily: 'monospace',
                    height: 1.55,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MarkdownLine extends StatelessWidget {
  final String line;
  final String? previousLine;

  const _MarkdownLine({required this.line, required this.previousLine});

  @override
  Widget build(BuildContext context) {
    final trimmedLine = line.trim();
    final textTheme = Theme.of(context).textTheme;

    if (trimmedLine.isEmpty) {
      return const SizedBox(height: 12);
    }

    if (trimmedLine.startsWith('## ')) {
      return Padding(
        padding: EdgeInsets.only(
          top: previousLine == null || previousLine!.trim().isEmpty ? 0 : 14,
          bottom: 8,
        ),
        child: Text(
          trimmedLine.replaceFirst('## ', ''),
          style: textTheme.titleSmall?.copyWith(
            color: AppColors.lightTextPrimary,
            fontWeight: FontWeight.w800,
            height: 1.25,
          ),
        ),
      );
    }

    if (trimmedLine.startsWith('- ')) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 7),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: AppColors.lightTextPrimary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.lightTextPrimary,
                    height: 1.5,
                  ),
                  children: _buildInlineSpans(trimmedLine.substring(2)),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: RichText(
        text: TextSpan(
          style: textTheme.bodyMedium?.copyWith(
            color: AppColors.lightTextPrimary,
            height: 1.55,
          ),
          children: _buildInlineSpans(trimmedLine),
        ),
      ),
    );
  }
}

class _AssistantMetadata extends StatelessWidget {
  final ChatMessageUiModel message;
  final ValueChanged<String>? onDeeperQuestionSelected;

  const _AssistantMetadata({
    required this.message,
    required this.onDeeperQuestionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.aliceBlue,
        border: Border.all(color: AppColors.athensGray),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.agent?.trim().isNotEmpty ?? false) ...[
              _MetadataSection(
                icon: Icons.smart_toy_outlined,
                label: 'Agent',
                child: _MetadataText(message.agent!),
              ),
            ],
            if (message.sources.isNotEmpty) ...[
              const SizedBox(height: 12),
              _MetadataSection(
                icon: Icons.link_rounded,
                label: 'Sources',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var index = 0; index < message.sources.length; index++)
                      _SourceTile(
                        source: message.sources[index],
                        isLast: index == message.sources.length - 1,
                      ),
                  ],
                ),
              ),
            ],
            if (message.deeperSuggestion?.trim().isNotEmpty ?? false) ...[
              const SizedBox(height: 12),
              _MetadataSection(
                icon: Icons.psychology_alt_outlined,
                label: 'Deeper question',
                child: _DeeperQuestionButton(
                  question: message.deeperSuggestion!,
                  onPressed: onDeeperQuestionSelected == null
                      ? null
                      : () => onDeeperQuestionSelected!(
                          message.deeperSuggestion!,
                        ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _MetadataSection extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget child;

  const _MetadataSection({
    required this.icon,
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 26,
          height: 26,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(color: AppColors.athensGray),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 15, color: AppColors.lightTextSecondary),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: textTheme.labelSmall?.copyWith(
                  color: AppColors.lightTextSecondary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              child,
            ],
          ),
        ),
      ],
    );
  }
}

class _MetadataText extends StatelessWidget {
  final String text;

  const _MetadataText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: AppColors.lightTextPrimary,
        height: 1.45,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _SourceTile extends StatelessWidget {
  final String source;
  final bool isLast;

  const _SourceTile({required this.source, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.buttonBorder),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.description_outlined,
                size: 16,
                color: AppColors.lightTextSecondary,
              ),
              const SizedBox(width: 8),
              Expanded(child: _MetadataText(source)),
            ],
          ),
        ),
      ),
    );
  }
}

class _DeeperQuestionButton extends StatelessWidget {
  final String question;
  final VoidCallback? onPressed;

  const _DeeperQuestionButton({
    required this.question,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Ink(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.buttonBorder),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _MetadataText(question)),
                const SizedBox(width: 8),
                const Icon(
                  Icons.north_east_rounded,
                  size: 16,
                  color: AppColors.lightTextSecondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CopyResponseButton extends StatefulWidget {
  final String content;

  const _CopyResponseButton({required this.content});

  @override
  State<_CopyResponseButton> createState() => _CopyResponseButtonState();
}

class _CopyResponseButtonState extends State<_CopyResponseButton> {
  bool _copied = false;

  Future<void> _copyContent() async {
    await Clipboard.setData(ClipboardData(text: widget.content));
    if (!mounted) return;
    setState(() => _copied = true);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Response copied')));
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: _copied ? 'Copied' : 'Copy response',
      child: IconButton(
        onPressed: widget.content.trim().isEmpty ? null : _copyContent,
        icon: Icon(
          _copied ? Icons.check_rounded : Icons.content_copy_rounded,
          size: 18,
        ),
        color: _copied ? AppColors.green : AppColors.lightTextSecondary,
        style: IconButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: const Size(34, 34),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}

class _TypingDots extends StatelessWidget {
  const _TypingDots();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        3,
        (index) => Container(
          width: 6,
          height: 6,
          margin: EdgeInsets.only(right: index == 2 ? 0 : 4),
          decoration: BoxDecoration(
            color: AppColors.lightTextSecondary.withValues(alpha: .7),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

List<InlineSpan> _buildInlineSpans(String text) {
  final spans = <InlineSpan>[];
  var start = 0;
  var isBold = false;

  while (start < text.length) {
    final markerIndex = text.indexOf('**', start);
    if (markerIndex == -1) {
      spans.add(_textSpan(text.substring(start), isBold));
      break;
    }

    if (markerIndex > start) {
      spans.add(_textSpan(text.substring(start, markerIndex), isBold));
    }

    isBold = !isBold;
    start = markerIndex + 2;
  }

  return spans;
}

TextSpan _textSpan(String text, bool isBold) {
  return TextSpan(
    text: text,
    style: TextStyle(fontWeight: isBold ? FontWeight.w800 : FontWeight.w400),
  );
}

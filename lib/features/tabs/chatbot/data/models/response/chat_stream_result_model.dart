class ChatStreamResult {
  final String answer;
  final String? deeperSuggestion;
  final List<String> sources;
  final String? agent;

  const ChatStreamResult({
    required this.answer,
    this.deeperSuggestion,
    required this.sources,
    this.agent,
  });
}

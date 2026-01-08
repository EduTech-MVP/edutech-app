class AIEvaluation {
  final String summary;
  final List<String> strengths;
  final List<String> areasForImprovement;
  final List<String> recommendations;
  final DateTime generatedAt;

  AIEvaluation({
    required this.summary,
    required this.strengths,
    required this.areasForImprovement,
    required this.recommendations,
    required this.generatedAt,
  });
}


class QuizResult {
  final String id;
  final String title;
  final String sdgName;
  final int score;
  final int totalQuestions;
  final DateTime completedAt;

  const QuizResult({
    required this.id,
    required this.title,
    required this.sdgName,
    required this.score,
    required this.totalQuestions,
    required this.completedAt,
  });

  double get percentage =>
      totalQuestions == 0 ? 0 : score / totalQuestions * 100;
}
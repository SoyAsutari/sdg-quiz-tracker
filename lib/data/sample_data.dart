import '../models/quiz_result.dart';

const int totalAvailableQuizzes = 25;

final List<QuizResult> sampleResults = [
  QuizResult(id: 'Q001', title: 'Climate Change Basics', sdgName: 'SDG 13 · Climate Action', score: 9, totalQuestions: 10, completedAt: DateTime(2026, 11, 18)),
  QuizResult(id: 'Q002', title: 'Understanding Poverty', sdgName: 'SDG 1 · No Poverty', score: 8, totalQuestions: 10, completedAt: DateTime(2026, 11, 17)),
  QuizResult(id: 'Q003', title: 'Healthy Living', sdgName: 'SDG 3 · Good Health', score: 7, totalQuestions: 10, completedAt: DateTime(2026, 11, 15)),
  QuizResult(id: 'Q004', title: 'Quality Education', sdgName: 'SDG 4 · Quality Education', score: 8, totalQuestions: 10, completedAt: DateTime(2026, 11, 14)),
  QuizResult(id: 'Q005', title: 'Clean Water for Everyone', sdgName: 'SDG 6 · Clean Water', score: 6, totalQuestions: 10, completedAt: DateTime(2026, 11, 12)),
];

class SdgProgress {
  final String name;
  final int completed;
  final int total;

  const SdgProgress(this.name, this.completed, this.total);

  double get fraction => total == 0 ? 0 : completed / total;
}

const List<SdgProgress> sampleSdgProgress = [
  SdgProgress('SDG 1 · No Poverty', 3, 4),
  SdgProgress('SDG 3 · Good Health', 2, 4),
  SdgProgress('SDG 4 · Quality Education', 4, 4),
  SdgProgress('SDG 6 · Clean Water', 1, 4),
  SdgProgress('SDG 13 · Climate Action', 2, 4),
];
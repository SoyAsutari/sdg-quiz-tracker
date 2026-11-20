import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import '../models/quiz_result.dart';
import '../widgets/section_heading.dart';
import '../widgets/stat_card.dart';
import '../widgets/sdg_progress_tile.dart';
import 'goal_screen.dart';
import 'quiz_detail_screen.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({super.key});

  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  int _weeklyGoal = 5;

  Future<void> _openGoalSettings() async {
    final updatedGoal = await Navigator.push<int>(
      context,
      MaterialPageRoute(builder: (_) => GoalScreen(currentGoal: _weeklyGoal)),
    );
    if (updatedGoal != null) {
      setState(() => _weeklyGoal = updatedGoal);
    }
  }

  void _openQuizDetails(QuizResult result) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => QuizDetailScreen(result: result)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final completed = sampleResults.length;
    final remaining = (totalAvailableQuizzes - completed).clamp(0, totalAvailableQuizzes);
    final completion = totalAvailableQuizzes == 0 ? 0.0 : completed / totalAvailableQuizzes;
    final average = completed == 0 ? 0.0 : sampleResults.map((r) => r.percentage).reduce((a, b) => a + b) / completed;
    final points = sampleResults.fold<int>(0, (sum, r) => sum + r.score * 10);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tracker'),
        actions: [
          IconButton(
            tooltip: 'Set weekly goal',
            onPressed: _openGoalSettings,
            icon: const Icon(Icons.flag_outlined),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
          children: [
            _buildWelcome(),
            const SizedBox(height: 20),
            _buildOverallCard(completion, completed),
            const SizedBox(height: 20),
            const SectionHeading(title: 'Your Statistics', subtitle: 'A quick look at your learning activity'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: StatCard(label: 'Completed', value: '$completed', icon: Icons.check_circle_outline)),
                const SizedBox(width: 12),
                Expanded(child: StatCard(label: 'Remaining', value: '$remaining', icon: Icons.hourglass_empty, iconColor: const Color(0xFF7C4DFF))),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: StatCard(label: 'Average score', value: '${average.toStringAsFixed(0)}%', icon: Icons.track_changes)),
                const SizedBox(width: 12),
                Expanded(child: StatCard(label: 'Points earned', value: '$points', icon: Icons.stars_outlined, iconColor: const Color(0xFFFFB300))),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Expanded(child: SectionHeading(title: 'SDG Performance', subtitle: 'Progress across your goal categories')),
                TextButton(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Showing all available SDG categories.'))),
                  child: const Text('View all', style: TextStyle(color: Color(0xFF46C2CB))),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: _panelDecoration(),
              child: Column(children: sampleSdgProgress.map((item) => SdgProgressTile(progress: item)).toList()),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Expanded(child: SectionHeading(title: 'Recent Activity', subtitle: 'Your latest completed quizzes')),
                Text('${sampleResults.length} quizzes', style: const TextStyle(color: Color(0xFF46C2CB), fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 12),
            ListView.builder(
              itemCount: sampleResults.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final result = sampleResults[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: _panelDecoration(),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => _openQuizDetails(result),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(color: const Color(0xFF1C2341), borderRadius: BorderRadius.circular(13)),
                            child: const Icon(Icons.menu_book_rounded, color: Color(0xFF46C2CB)),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(result.title, style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
                                const SizedBox(height: 4),
                                Text('${result.sdgName} · ${result.completedAt.day}/${result.completedAt.month}/${result.completedAt.year}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text('${result.percentage.toStringAsFixed(0)}%', style: const TextStyle(color: Color(0xFF46C2CB), fontWeight: FontWeight.w800, fontSize: 16)),
                          const Icon(Icons.chevron_right, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            _buildGoalCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcome() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Hello, Learner!', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800, color: Colors.white)),
              SizedBox(height: 4),
              Text('Keep making a difference, one quiz at a time.', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        Container(
          width: 48, height: 48,
          decoration: BoxDecoration(color: const Color(0xFF1C2341), borderRadius: BorderRadius.circular(16)),
          child: const Icon(Icons.person_outline, color: Color(0xFF46C2CB), size: 27),
        ),
      ],
    );
  }

  Widget _buildOverallCard(double progress, int completed) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF46C2CB), Color(0xFF7C4DFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [BoxShadow(color: const Color(0xFF7C4DFF).withOpacity(0.3), blurRadius: 18, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('OVERALL COMPLETION', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.1)),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${(progress * 100).round()}%', style: const TextStyle(color: Colors.white, fontSize: 38, fontWeight: FontWeight.w800)),
              const Spacer(),
              Text('$completed / $totalAvailableQuizzes quizzes', style: const TextStyle(color: Colors.white70)),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress, minHeight: 10,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation(Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          const Text('Every small step contributes to a better future.', style: TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildGoalCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C2341),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade800),
      ),
      child: Row(
        children: [
          const Icon(Icons.flag_circle, color: Color(0xFF46C2CB), size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Your weekly goal', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
                Text('Aim to complete $_weeklyGoal quizzes each week.', style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          TextButton(
            onPressed: _openGoalSettings,
            child: const Text('Edit', style: TextStyle(color: Color(0xFF46C2CB))),
          ),
        ],
      ),
    );
  }

  BoxDecoration _panelDecoration() {
    return BoxDecoration(
      color: const Color(0xFF1C2341),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey.shade800),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 3))],
    );
  }
}
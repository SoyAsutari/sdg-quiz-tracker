import 'package:flutter/material.dart';
import '../models/quiz_result.dart';

class QuizDetailScreen extends StatelessWidget {
  final QuizResult result;

  const QuizDetailScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final percent = result.percentage.round();

    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Details')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: const Color(0xFF1C2341),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(Icons.assignment_turned_in, color: Color(0xFF46C2CB), size: 30),
            ),
            const SizedBox(height: 20),
            Text(result.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 8),
            Text(result.sdgName, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1C2341),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  const Text('Your score', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Text('$percent%', style: const TextStyle(fontSize: 42, fontWeight: FontWeight.w800, color: Color(0xFF46C2CB))),
                  Text('${result.score} correct out of ${result.totalQuestions}', style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('Completed on', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 6),
            Text('${result.completedAt.day}/${result.completedAt.month}/${result.completedAt.year}', style: const TextStyle(color: Colors.grey)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back to Tracker'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
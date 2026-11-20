import 'package:flutter/material.dart';
import '../data/sample_data.dart';

class SdgProgressTile extends StatelessWidget {
  final SdgProgress progress;

  const SdgProgressTile({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    final percent = (progress.fraction * 100).round();

    return Padding(
      padding: const EdgeInsets.only(bottom: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  progress.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                '$percent%',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF46C2CB),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress.fraction,
              minHeight: 9,
              backgroundColor: Colors.grey.shade800,
              valueColor: const AlwaysStoppedAnimation(Color(0xFF46C2CB)),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '${progress.completed} of ${progress.total} quizzes completed',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
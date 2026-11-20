import 'package:flutter/material.dart';

class SectionHeading extends StatelessWidget {
  final String title;
  final String? subtitle;

  const SectionHeading({super.key, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(subtitle!, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ],
    );
  }
}
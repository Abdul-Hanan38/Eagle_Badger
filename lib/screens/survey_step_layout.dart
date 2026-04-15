import 'package:flutter/material.dart';

class SurveyStepLayout extends StatelessWidget {
  final String title;
  final String? description;
  final Widget content;
  final String? profile;

  const SurveyStepLayout({
    super.key,
    required this.title,
    this.description,
    required this.content,
    this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (profile != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color.fromARGB(57, 198, 16, 46),
                borderRadius: BorderRadius.circular(16),
              ),

              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.person,
                    fontWeight: FontWeight.w900,
                    color: const Color.fromARGB(255, 198, 16, 46),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Profiling: $profile",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 198, 16, 46),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          if (description != null) ...[
            const SizedBox(height: 12),
            Text(description!, style: Theme.of(context).textTheme.bodyMedium),
          ],
          const SizedBox(height: 32),
          Expanded(child: content),
        ],
      ),
    );
  }
}

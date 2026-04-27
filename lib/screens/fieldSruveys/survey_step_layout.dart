import 'package:eagle_badger/utils/responsive_helper.dart';
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
      padding: context.isSmall
          ? EdgeInsets.symmetric(horizontal: 20, vertical: 10)
          : EdgeInsets.all(24.0),
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
                    color: Theme.of(context).colorScheme.primary,
                    size: context.isSmall ? 16 : 18,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Profiling: $profile",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
          Text(
            title,
            style: context.isSmall
                ? Theme.of(context).textTheme.titleMedium!.copyWith(height: 1.2)
                : Theme.of(context).textTheme.titleLarge,
          ),
          if (description != null) ...[
            const SizedBox(height: 12),
            Text(
              description!,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
          const SizedBox(height: 32),
          Expanded(child: content),
        ],
      ),
    );
  }
}

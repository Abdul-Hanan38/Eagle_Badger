import 'package:eagle_badger/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class FieldMenuCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color backgroundColor;
  final Map<String, VoidCallback> actions;

  const FieldMenuCard({
    super.key,
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.isSmall ? EdgeInsets.all(8) : EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: backgroundColor.withValues(
                alpha: 0.3,
                blue: 0.3,
                red: 0.3,
                green: 0.3,
              ),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.onSurface,
              size: context.isSmall ? 16 : 24,
            ),
          ),
          SizedBox(height: 16),
          Text(title, style: Theme.of(context).textTheme.bodyLarge),

          const Spacer(),
          ...actions.entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: GestureDetector(
                onTap: entry.value,
                child: Row(
                  children: [
                    Text(
                      entry.key,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Theme.of(context).colorScheme.onSurface,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

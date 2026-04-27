import 'package:flutter/material.dart';
import 'package:eagle_badger/utils/responsive_helper.dart';

class PermissionCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isEnabled;
  final ValueChanged<bool> onChanged;

  const PermissionCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.isEnabled,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: context.isSmall ? EdgeInsets.all(8) : EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            padding: context.isSmall ? EdgeInsets.all(8) : EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.onSurface,
              size: context.isSmall ? 20 : 28,
            ),
          ),
          const SizedBox(width: 16),

          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.isSmall
                      ? Theme.of(context).textTheme.bodyLarge
                      : Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey[400]),
                ),
              ],
            ),
          ),

          // The Switch
          Transform.scale(
            scale: context.isSmall ? 0.8 : 1,
            child: Switch(
              value: isEnabled,
              onChanged: onChanged,
              activeThumbColor: Theme.of(context).colorScheme.onSurface,
              activeTrackColor: Theme.of(context).colorScheme.primary,
              inactiveTrackColor: Theme.of(
                context,
              ).colorScheme.onSecondaryFixed,
            ),
          ),
        ],
      ),
    );
  }
}

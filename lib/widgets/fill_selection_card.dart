import 'package:eagle_badger/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class FillSelectionCard extends StatelessWidget {
  const FillSelectionCard({
    super.key,
    required this.label,
    required this.isSelected,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: context.isSmall
            ? EdgeInsets.symmetric(vertical: 35)
            : EdgeInsets.symmetric(vertical: 60),
        margin: const EdgeInsets.only(bottom: 16),
        height: context.isSmall
            ? context.screenHeight * 0.2
            : context.screenHeight * 0.22,
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSecondaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.onSurface,
              size: context.isSmall ? 20 : 26,
            ),
            const SizedBox(height: 8),
            Text(label, style: Theme.of(context).textTheme.titleSmall),
          ],
        ),
      ),
    );
  }
}

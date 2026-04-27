import 'package:eagle_badger/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class SelectionCard extends StatelessWidget {
  const SelectionCard({
    super.key,
    required this.label,
    required this.subLabel,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final String subLabel;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: context.isSmall ? EdgeInsets.all(20) : EdgeInsets.all(25),
        margin: const EdgeInsets.only(bottom: 16),
        height: context.screenHeight * 0.2,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.tertiaryFixedDim,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subLabel,
                    style: TextStyle(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(label, style: Theme.of(context).textTheme.titleMedium),
                  SizedBox(height: context.isSmall ? 20 : 40),
                ],
              ),
            ),
            if (isSelected)
              CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                radius: context.isSmall ? 15 : 20,
                child: Icon(
                  Icons.check_circle,
                  color: Theme.of(context).colorScheme.onSurface,
                  size: context.isSmall ? 20 : 30,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

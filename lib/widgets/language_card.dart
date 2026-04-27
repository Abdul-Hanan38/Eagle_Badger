import 'package:flutter/material.dart';
import 'package:eagle_badger/utils/responsive_helper.dart';

class LanguageCard extends StatelessWidget {
  const LanguageCard({
    required this.title,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: context.isSmall
              ? EdgeInsets.symmetric(vertical: 22, horizontal: 16)
              : EdgeInsets.symmetric(vertical: 30, horizontal: 24),
          decoration: BoxDecoration(
            color: const Color(0xFF1A0F0F),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFFC6102E)
                  : const Color(0xFF2D2D2D),
              width: 2,
            ),
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: context.isSmall ? 14 : 16,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final Color? backgroundColor;

  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.leftIcon,
    this.rightIcon,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              backgroundColor ?? Theme.of(context).colorScheme.primary,
          // Use fixed height or dynamic based on context.isSmall
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leftIcon != null) ...[
              Icon(leftIcon, color: Theme.of(context).colorScheme.onSurface),
              const SizedBox(width: 8),
            ],
            Text(title, style: Theme.of(context).textTheme.labelMedium),
            if (rightIcon != null) ...[
              const SizedBox(width: 8),
              Icon(rightIcon, color: Theme.of(context).colorScheme.onSurface),
            ],
          ],
        ),
      ),
    );
  }
}

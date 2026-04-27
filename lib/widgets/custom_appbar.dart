import 'package:flutter/material.dart';
import 'package:eagle_badger/utils/responsive_helper.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData backIcon;
  final VoidCallback onBackTap;
  // Action button parameters
  final String? actionText;
  final IconData? actionIcon;
  final VoidCallback? onActionTap;
  final Color? actionColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.backIcon = Icons.arrow_back_ios,
    required this.onBackTap,
    this.actionText,
    this.actionIcon,
    this.onActionTap,
    this.actionColor,
  });

  @override
  Widget build(BuildContext context) {
    double dynamicSize = context.isSmall ? 18 : 22;

    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          backIcon,
          color: Theme.of(context).colorScheme.onSurface,
          size: dynamicSize,
        ),
        onPressed: onBackTap,
      ),
      titleSpacing: 0,
      title: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
          fontSize: dynamicSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [if (onActionTap != null) _buildActionButton(context)],
    );
  }

  Widget _buildActionButton(BuildContext context) {
    if (actionText != null) {
      return TextButton(
        onPressed: onActionTap,
        child: Text(
          actionText!,
          style: TextStyle(
            color: actionColor ?? Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: context.isSmall ? 16 : 22,
          ),
        ),
      );
    } else if (actionIcon != null) {
      return IconButton(
        icon: Icon(
          actionIcon,
          color: actionColor ?? Theme.of(context).colorScheme.onSurface,
        ),
        onPressed: onActionTap,
      );
    }
    return const SizedBox.shrink();
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

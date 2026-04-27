import 'package:eagle_badger/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class ResidentTile extends StatelessWidget {
  final String name;
  final String age;
  final String voterId;
  final Color statusColor;
  final String? imageUrl;

  const ResidentTile({
    super.key,
    required this.name,
    required this.age,
    required this.voterId,
    required this.statusColor,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(context.isSmall ? 10 : 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: context.isSmall ? 20 : 24,
            backgroundImage: AssetImage(imageUrl.toString()),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: Theme.of(context).textTheme.bodyLarge),
                Text(
                  "Age: $age | Voter ID: $voterId",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
          // Status Dot
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              border: Border.all(color: statusColor, width: 2),
            ),
          ),
        ],
      ),
    );
  }
}

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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage(imageUrl.toString()),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Age: $age | Voter ID: $voterId",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 13,
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

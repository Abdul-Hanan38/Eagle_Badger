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
      padding: const EdgeInsets.all(16),
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
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          // Generate buttons from the Map entries
          ...actions.entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: GestureDetector(
                onTap: entry.value, // This triggers the specific function
                child: Row(
                  children: [
                    Text(
                      entry.key, // The label (e.g., "CANVASSING")
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: Colors.white,
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

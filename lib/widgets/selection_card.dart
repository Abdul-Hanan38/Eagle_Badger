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
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: const Color.fromARGB(30, 243, 150, 166),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFFC6102E) : Colors.white10,
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
                      color: isSelected ? const Color(0xFFC6102E) : Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
            if (isSelected)
              const CircleAvatar(
                backgroundColor: Color(0xFFC6102E),
                radius: 20,
                child: Icon(Icons.check_circle, color: Colors.white, size: 30),
              ),
          ],
        ),
      ),
    );
  }
}

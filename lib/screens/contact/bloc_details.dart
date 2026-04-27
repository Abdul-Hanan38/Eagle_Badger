import 'package:eagle_badger/utils/responsive_helper.dart';
import 'package:eagle_badger/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class BlocDetailsScreen extends StatefulWidget {
  const BlocDetailsScreen({super.key});

  @override
  State<BlocDetailsScreen> createState() => _BlocDetailsScreenState();
}

class _BlocDetailsScreenState extends State<BlocDetailsScreen> {
  // State variables to track toggle positions
  int _influenceIndex = 2; // Default to HIGH
  int _sentimentIndex = 1; // Default to NEUTRAL

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(
        title: 'Bloc Details',
        onBackTap: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: SafeArea(
          child: Column(
            children: [
              // Header Image and Name
              const SizedBox(
                height: 90,
                width: 80,
                child: Image(
                  image: AssetImage('assets/images/blocDetails.png'),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Metropolitan Alliance",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                "Leader: Marcus Vane",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "Active Mobilization",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Stats Row
              Row(
                children: [
                  _buildStatBox("Total Members", "12,480"),
                  const SizedBox(width: 16),
                  _buildStatBox("Last Activity", "2h ago"),
                ],
              ),
              const SizedBox(height: 10),

              // Updated Toggles with State
              _buildToggleSection(
                "Influence Strength",
                ["LOW", "MEDIUM", "HIGH"],
                _influenceIndex,
                (index) => setState(() => _influenceIndex = index),
              ),
              const SizedBox(height: 10),
              _buildToggleSection(
                "Sentiment Direction",
                ["NEG", "NEUTRAL", "POS"],
                _sentimentIndex,
                (index) => setState(() => _sentimentIndex = index),
              ),

              const SizedBox(height: 30),
              _buildInfoTile("Primary District", "Central Business District"),
              const SizedBox(height: 12),
              _buildInfoTile("Trend Analysis", "Upward growth last 30 days"),

              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/engagementMemo');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "MOBILIZE BLOC NOW",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatBox(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondaryFixed,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            Text(value, style: Theme.of(context).textTheme.titleSmall),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleSection(
    String title,
    List<String> options,
    int activeIdx,
    Function(int) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 12),
        Container(
          height: context.isSmall ? 40 : 50,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondaryFixed,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: List.generate(
              options.length,
              (i) => Expanded(
                child: GestureDetector(
                  onTap: () => onChanged(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: i == activeIdx
                          ? (title.contains("Sentiment")
                                ? Colors.black38
                                : Theme.of(context).colorScheme.primary)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        options[i],
                        style: TextStyle(
                          color: i == activeIdx
                              ? (title.contains("Sentiment")
                                    ? Theme.of(context).colorScheme.onSurface
                                    : Theme.of(context).colorScheme.onSurface)
                              : Theme.of(context).colorScheme.onPrimary,
                          fontSize: context.isSmall ? 10 : 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoTile(String label, String sub) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondaryFixed,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          Text(
            sub,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

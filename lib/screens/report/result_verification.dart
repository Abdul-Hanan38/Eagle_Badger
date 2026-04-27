import 'package:eagle_badger/utils/responsive_helper.dart';
import 'package:eagle_badger/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class ResultVerificationScreen extends StatelessWidget {
  const ResultVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(
        title: 'Result Verification',
        onBackTap: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Document Preview Image
              ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Image.asset(
                  'assets/images/result.png',
                  height: context.screenHeight * 0.25,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),

              // 2. Validation Status Bar
              _buildValidationStatus(context),

              const SizedBox(height: 24),

              // 3. Main Statistics Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Main Statistics",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    "Sheet ID: #4429",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildResultTile(
                context,
                label: "Total Accredited Voters",
                value: "450",
                subtext: "High Confidence (94%)",
                subtextColor: Theme.of(context).colorScheme.tertiaryFixed,
              ),

              const SizedBox(height: 24),

              // 4. Party Vote Count List
              Text(
                "Party Vote Count",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 12),
              _buildPartyTile(
                context,
                "A",
                "Party A",
                "215",
                "Tap to edit if incorrect",
                const Color(0xFFC6102E),
              ),
              _buildPartyTile(
                context,
                "B",
                "Party B",
                "182",
                "Needs Review",
                Colors.blue,
                statusColor: Colors.orange,
              ),
              _buildPartyTile(
                context,
                "C",
                "Party C",
                "48",
                "Tap to edit if incorrect",
                Colors.grey.shade800,
              ),
              _buildPartyTile(
                context,
                "Inv",
                "Invalid / Spoilt",
                "5",
                "Verified",
                Colors.grey.shade900,
                isIcon: true,
              ),

              const SizedBox(height: 32),

              // 5. Confirm Button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/fieldWork');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Confirm Results",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildValidationStatus(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E241E),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.green.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 24),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Valid Form",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Official Agent Signature Detected",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultTile(
    BuildContext context, {
    required String label,
    required String value,
    required String subtext,
    required Color subtextColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondaryFixed,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 4),
                Text(
                  subtext,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(color: subtextColor),
                ),
              ],
            ),
          ),
          Text(value, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(width: 12),
          Icon(
            Icons.edit_note,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildPartyTile(
    BuildContext context,
    String initial,
    String name,
    String votes,
    String status,
    Color color, {
    Color? statusColor,
    bool isIcon = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondaryFixed,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 20,
            child: isIcon
                ? Icon(
                    Icons.analytics,
                    color: Theme.of(context).colorScheme.onSurface,
                    size: 18,
                  )
                : Text(
                    initial,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: Theme.of(context).textTheme.bodyLarge),
                Text(
                  status,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color:
                        statusColor ?? Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
          Text(votes, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(width: 12),
          Icon(
            Icons.edit_note,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 20,
          ),
        ],
      ),
    );
  }
}

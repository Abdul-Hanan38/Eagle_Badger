import 'package:flutter/material.dart';

class DaySummaryScreen extends StatelessWidget {
  const DaySummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
            size: 22,
            fontWeight: FontWeight.w900,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Day Summary",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile Image
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/avator4.png'),
            ),
            const SizedBox(height: 20),

            // Welcome Header
            Text(
              "Great work, Alex!",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              "Top 5% of Field Mobilizers today",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Your efforts in the 4th District have significantly increased our outreach efficiency.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Top Statistics Row
            Row(
              children: [
                _buildMajorStatCard(
                  context,
                  "Tasks Done",
                  "24",
                  "+15%",
                  "Daily Target Achieved",
                ),
                const SizedBox(width: 16),
                _buildMajorStatCard(
                  context,
                  "Points",
                  "450",
                  "+20%",
                  "Personal Best Streak",
                ),
              ],
            ),

            const SizedBox(height: 32),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Field Intelligence Impact",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Impact Grid (2x2)
            Row(
              children: [
                _buildImpactTile(context, "Registrations", "12", "New"),
                const SizedBox(width: 16),
                _buildImpactTile(context, "Neighborhoods", "3", "Covered"),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildImpactTile(context, "Commitments", "8", "Pledges"),
                const SizedBox(width: 16),
                _buildImpactTile(context, "Travel", "4.2", "Miles"),
              ],
            ),

            const SizedBox(height: 30),

            // Wrap-up Button
            ElevatedButton(
              onPressed: () {
                // Handle final submission
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Complete Day Wrap-up",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Major Stats Helper (Tasks/Points)
  Widget _buildMajorStatCard(
    BuildContext context,
    String title,
    String value,
    String percent,
    String subtext,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondaryFixed,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Theme.of(context).colorScheme.onSecondary),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  percent,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: Colors.green),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              subtext,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImpactTile(
    BuildContext context,
    String title,
    String value,
    String label,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondaryFixed,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Theme.of(context).colorScheme.onSecondary),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

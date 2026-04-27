import 'package:eagle_badger/utils/responsive_helper.dart';
import 'package:eagle_badger/widgets/custom_appbar.dart';
import 'package:eagle_badger/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class DaySummaryScreen extends StatelessWidget {
  const DaySummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(
        title: 'Day Summary',
        onBackTap: () => Navigator.pop(context),
        backIcon: Icons.close,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomButton(
          title: 'Complete Day Wrap-up',
          onPressed: () => Navigator.pushNamed(context, '/rewards'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: context.isSmall ? 10 : 20),
              // Profile Image
              CircleAvatar(
                radius: context.isSmall ? 40 : 60,
                backgroundImage: AssetImage('assets/images/avator4.png'),
              ),
              const SizedBox(height: 20),

              // Welcome Header
              Text(
                "Great work, Alex!",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.isSmall ? 10 : 20,
                ),
                child: Text(
                  "Top 5% of Field Mobilizers today",
                  style: context.isSmall
                      ? Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.isSmall ? 10 : 20,
                ),
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
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Field Intelligence Impact",
                  style: Theme.of(context).textTheme.labelMedium,
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
              const SizedBox(height: 40),
            ],
          ),
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
        padding: context.isSmall ? EdgeInsets.all(15) : EdgeInsets.all(20),
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
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.tertiaryFixed,
                  ),
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
        padding: context.isSmall ? EdgeInsets.all(15) : EdgeInsets.all(20),
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

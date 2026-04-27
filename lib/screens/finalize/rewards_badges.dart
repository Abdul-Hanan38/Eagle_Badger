import 'package:eagle_badger/utils/responsive_helper.dart';
import 'package:eagle_badger/widgets/custom_appbar.dart';
import 'package:eagle_badger/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class RewardsBadgesScreen extends StatelessWidget {
  const RewardsBadgesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(
        title: 'Rewards & Badges',
        onBackTap: () => Navigator.pop(context),
        actionIcon: Icons.reply,
        actionColor: Theme.of(context).colorScheme.onSurface,
        onActionTap: () {},
      ),
      // Fixed bottom button
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomButton(
            title: 'Share Achivements',
            leftIcon: Icons.share,
            onPressed: () =>
                Navigator.popUntil(context, ModalRoute.withName('/fieldWork')),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Center(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.red, Colors.orange],
                        ),
                      ),
                      child: CircleAvatar(
                        radius: context.isSmall ? 40 : 60,
                        backgroundColor: Colors.black,
                        backgroundImage: AssetImage(
                          'assets/images/avator5.png',
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.isSmall ? 8 : 12,
                          vertical: context.isSmall ? 2 : 4,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: Text(
                          "PRO",
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Field Volunteer",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _QuickStat(
                    label: "Global Rank",
                    value: "Top 5%",
                    valueColor: Theme.of(context).colorScheme.primary,
                  ),
                  SizedBox(width: 40),
                  _QuickStat(label: "Badges Earned", value: "12"),
                ],
              ),
              const SizedBox(height: 40),

              // Featured Achievements
              _SectionHeader(title: "Featured Achievements"),
              _buildAchievementCard(
                context,
                title: "PU Champion",
                desc:
                    "Top performer in Polling Unit mobilization across the southern sector.",
                icon: Icons.settings_suggest,
                iconColor: Colors.orange,
              ),
              _buildAchievementCard(
                context,
                title: "Accuracy Badge",
                desc:
                    "Maintained 99% data integrity in field reporting and voter verification.",
                icon: Icons.badge,
                iconColor: Theme.of(context).colorScheme.primary,
              ),

              const SizedBox(height: 30),
              // Next Milestone
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Next Milestone",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    "85% Complete",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSecondaryFixed,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Data Wizard II",
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                        Text(
                          "1,700 / 2,000 pts",
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: 0.85,
                      backgroundColor: Colors.white10,
                      valueColor: AlwaysStoppedAnimation(
                        Theme.of(context).colorScheme.primary,
                      ),
                      minHeight: 6,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
              // Locked Achievements
              _SectionHeader(title: "Locked Achievements"),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildLockedIcon(
                    context,
                    "Door-to-Door Guru",
                    Icons.door_front_door,
                  ),
                  _buildLockedIcon(
                    context,
                    "Midnight Mobilizer",
                    Icons.person_pin_circle,
                  ),
                  _buildLockedIcon(context, "Data Wizard III", Icons.list_alt),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAchievementCard(
    BuildContext context, {
    required String title,
    required String desc,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: context.isSmall ? EdgeInsets.all(10) : EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondaryFixed,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(color: iconColor, shape: BoxShape.circle),
            child: CircleAvatar(
              radius: context.isSmall ? 25 : 35,
              backgroundColor: Colors.black,
              child: Icon(
                icon,
                color: iconColor,
                size: context.isSmall ? 25 : 30,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLockedIcon(BuildContext context, String label, IconData icon) {
    return Column(
      children: [
        CircleAvatar(
          radius: context.isSmall ? 25 : 35,
          backgroundColor: Theme.of(context).colorScheme.onSecondaryFixed,
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 24,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: 80,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title, style: Theme.of(context).textTheme.bodyLarge),
    );
  }
}

class _QuickStat extends StatelessWidget {
  final String label, value;
  final Color? valueColor;
  const _QuickStat({required this.label, required this.value, this.valueColor});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? Theme.of(context).colorScheme.onSurface,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ],
    );
  }
}

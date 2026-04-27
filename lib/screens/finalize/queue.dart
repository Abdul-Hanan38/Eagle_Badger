import 'package:eagle_badger/utils/responsive_helper.dart';
import 'package:eagle_badger/widgets/custom_appbar.dart';
import 'package:eagle_badger/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class QueueScreen extends StatefulWidget {
  const QueueScreen({super.key});

  @override
  State<QueueScreen> createState() => _QueueScreenState();
}

class _QueueScreenState extends State<QueueScreen> {
  bool _isAutoSyncEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(
        title: 'Queue',
        onBackTap: () => Navigator.pop(context),
        actionIcon: Icons.info_rounded,
        actionColor: Theme.of(context).colorScheme.onSurface,
        onActionTap: () {},
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              // Auto-sync Status Card
              Container(
                padding: context.isSmall
                    ? EdgeInsets.all(10)
                    : EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSecondaryFixed,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: Theme.of(context).colorScheme.primary,
                          size: 10,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Auto-syncing when online",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Sync will resume once a stable connection is established.",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    SizedBox(height: context.isSmall ? 8 : 16),
                    SizedBox(
                      height: context.isSmall ? 30 : 60,
                      child: Transform.scale(
                        scale: context.isSmall ? 0.8 : 1.0,
                        child: Switch(
                          value: _isAutoSyncEnabled,
                          activeThumbColor: Colors.white,
                          activeTrackColor: const Color(0xFFC6102E),
                          inactiveThumbColor: Colors.grey,
                          inactiveTrackColor: Colors.black26,
                          onChanged: (val) =>
                              setState(() => _isAutoSyncEnabled = val),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: context.isSmall ? 15 : 30),

              // Pending Status Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "7 items pending upload",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    "0 / 7 COMPLETE",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.isSmall ? 8 : 12),
              // Progress Bar
              LinearProgressIndicator(
                value: 0.1,
                backgroundColor: Colors.white10,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFFC6102E),
                ),
                minHeight: 4,
              ),
              const SizedBox(height: 24),
              Text(
                "Pending Uploads",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              const SizedBox(height: 10),

              // Upload List
              Expanded(
                child: ListView(
                  children: [
                    _buildQueueItem(
                      "Voter Profile: John Doe",
                      "District 4 • 2 mins ago",
                      "assets/images/avator1.png",
                    ),
                    _buildQueueItem(
                      "Incident Report: Poll Access",
                      "West Station • 5 mins ago",
                      "assets/images/avator2.png",
                    ),
                    _buildQueueItem(
                      "Voter Status: Verified",
                      "Sarah Jenkins • 12 mins ago",
                      "assets/images/avator3.png",
                    ),
                    _buildQueueItem(
                      "Mobilization Sync",
                      "Block B-12 • 18 mins ago",
                      "assets/images/avator1.png",
                    ),
                    _buildQueueItem(
                      "Voter Profile: Michael Chen",
                      "District 2 • 25 mins ago",
                      "assets/images/avator2.png",
                    ),
                  ],
                ),
              ),

              // Retry Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CustomButton(
                  title: 'Retry All',
                  rightIcon: Icons.sync,
                  onPressed: () => Navigator.pushNamed(context, '/daySummary'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQueueItem(String title, String subtitle, String imgPath) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.tertiaryFixedDim,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: context.isSmall ? 15 : 20,
            backgroundColor: Theme.of(context).colorScheme.onSecondaryFixed,
            child: Image.asset(imgPath),
          ),
          SizedBox(width: context.isSmall ? 8 : 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.isSmall
                      ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        )
                      : Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: context.isSmall
                      ? Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        )
                      : Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondaryFixed,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Waiting",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

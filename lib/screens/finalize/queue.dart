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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Queue",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.info_rounded,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            // Auto-sync Status Card
            Container(
              padding: const EdgeInsets.all(20),
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
                  const SizedBox(height: 16),
                  Switch(
                    value: _isAutoSyncEnabled,
                    activeThumbColor: Colors.white,
                    activeTrackColor: const Color(0xFFC6102E),
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Colors.black26,
                    onChanged: (val) =>
                        setState(() => _isAutoSyncEnabled = val),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Pending Status Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "7 items pending upload",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  "0 / 7 COMPLETE",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
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
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Retry All",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.sync, color: Colors.white, size: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQueueItem(String title, String subtitle, String imgPath) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white10, width: 0.5)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Theme.of(context).colorScheme.onSecondaryFixed,
            child: Image.asset(imgPath),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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

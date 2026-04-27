import 'package:eagle_badger/utils/responsive_helper.dart';
import 'package:eagle_badger/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  final int contacted = 13;
  final int totalVoters = 20;
  final String pollingUnit = "PU: 02/14/05/001";

  @override
  Widget build(BuildContext context) {
    double progressPercent = contacted / totalVoters;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              Row(
                children: [
                  CircleAvatar(
                    radius: context.isSmall ? 15 : 25,
                    backgroundImage: AssetImage(
                      'assets/images/user_profile.png',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Field Agent",
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          "Good morning, Sharon",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: context.isSmall
                        ? EdgeInsets.all(4)
                        : EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSecondaryFixedVariant,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.notifications,
                      color: Theme.of(context).colorScheme.onSurface,
                      size: context.isSmall ? 15 : 30,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // --- SYNC STATUS CARD ---
              Container(
                padding: context.isSmall
                    ? EdgeInsets.all(7)
                    : EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.tertiaryFixedDim,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Theme.of(context).colorScheme.onSurface,
                      size: context.isSmall ? 15 : 30,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Sync Status: Online",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.circle,
                      color: Theme.of(context).colorScheme.tertiaryFixed,
                      size: context.isSmall ? 4 : 8,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "Live",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.tertiaryFixedDim,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          child: Image.asset(
                            'assets/images/map_placeholder.png',
                            height: context.isSmall ? 120 : 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withValues(alpha: 0.8),
                                  Colors.transparent,
                                ],
                                stops: const [0.0, 0.4],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 18,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(174, 198, 16, 46),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "Primary Zone",
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(
                                    color: Color.fromARGB(229, 255, 255, 255),
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Assigned Polling Unit",
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "PU: 02/14/05/001",
                            style: Theme.of(context).textTheme.titleSmall!
                                .copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Location Info
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                    size: context.isSmall ? 14 : 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "Central High School",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onPrimary,
                                        ),
                                  ),
                                ],
                              ),

                              // Map Button
                              ElevatedButton.icon(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.onSecondaryFixed,
                                  foregroundColor: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                  elevation: 0,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: context.isSmall ? 10 : 12,
                                    vertical: context.isSmall ? 6 : 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSecondaryFixedVariant,
                                    ),
                                  ),
                                ),
                                icon: Icon(
                                  Icons.map,
                                  size: context.isSmall ? 14 : 16,
                                ),
                                label: Text(
                                  "Map",
                                  style: Theme.of(context).textTheme.bodyMedium!
                                      .copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
              Center(
                child: Text(
                  "Today's Performance",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // --- CIRCULAR PROGRESS GRAPH ---
              Center(
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: progressPercent),
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: context.isSmall ? 120 : 150,
                          width: context.isSmall ? 120 : 150,
                          child: CircularProgressIndicator(
                            value: value,
                            strokeWidth: context.isSmall ? 8 : 12,
                            backgroundColor: Colors.black,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${(value * 100).toInt()}%",
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                  ),
                            ),
                            Text(
                              "Complete",
                              style: Theme.of(context).textTheme.bodySmall!
                                  .copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 30),

              Row(
                children: [
                  _buildStatBox(context, "13", "Contacted"),
                  const SizedBox(width: 15),
                  _buildStatBox(context, "07", "Remaining"),
                ],
              ),

              const SizedBox(height: 25),

              // --- CANVAS TARGET BAR ---
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSecondaryFixedVariant,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Canvas Target",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "$contacted of $totalVoters voters",
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: progressPercent,
                      backgroundColor: Colors.white10,
                      color: Color.fromARGB(255, 234, 40, 49),
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60),

              Center(
                child: CustomButton(
                  title: 'Start Field Work',
                  leftIcon: Icons.play_arrow,
                  onPressed: () => Navigator.pushNamed(context, '/dailyRoute'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatBox(BuildContext context, String value, String label) {
    return Expanded(
      child: Container(
        padding: context.isSmall
            ? EdgeInsets.symmetric(horizontal: 6, vertical: 12)
            : EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiaryContainer,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
          ),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

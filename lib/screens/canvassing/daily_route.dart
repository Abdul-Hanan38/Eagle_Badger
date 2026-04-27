import 'package:eagle_badger/utils/responsive_helper.dart';
import 'package:eagle_badger/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class AiDailyRouteScreen extends StatefulWidget {
  const AiDailyRouteScreen({super.key});

  @override
  State<AiDailyRouteScreen> createState() => _AiDailyRouteScreenState();
}

class _AiDailyRouteScreenState extends State<AiDailyRouteScreen> {
  Widget _mapButton(
    IconData icon, {
    bool isTop = false,
    bool isBottom = false,
    bool isStandalone = false,
  }) {
    return Container(
      width: context.isSmall ? 30 : 40,
      height: context.isSmall ? 30 : 40,
      decoration: BoxDecoration(
        color: const Color(0xFF1A0F0F).withValues(alpha: 0.9),
        borderRadius: isStandalone
            ? BorderRadius.circular(8)
            : BorderRadius.vertical(
                top: isTop ? const Radius.circular(8) : Radius.zero,
                bottom: isBottom ? const Radius.circular(8) : Radius.zero,
              ),
        border: Border.all(color: Colors.white10, width: 0.5),
      ),
      child: Icon(
        icon,
        color: Theme.of(context).colorScheme.onSurface,
        size: context.isSmall ? 20 : 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),

                      // --- HEADER ---
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.arrow_back_ios_new,
                              color: Theme.of(context).colorScheme.onSurface,
                              size: context.isSmall ? 18 : 20,
                            ),
                          ),
                          const SizedBox(width: 50),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "AI Daily Route",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                Text(
                                  "District 4 Active",
                                  style: Theme.of(context).textTheme.bodyMedium!
                                      .copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 48),
                        ],
                      ),

                      const SizedBox(height: 25),

                      // --- MAP CARD ---
                      Container(
                        width: double.infinity,
                        height: context.isSmall ? 200 : 250,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                        child: ClipRRect(
                          child: Stack(
                            children: [
                              // 1. BASE MAP IMAGE
                              Image.asset(
                                'assets/images/map_placeholder.png',
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),

                              // 2. TOP GRADIENT SHADOW (For Search Bar readability)
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.black.withValues(alpha: 0.7),
                                        Colors.transparent,
                                      ],
                                      stops: const [0.0, 0.3],
                                    ),
                                  ),
                                ),
                              ),

                              // 3. SEARCH BAR
                              Positioned(
                                top: 15,
                                left: 15,
                                right: 15,
                                child: Container(
                                  height: context.isSmall ? 35 : 45,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer
                                        .withValues(alpha: 0.9),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.tertiaryFixedDim,
                                    ),
                                  ),
                                  child: Row(
                                    // Ensure the Row itself doesn't add odd stretching
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Wrap Icon in a SizedBox to match the Text's height footprint
                                      SizedBox(
                                        height: context.isSmall ? 15 : 20,
                                        child: Icon(
                                          Icons.search,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                          size: context.isSmall ? 15 : 20,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: TextField(
                                          // Use 'textAlignVertical' to force the cursor and text to the absolute middle
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.onSurface,
                                                height:
                                                    1.0, // Removes extra leading from the font
                                                fontSize: context.isSmall
                                                    ? 14
                                                    : 16,
                                              ),
                                          decoration: InputDecoration(
                                            hintText: "Search route address",
                                            hintStyle: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.primaryFixed,
                                                  height:
                                                      1.0, // Must match the style's height
                                                  fontSize: context.isSmall
                                                      ? 14
                                                      : 16,
                                                ),
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            // 'isCollapsed' is more aggressive than 'isDense' for centering
                                            isCollapsed: true,
                                            contentPadding: EdgeInsets.zero,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // 4. PRIMARY ZONE BADGE (Left side)
                              Positioned(
                                left: 12,
                                top: 85,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.primary
                                        .withValues(alpha: 0.8),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "Primary Zone",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withValues(alpha: 0.8),
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              // 5. MAP CONTROLS (Right side)
                              Positioned(
                                right: 12,
                                bottom: 12,
                                child: Column(
                                  children: [
                                    _mapButton(Icons.add, isStandalone: true),
                                    const SizedBox(height: 5),
                                    _mapButton(Icons.remove),
                                    const SizedBox(height: 10),
                                    _mapButton(
                                      Icons.navigation,
                                      isStandalone: true,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      // --- ROUTE DETAILS SECTION ---
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.screenWidth * 0.03,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Current Route",
                                  style: Theme.of(context).textTheme.bodyMedium!
                                      .copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onPrimary,
                                      ),
                                ),
                                SizedBox(height: 4),
                                SizedBox(
                                  width: context.isSmall ? 150 : 200,
                                  child: Text(
                                    "North Precinct Mobilization",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleSmall,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: context.isSmall ? 90 : 110,
                              height: context.isSmall ? 35 : 40,
                              padding: EdgeInsets.symmetric(
                                horizontal: context.isSmall ? 12 : 14,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onTertiaryFixed,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),

                              child: Text(
                                "6 Stops Remaining",
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.bodySmall!
                                    .copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.screenWidth * 0.03,
                        ),
                        child: Column(
                          children: [
                            Divider(
                              color: Theme.of(
                                context,
                              ).colorScheme.tertiaryFixedDim,
                            ),
                            IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildStatColumn("1.2", "Miles"),
                                  const VerticalDivider(
                                    color: Colors.white10,
                                    thickness: 1,
                                    indent: 5,
                                    endIndent: 5,
                                  ),
                                  _buildStatColumn("45", "Mins"),
                                  const VerticalDivider(
                                    color: Colors.white10,
                                    thickness: 1,
                                    indent: 5,
                                    endIndent: 5,
                                  ),
                                  _buildStatColumn("14", "Voters"),
                                ],
                              ),
                            ),
                            Divider(
                              color: Theme.of(
                                context,
                              ).colorScheme.tertiaryFixedDim,
                            ),
                            const SizedBox(height: 20),

                            // --- PRIORITY TEXT ---
                            Row(
                              children: [
                                Text(
                                  '!',
                                  style: Theme.of(context).textTheme.titleSmall!
                                      .copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                ),
                                SizedBox(width: context.screenWidth * 0.03),
                                Text(
                                  '3 Priority Households & Influencer Stops',
                                  style: Theme.of(context).textTheme.bodyMedium!
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
                        ),
                      ),

                      const SizedBox(height: 20),

                      // --- ADDRESS ENTRY ---
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.screenWidth * 0.03,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Theme.of(
                                context,
                              ).colorScheme.tertiaryFixedDim,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Manual Address Entry",
                                style: Theme.of(context).textTheme.bodySmall!
                                    .copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                    ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Theme.of(
                                    context,
                                  ).colorScheme.tertiaryFixedDim,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onPrimary,
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.location_on,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primaryFixed,
                                    size: 20,
                                  ),
                                  hintText: "Enter Target Address",
                                  hintStyle: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primaryFixed,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Center(
                                child: Text(
                                  "GPS coordinates will be automatically generated on entery",
                                  style: Theme.of(context).textTheme.bodySmall!
                                      .copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primaryFixed,
                                        fontSize: context.isSmall ? 8 : 10,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const Spacer(), // Pushes the button to the bottom
                      const SizedBox(height: 20),

                      // --- START BUTTON ---
                      Center(
                        child: CustomButton(
                          title: 'Start Route',
                          leftIcon: Icons.play_arrow,
                          onPressed: () =>
                              Navigator.pushNamed(context, '/localPulse'),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatColumn(String value, String label) {
    return Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.titleSmall),
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

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
      width: 40,
      height: 40,
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
        color: Colors.white,
        size: 30,
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
                hasScrollBody: false, // Allows content to be bigger than screen
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
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 50),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "AI Daily Route",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "District 4 Active",
                                  style: TextStyle(
                                    color: Color(0xFFC6102E),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 48), // Balance for back button
                        ],
                      ),

                      const SizedBox(height: 25),

                      // --- MAP CARD ---
                      Container(
                        width: double.infinity,
                        height:
                            250, // Increased height to fit all map UI elements
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF423436)),
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
                                  height: 45,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFF1A0F0F,
                                    ).withValues(alpha: 0.9),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.white10),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.search,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: TextField(
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            height: 1.0,
                                          ),
                                          cursorColor: const Color(0xFFC6102E),
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          decoration: const InputDecoration(
                                            hintText: "Search route address",
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16,
                                            ),
                                            // Remove the default underline and borders
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            contentPadding: EdgeInsets
                                                .zero, // Centers text vertically
                                            isDense: true,
                                          ),
                                          onSubmitted: (value) {
                                            // Handle search logic here
                                            print("Searching for: $value");
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // 4. PRIMARY ZONE BADGE (Left side)
                              Positioned(
                                left: 12,
                                top: 85, // Adjusted to sit below the search bar
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFC6102E),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    "Primary Zone",
                                    style: TextStyle(
                                      color: Colors.white,
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
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Current Route",
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Container(
                                  width: 200,
                                  child: Text(
                                    "North Precinct Mobilization",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      height: 1.1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 100,
                              height: 40,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF381A1A),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),

                              child: const Text(
                                "6 Stops Remaining",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            const Divider(color: Colors.white10),
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
                            const Divider(color: Colors.white10),
                            const SizedBox(height: 20),

                            // --- PRIORITY TEXT ---
                            Row(
                              children: [
                                Text(
                                  '!',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                ),
                                SizedBox(width: 20),
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
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color.fromARGB(138, 91, 90, 90),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Manual Address Entry",
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white10,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: const Color.fromARGB(
                                        138,
                                        103,
                                        103,
                                        103,
                                      ),
                                    ),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.location_on,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  hintText: "Enter Target Address",
                                  hintStyle: const TextStyle(
                                    color: Colors.grey,
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
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
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
                        child: SizedBox(
                          width: 350,
                          height: 56,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pushNamed(context, '/localPulse');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFC6102E),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                            label: const Text(
                              "Start Route",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
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
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

import 'package:eagle_badger/utils/responsive_helper.dart';
import 'package:eagle_badger/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'resident_tile.dart';

class FieldSurveyScreen extends StatelessWidget {
  const FieldSurveyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(color: Theme.of(context).colorScheme.secondary),
            ),

            Expanded(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // --- MAP & ADDRESS CARD ---
                  SliverToBoxAdapter(child: _buildLocationCard(context)),

                  // --- RESIDENTS HEADER ---
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Residents",
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(fontSize: context.isSmall ? 16 : 18),
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.schedule,
                              color: Theme.of(context).colorScheme.primary,
                              size: 16,
                            ),
                            label: Text(
                              "History",
                              style: Theme.of(context).textTheme.bodyLarge!
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
                  ),

                  // --- RESIDENT LIST ---
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        const ResidentTile(
                          name: "John Doe",
                          age: "45",
                          voterId: "8829-X",
                          statusColor: Colors.green,
                          imageUrl: 'assets/images/avator1.png',
                        ),
                        const ResidentTile(
                          name: "Jane Doe",
                          age: "42",
                          voterId: "8830-Y",
                          statusColor: Colors.orange,
                          imageUrl: 'assets/images/avator2.png',
                        ),
                      ]),
                    ),
                  ),

                  // --- SAFETY NOTE ---
                  SliverToBoxAdapter(child: _buildSafetyNote()),

                  // Bottom padding for scroll
                  const SliverToBoxAdapter(child: SizedBox(height: 100)),
                ],
              ),
            ),
          ],
        ),
      ),
      // --- Navigation BUTTON ---
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: CustomButton(
            title: 'Start Interaction',
            leftIcon: Icons.play_arrow,
            onPressed: () => Navigator.pushNamed(context, '/voterProfiling'),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Theme.of(context).colorScheme.onSurface,
              size: context.isSmall ? 18 : 20,
            ),
          ),
          SizedBox(width: context.screenWidth * 0.05),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ward 12 - Neighborhood",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  "Campaign Route Alpha",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).colorScheme.onSurface,
              size: context.isSmall ? 20 : 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondaryFixed,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Static Map Placeholder
          ClipRRect(
            child: Image.asset(
              'assets/images/map_placeholder.png',
              height: context.screenHeight * 0.20,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildBadge(
                      "Priority Household",
                      const Color.fromARGB(57, 198, 16, 46),
                      const Color.fromARGB(255, 198, 16, 46),
                    ),
                    Text(
                      "HH-90210",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.screenHeight * 0.01),
                Text(
                  "123 Liberty Lane",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: context.screenHeight * 0.01),
                Divider(color: Theme.of(context).colorScheme.secondary),
                SizedBox(height: context.screenHeight * 0.01),
                Row(
                  children: [
                    _buildIconLabel(
                      context,
                      Icons.groups,
                      "3 Voters",
                      Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 20),
                    _buildIconLabel(
                      context,
                      Icons.check_circle,
                      "Strong Lean",
                      Theme.of(context).colorScheme.tertiaryFixed,
                    ),
                  ],
                ),
                SizedBox(height: context.screenHeight * 0.01),
                Divider(color: Theme.of(context).colorScheme.secondary),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSafetyNote() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.yellow.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.yellow.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Safety Note",
            style: TextStyle(
              color: Colors.orange[300],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Large dog in backyard. Use side gate only if necessary. Doorbell is disconnected.",
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color bg, Color textCol) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textCol,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildIconLabel(
    BuildContext context,
    IconData icon,
    String text,
    Color color,
  ) {
    return Row(
      children: [
        Icon(icon, color: color, size: context.isSmall ? 16 : 18),
        const SizedBox(width: 6),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

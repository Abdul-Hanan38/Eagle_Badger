import 'package:eagle_badger/utils/responsive_helper.dart';
import 'package:eagle_badger/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class SocioCulturalBlocsScreen extends StatelessWidget {
  const SocioCulturalBlocsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(
        title: 'Socio-Culture Blocs',
        onBackTap: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: "Search influence groups...",
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primaryFixed,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.onSecondaryFixed,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiaryFixedDim,
                      width: 0.5,
                    ),
                  ),
                  // Border state when clicked
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1.0, // Slightly thicker only when active
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildBlocCard(
                      context,
                      "Markets",
                      "12 Registered",
                      Icons.account_balance,
                    ),
                    _buildBlocCard(
                      context,
                      "Mosques",
                      "8 Registered",
                      Icons.mosque,
                    ),
                    _buildBlocCard(
                      context,
                      "Churches",
                      "15 Registered",
                      Icons.church,
                    ),
                    _buildBlocCard(
                      context,
                      "CDAs",
                      "6 Registered",
                      Icons.groups,
                    ),
                    _buildBlocCard(
                      context,
                      "Youth Groups",
                      "20 Registered",
                      Icons.grid_view,
                    ),
                    _buildAddCategoryCard(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildBlocCard(
    BuildContext context,
    String title,
    String count,
    IconData icon,
  ) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/blocDetails');
      },
      child: Container(
        padding: context.isSmall ? EdgeInsets.all(16) : EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
                size: context.isSmall ? 18 : 24,
              ),
            ),
            const Spacer(),
            Text(title, style: Theme.of(context).textTheme.bodyLarge),
            Text(count, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }

  Widget _buildAddCategoryCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.tertiaryFixedDim,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_circle_outline,
            color: Theme.of(context).colorScheme.primary,
            size: 30,
          ),
          const SizedBox(height: 10),
          Text(
            "Add Category",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return SafeArea(
      child: BottomNavigationBar(
        currentIndex: 1,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onPrimary,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/fieldWork');
              break;
            case 1:
              // Remain on the current reporting flow
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/fieldWork');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/fieldWork');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: "Activity",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Alerts",
          ),
        ],
      ),
    );
  }
}

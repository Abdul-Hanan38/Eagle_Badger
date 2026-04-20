import 'package:flutter/material.dart';

class SocioCulturalBlocsScreen extends StatelessWidget {
  const SocioCulturalBlocsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
          size: 20,
        ),
        title: const Text(
          "Socio-Cultural Blocs",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Padding(
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
                prefixIcon: const Icon(Icons.search, color: Color(0xFFC6102E)),
                filled: true,
                fillColor: Theme.of(context).colorScheme.onSecondaryFixed,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.white10, width: 0.5),
                ),
                // Border state when clicked
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFFC6102E),
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
                  _buildBlocCard(context, "CDAs", "6 Registered", Icons.groups),
                  _buildBlocCard(
                    context,
                    "Youth Groups",
                    "20 Registered",
                    Icons.grid_view,
                  ),
                  _buildAddCategoryCard(),
                ],
              ),
            ),
          ],
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
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF1C222D),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF2D1F1F),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: const Color(0xFFC6102E), size: 24),
            ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              count,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddCategoryCard() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white10, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_circle_outline,
            color: const Color(0xFFC6102E),
            size: 30,
          ),
          const SizedBox(height: 10),
          const Text(
            "Add Category",
            style: TextStyle(
              color: Color(0xFFC6102E),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return BottomNavigationBar(
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
        BottomNavigationBarItem(icon: Icon(Icons.analytics), label: "Activity"),
        BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: "Alerts",
        ),
      ],
    );
  }
}

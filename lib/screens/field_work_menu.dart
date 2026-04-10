import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../widgets/field_menu_card.dart';

class FieldWorkMenuScreen extends StatelessWidget {
  const FieldWorkMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "GPS Active",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.onSurface,
                    size: 28,
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    "Field Work Menu",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 48),
                child: Text(
                  "Select what you want to do",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 30),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
                children: [
                  FieldMenuCard(
                    title: "Door-to-Door Canvassing",
                    icon: Symbols.door_front,
                    backgroundColor: Color.fromARGB(255, 102, 126, 167),
                    actions: {
                      "CANVASSING": () =>
                          Navigator.pushNamed(context, '/canvassing'),
                      "FIELD SURVEYS": () =>
                          Navigator.pushNamed(context, '/fieldSurvey'),
                    },
                  ),
                  FieldMenuCard(
                    title: "Street Intelligence",
                    icon: Symbols.person_pin_circle,
                    backgroundColor: Color(0xFF7D2D36),
                    actions: {
                      "SURVEY": () => Navigator.pushNamed(context, '/survey'),
                    },
                  ),
                  FieldMenuCard(
                    title: "Influencer / Bloc Capture",
                    icon: Symbols.groups,
                    backgroundColor: Color(0xFF2D1B1B),
                    actions: {
                      "CONTACT": () => Navigator.pushNamed(context, '/contact'),
                    },
                  ),
                  FieldMenuCard(
                    title: "Incident Reporting",
                    icon: Symbols.accessibility_new,
                    backgroundColor: Color(0xFF4E5441),
                    actions: {
                      "REPORT": () => Navigator.pushNamed(context, '/report'),
                    },
                  ),
                  FieldMenuCard(
                    title: "Election Day & Results",
                    icon: Symbols.ballot,
                    backgroundColor: Color(0xFF8B5A34),
                    actions: {
                      "TALLY": () => Navigator.pushNamed(context, '/tally'),
                    },
                  ),
                  FieldMenuCard(
                    title: "Offline & End-of-Day",
                    icon: Symbols.sync_alt,
                    backgroundColor: Color(0xFF526D72),
                    actions: {
                      "FINALIZE": () =>
                          Navigator.pushNamed(context, '/finalize'),
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(Icons.sync, color: Colors.red, size: 16),
                      SizedBox(width: 8),
                      Text(
                        "Last sync: 2 min ago",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "All actions are time-stamped and location-verified",
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

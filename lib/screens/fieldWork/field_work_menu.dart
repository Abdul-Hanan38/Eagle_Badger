import 'package:eagle_badger/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../widgets/field_menu_card.dart';

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
                        width: context.isSmall ? 4 : 8,
                        height: context.isSmall ? 4 : 8,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.tertiaryFixed,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "GPS Active",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiaryFixed,
                          fontSize: context.isSmall ? 8 : 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.onSurface,
                    size: context.isSmall ? 18 : 28,
                  ),
                ],
              ),

              const SizedBox(height: 10),
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
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 48),
                child: Text(
                  "Select what you want to do",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Divider(
                color: Theme.of(context).colorScheme.secondary,
                thickness: 1,
              ),

              const SizedBox(height: 10),
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
                    icon: Icons.door_front_door,
                    backgroundColor: Color.fromARGB(255, 102, 126, 167),
                    actions: {
                      "CANVASSING": () =>
                          Navigator.pushNamed(context, '/dashboard'),
                      "FIELD SURVEYS": () =>
                          Navigator.pushNamed(context, '/fieldSurvey'),
                    },
                  ),
                  FieldMenuCard(
                    title: "Street Intelligence",
                    icon: Icons.person_pin_circle_outlined,
                    backgroundColor: Color(0xFF7D2D36),
                    actions: {
                      "SURVEY": () =>
                          Navigator.pushNamed(context, '/posterReport'),
                    },
                  ),
                  FieldMenuCard(
                    title: "Influencer / Bloc Capture",
                    icon: Icons.groups,
                    backgroundColor: Color(0xFF2D1B1B),
                    actions: {
                      "CONTACT": () =>
                          Navigator.pushNamed(context, '/socioCulture'),
                    },
                  ),
                  FieldMenuCard(
                    title: "Incident Reporting",
                    icon: Icons.accessibility_new_outlined,
                    backgroundColor: Color(0xFF4E5441),
                    actions: {
                      "REPORT": () =>
                          Navigator.pushNamed(context, '/reportIncident'),
                    },
                  ),
                  FieldMenuCard(
                    title: "Election Day & Results",
                    icon: Icons.poll,
                    backgroundColor: Color(0xFF8B5A34),
                    actions: {
                      "TALLY": () =>
                          Navigator.pushNamed(context, '/activityFlow'),
                    },
                  ),
                  FieldMenuCard(
                    title: "Offline & End-of-Day",
                    icon: Icons.sync_alt,
                    backgroundColor: Color(0xFF526D72),
                    actions: {
                      "FINALIZE": () => Navigator.pushNamed(context, '/queue'),
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Divider(color: Theme.of(context).colorScheme.secondary),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      SizedBox(width: 10),
                      Icon(Icons.sync, color: Colors.red, size: 16),
                      SizedBox(width: 10),
                      Text(
                        "Last sync: 2 min ago",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: const Text(
                      "All actions are time-stamped and location-verified",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
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

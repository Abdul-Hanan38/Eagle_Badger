import 'package:flutter/material.dart';
import '../widgets/language_card.dart';
import '../screens/help_screen.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String? selectedId = 'l1';

  final List<(String id, String title)> languages = [
    ('l1', 'English'),
    ('l2', 'Hausa (Harshen Hausa)'),
    ('l3', 'Yoruba (Èdè Yorùbá)'),
    ('l4', 'Igbo (Asusų Igbo)'),
    ('l5', 'Pidgin (Naija Pidgin)'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 15),
          child: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).colorScheme.onSurface,
                size: 20,
              ),
              onPressed: () {},
            ),
            titleSpacing: 0,
            title: Text(
              'Onboarding',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pushNamed('/help'),
                child: Text(
                  'Help',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: Theme.of(context).colorScheme.secondary,
              thickness: 1,
            ),
            const SizedBox(height: 20),
            Text(
              'Select Your Preferred Language',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Text(
              'Choose the language you will use to communicate with voters and record data in the field.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),

            Expanded(
              child: ListView.builder(
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  final lang = languages[index];
                  return LanguageCard(
                    title: lang.$2,
                    isSelected: selectedId == lang.$1,
                    onTap: () {
                      setState(() {
                        selectedId = lang.$1;
                      });
                    },
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 30, top: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/login');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Confirm & Proceed',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

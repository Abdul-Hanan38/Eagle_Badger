import 'package:eagle_badger/utils/responsive_helper.dart';
import 'package:eagle_badger/widgets/custom_appbar.dart';
import 'package:eagle_badger/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import '../../widgets/language_card.dart';

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
      appBar: CustomAppBar(
        title: 'Onboarding',
        onBackTap: () {},
        actionText: 'Help',
        onActionTap: () => Navigator.pushNamed(context, '/reportIncident'),
      ),
      body: SafeArea(
        child: Padding(
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
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
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

              CustomButton(
                title: 'Confirm & Proceed',
                rightIcon: Icons.arrow_forward,
                onPressed: () => Navigator.pushNamed(context, '/login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

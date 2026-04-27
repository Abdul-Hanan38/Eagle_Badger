import 'package:eagle_badger/utils/responsive_helper.dart';
import 'package:eagle_badger/widgets/custom_appbar.dart';
import 'package:eagle_badger/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:eagle_badger/widgets/permission_card.dart';
import 'package:material_symbols_icons/symbols.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  bool isMappingEnabled = false;
  bool isCameraEnabled = false;
  bool isMicEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Permission',
        onBackTap: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                Center(
                  child: Text(
                    'Equip your field tools',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Enable these features to start mobilizing your precinct effectively. High-fidelity data collection starts here",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    PermissionCard(
                      title: "Precision Mapping",
                      description:
                          "Identify precinct boundaries and log door-knocking activity.",
                      icon: Icons.person_search,
                      isEnabled: isMappingEnabled,
                      onChanged: (val) =>
                          setState(() => isMappingEnabled = val),
                    ),
                    PermissionCard(
                      title: "Document Insights",
                      description:
                          "Scan voter IDs and capture campaign event media for the intel team.",
                      icon: Icons.camera_alt,
                      isEnabled: isCameraEnabled,
                      onChanged: (val) => setState(() => isCameraEnabled = val),
                    ),
                    PermissionCard(
                      title: "Voice Memos",
                      description:
                          "Quickly record field notes without typing while you are on the move.",
                      icon: Icons.mic,
                      isEnabled: isMicEnabled,
                      onChanged: (val) => setState(() => isMicEnabled = val),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.isSmall ? 20 : 35,
                    vertical: context.isSmall ? 10 : 20,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Offline-First security',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'All data is encrypted and saved locally first. Synchronization with central HQ occurs automatically once a secure connection is established.',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Bottom Navigation Button.
                CustomButton(
                  title: 'Continue to Field Map',
                  rightIcon: Icons.arrow_forward,
                  onPressed: () => Navigator.pushNamed(context, '/fieldWork'),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

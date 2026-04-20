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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 15),
          child: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            centerTitle: true,
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).colorScheme.onSurface,
                size: 20,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            titleSpacing: 0,
            title: Text(
              'Permission',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
        ),
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
                  thickness: 2,
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
                      icon: Symbols.interpreter_mode,
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 35,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color.fromARGB(30, 243, 150, 166),
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/fieldWork');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Continue to Field Map',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

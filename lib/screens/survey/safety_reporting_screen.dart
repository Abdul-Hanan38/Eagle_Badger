import 'package:flutter/material.dart';
import 'survey_flow_screen.dart';

class SafetyReportingScreen extends StatefulWidget {
  const SafetyReportingScreen({super.key});

  @override
  State<SafetyReportingScreen> createState() => _SafetyReportingScreenState();
}

class _SafetyReportingScreenState extends State<SafetyReportingScreen> {
  // Track the current selection index
  int? _selectedIndex;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage('assets/images/safety1.png'), context);
    precacheImage(const AssetImage('assets/images/safety2.png'), context);
    precacheImage(const AssetImage('assets/images/safety3.png'), context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 22,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Safety Reporting",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            "Field Intelligence",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Any fear or intimidation observed?",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          Text(
            "Select the level of tension at your current location to update the command center.",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),

          const SizedBox(height: 25),
          _safetyCard(
            context,
            index: 0,
            title: "None",
            color: Colors.green,
            icon: Icons.check_circle_outline,
            img: 'assets/images/safety1.png',
          ),
          _safetyCard(
            context,
            index: 1,
            title: "Low",
            color: Colors.amber,
            icon: Icons.warning_amber_rounded,
            img: 'assets/images/safety2.png',
          ),
          _safetyCard(
            context,
            index: 2,
            title: "High",
            color: Colors.red,
            icon: Icons.error_outline_rounded,
            img: 'assets/images/safety3.png',
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SurveyFlowScreen()),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC6102E),
              minimumSize: const Size(double.infinity, 54),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "Submit Field Report",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color.fromARGB(30, 243, 150, 166),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Verification works offline via secure local protocol. Your data will sync once a connection is established.',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _safetyCard(
    BuildContext context, {
    required int index,
    required String title,
    required Color color,
    required IconData icon,
    required String img,
  }) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondaryFixed,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(icon, color: color, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSecondary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Select",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                img,
                width: 80,
                height: 100,
                fit: BoxFit.cover,
                cacheWidth: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

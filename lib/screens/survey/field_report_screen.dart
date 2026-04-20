import 'package:flutter/material.dart';
import 'safety_reporting_screen.dart';

class FieldReportScreen extends StatefulWidget {
  const FieldReportScreen({super.key});

  @override
  State<FieldReportScreen> createState() => _FieldReportScreenState();
}

class _FieldReportScreenState extends State<FieldReportScreen> {
  int? _selectedIndex;

  void _next(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SafetyReportingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
          "Field Report",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildStepIndicator(context),
            const SizedBox(height: 30),
            Text(
              "Has this poster been here long?",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            Text(
              "Intelligence gathering step 2 of 4",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            const SizedBox(height: 120),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _circleOption(
                  index: 0,
                  icon: Icons.check_circle,
                  label: "Yes",
                  sub: "Established content",
                ),
                _circleOption(
                  index: 1,
                  icon: Icons.cancel,
                  label: "No",
                  sub: "Recently placed",
                ),
              ],
            ),
            const SizedBox(height: 120),
            ElevatedButton(
              onPressed: () => _next(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "I'm not sure / Skip",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator(BuildContext context) {
    return Row(
      children: List.generate(
        4,
        (i) => Expanded(
          child: Container(
            height: 4,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            color: i == 1
                ? Theme.of(context).colorScheme.primary
                : Colors.white10,
          ),
        ),
      ),
    );
  }

  Widget _circleOption({
    required int index,
    required IconData icon,
    required String label,
    required String sub,
  }) {
    bool isSelected = _selectedIndex == index;
    Color activeColor = const Color(0xFFC6102E);
    Color inactiveColor = Colors.white10;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        Future.delayed(const Duration(milliseconds: 300), () => _next(context));
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: isSelected ? activeColor : inactiveColor,
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(sub, style: const TextStyle(color: Colors.grey, fontSize: 10)),
        ],
      ),
    );
  }
}

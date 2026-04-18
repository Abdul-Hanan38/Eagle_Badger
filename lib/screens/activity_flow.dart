import 'package:flutter/material.dart';

class ActivityFlowScreen extends StatefulWidget {
  const ActivityFlowScreen({super.key});

  @override
  State<ActivityFlowScreen> createState() => _ActivityFlowScreenState();
}

class _ActivityFlowScreenState extends State<ActivityFlowScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  // Interaction list and current session data
  List<Map<String, dynamic>> allActivityLogs = [];
  Map<String, dynamic> gatheredData = {};

  void _onSelectionMade(String key, dynamic value) {
    setState(() => gatheredData[key] = value);

    Future.delayed(const Duration(milliseconds: 300), () {
      if (_currentStep < 6) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      } else {
        _finishActivity();
      }
    });
  }

  // UPDATED: Saves to list and triggers the success dialog
  void _finishActivity() {
    setState(() {
      allActivityLogs.add({
        ...gatheredData,
        'timestamp': DateTime.now().toString(),
      });
    });

    _showSuccessDialog();
  }

  // NEW: Success Dialog with Checkmark Animation
  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF251111),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 1000),
          tween: Tween(begin: 0.0, end: 1.0),
          curve: Curves.easeInOutQuart,
          builder: (context, value, child) {
            return Center(
              child: CustomPaint(
                size: const Size(80, 80),
                painter: CheckmarkPainter(value),
              ),
            );
          },
        ),
        content: const Text(
          "Activity Log Saved Successfully!",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context); // Close Dialog
                Navigator.pop(context); // Return to Dashboard/Activity Screen
              },
              child: const Text(
                "Done",
                style: TextStyle(
                  color: Color(0xFFC6102E),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
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
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          _getTitle(),
          style: const TextStyle(color: Colors.white, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (i) => setState(() => _currentStep = i),
        children: [
          _buildArrivalDetection(),
          _buildArrivalStatus(),
          _buildBinaryStatus("Has the polling unit opened?", "pu_open"),
          _buildOpeningDayTasks(),
          _buildPresenceCheck(),
          _buildQueueStatus(),
          _buildPollMonitor(),
        ],
      ),
    );
  }

  String _getGreeting() =>
      "Good morning Sharon, I see you're near your polling unit.";

  String _getTitle() {
    List<String> titles = [
      "Arrival Detection",
      "Arrival Status",
      "PU Open Status",
      "Opening Day Tasks",
      "Presence Check",
      "Queue Status",
      "Poll Monitor",
    ];
    return titles[_currentStep];
  }

  // --- YOUR EXISTING UI METHODS (RETAINED) ---

  Widget _buildArrivalDetection() {
    return _buildBaseLayout(
      title: _getGreeting(),
      content: Column(
        children: [
          Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            child: Image.asset('assets/images/location.png'),
          ),
          const SizedBox(height: 20),
          _buildStaticInfoTile(
            Icons.location_on,
            "GPS: 6.5244° N, 3.3792° E",
            "Active",
            Colors.green,
          ),
          const SizedBox(height: 20),
          Text(
            'The system has detected that you are within 50 meters of Polling Unit 04-12-09. Please confirm arrival to begin.',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          const SizedBox(height: 50),
          _buildSubmitButton(
            "Begin Check-In",
            () => _onSelectionMade("init", true),
          ),
        ],
      ),
    );
  }

  Widget _buildArrivalStatus() {
    return _buildBaseLayout(
      title: "Have you arrived at the polling unit?",
      subtitle: "Polling Unit: Ward 04, Unit 021",
      content: Column(
        children: [
          _buildSelectionCard(
            "Yes, I am here",
            Icons.check_circle,
            "arrival",
            "Yes",
          ),
          _buildSelectionCard(
            "No, not yet",
            Icons.access_time_filled,
            "arrival",
            "No",
          ),
          const SizedBox(height: 20),
          _buildStaticInfoTile2(
            "Location Check",
            "Based on your GPS, you are 256m away",
          ),
          const SizedBox(height: 30),
          Text(
            '? Need help finding the unit?',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildBinaryStatus(String title, String key) {
    return _buildBaseLayout(
      title: title,
      content: Column(
        children: [
          _buildWideActionBtn("YES", key, "Yes", Icons.check),
          _buildWideActionBtn("NO", key, "No", Icons.close),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.white, size: 18),
              const SizedBox(width: 8),
              Text(
                "GPS and timestamp will be logged automatically",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildOpeningDayTasks() {
    return _buildBaseLayout(
      title: "Have voting materials arrived?",
      subtitle: "Confirming delivery for Station #402\n (Central District).",
      content: Column(
        children: [
          _buildWideActionBtn(
            "Yes, materials arrived",
            "materials",
            "Yes",
            Icons.check,
          ),
          _buildWideActionBtn("No, not yet", "materials", "No", Icons.close),
          const SizedBox(height: 30),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.comment,
              size: 16,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            label: Text(
              "Report an issue",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPresenceCheck() {
    return _buildBaseLayout(
      title: "Are officials present?",
      subtitle:
          "Select the level of presence you currently observe at this location.",
      content: Column(
        children: [
          _buildPresenceTile("None", Icons.horizontal_rule, "presence", "None"),
          _buildPresenceTile("Some", Icons.people_outline, "presence", "Some"),
          _buildPresenceTile(
            "Full",
            Icons.check_circle,
            "presence",
            "Full",
            isRecommended: true,
          ),
          const SizedBox(height: 80),
          _buildSubmitButton(
            "Submit Observation",
            () => _onSelectionMade("presence_final", true),
          ),
        ],
      ),
    );
  }

  Widget _buildQueueStatus() {
    return _buildBaseLayout(
      title: "What is the queue status?",
      subtitle: "Live Intelligence Gathering",
      content: Column(
        children: [
          _buildQueueSquare("Light", Icons.person, "queue", "Light"),
          _buildQueueSquare("Heavy", Icons.groups, "queue", "Heavy"),
          const SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.priority_high_outlined,
                color: Colors.grey,
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Your report helps coordinate mobilization efforts in real-time across the field operation.',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          _buildSubmitButton(
            "Submit Status",
            () => _onSelectionMade("queue_final", true),
          ),
        ],
      ),
    );
  }

  Widget _buildPollMonitor() {
    return _buildBaseLayout(
      title: "Is voting currently ongoing?",
      content: Column(
        children: [
          _buildWideActionBtn("YES", "ongoing", "Yes", Icons.check),
          _buildWideActionBtn("NO", "ongoing", "No", Icons.close),
          const SizedBox(height: 70),
          Column(
            children: [
              Text(
                "Precinct #402 - Downtown Center",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              Text(
                "Last updated: 2 mins ago",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- REUSABLE PATTERN HELPERS ---

  Widget _buildBaseLayout({
    required String title,
    String? subtitle,
    required Widget content,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          if (subtitle != null)
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          const SizedBox(height: 30),
          Expanded(child: content),
        ],
      ),
    );
  }

  Widget _buildWideActionBtn(
    String text,
    String key,
    String val,
    IconData icon,
  ) {
    bool isSelected = gatheredData[key] == val;
    return GestureDetector(
      onTap: () => _onSelectionMade(key, val),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(height: 20),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionCard(
    String label,
    IconData icon,
    String key,
    String val,
  ) {
    bool isSelected = gatheredData[key] == val;
    return GestureDetector(
      onTap: () => _onSelectionMade(key, val),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 16),
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF1E0D0D),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFC6102E)
                : const Color(0xFF2D2D2D),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: isSelected
                  ? const Color(0xFFC6102E)
                  : const Color(0xFF2D2D2D),
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            const SizedBox(height: 16),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPresenceTile(
    String label,
    IconData icon,
    String key,
    String val, {
    bool isRecommended = false,
  }) {
    bool isSelected = gatheredData[key] == val;
    return GestureDetector(
      onTap: () => _onSelectionMade(key, val),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        height: 120,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF2D1F1F),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFFC6102E) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isSelected)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      'Recommended selection',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: const Color(0xFFC6102E),
                      ),
                    ),
                  ),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.tertiaryContainer
                    : Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 30),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQueueSquare(
    String label,
    IconData icon,
    String key,
    String val,
  ) {
    bool isSelected = gatheredData[key] == val;
    return GestureDetector(
      onTap: () => _onSelectionMade(key, val),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 16),
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF16202C),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFFC6102E) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white10,
              child: Icon(icon, color: Colors.white, size: 30),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStaticInfoTile(
    IconData icon,
    String title,
    String sub,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  sub,
                  style: const TextStyle(
                    color: Color(0xFFC6102E),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2D24),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.circle, color: color, size: 8),
                const SizedBox(width: 6),
                Text(
                  "Active",
                  style: TextStyle(
                    color: color,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaticInfoTile2(String title, String sub) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2D1F1F),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: AssetImage('assets/images/map_placeholder.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 4),
                Text(
                  sub,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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

  Widget _buildSubmitButton(String text, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFC6102E),
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

// Checkmark Painter for Dialog
class CheckmarkPainter extends CustomPainter {
  final double progress;
  CheckmarkPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(size.width * 0.2, size.height * 0.5);
    path.lineTo(size.width * 0.45, size.height * 0.7);
    path.lineTo(size.width * 0.8, size.height * 0.3);

    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      final extractPath = metric.extractPath(0.0, metric.length * progress);
      canvas.drawPath(extractPath, paint);
    }
  }

  @override
  bool shouldRepaint(CheckmarkPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

import 'package:eagle_badger/utils/responsive_helper.dart';
import 'package:eagle_badger/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class EngagementMemoScreen extends StatefulWidget {
  const EngagementMemoScreen({super.key});

  @override
  State<EngagementMemoScreen> createState() => _EngagementMemoScreenState();
}

class _EngagementMemoScreenState extends State<EngagementMemoScreen> {
  bool isVisitConfirmed = true;
  bool isEndorsementSecured = false;
  bool isRecording = false;

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
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
          "Intelligence Report Saved Successfully!",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(
                  context,
                  '/fieldWork',
                ); // Return to Menu
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
      appBar: CustomAppBar(
        title: 'Engagement Memo',
        onBackTap: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Influencer Profile",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  CircleAvatar(
                    radius: context.isSmall ? 20 : 25,
                    backgroundImage: AssetImage('assets/images/avator3.png'),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Marcus Thorne",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        "Community Leader • District 4",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              _buildBinaryToggle(
                "Visit Confirmed?",
                isVisitConfirmed,
                (val) => setState(() => isVisitConfirmed = val),
              ),
              const SizedBox(height: 20),
              _buildBinaryToggle(
                "Endorsement Secured?",
                isEndorsementSecured,
                (val) => setState(() => isEndorsementSecured = val),
              ),
              const SizedBox(height: 30),
              Text(
                "Notes / Voice Memo",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => isRecording = !isRecording),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: isRecording
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSecondaryFixed,
                        child: Icon(
                          Icons.mic,
                          color: Theme.of(context).colorScheme.onSurface,
                          size: 40,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Tap to record field observations",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      maxLines: 4,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      decoration: InputDecoration(
                        hintText:
                            "Or type summary here... (e.g., Influencer mentioned concern about local infrastructure)",
                        hintStyle: Theme.of(context).textTheme.bodyMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.primaryFixed,
                            ),
                        filled: true,
                        fillColor: Theme.of(
                          context,
                        ).colorScheme.onSecondaryFixed,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Theme.of(
                              context,
                            ).colorScheme.tertiaryFixedDim,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Theme.of(
                              context,
                            ).colorScheme.tertiaryFixedDim,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  _showSuccessDialog(); // Trigger dialog instead of immediate nav
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Submit Intelligence Report",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBinaryToggle(
    String title,
    bool currentValue,
    Function(bool) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondaryFixed,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              _buildSimpleTab(
                "Yes",
                currentValue == true,
                () => onChanged(true),
              ),
              _buildSimpleTab(
                "No",
                currentValue == false,
                () => onChanged(false),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSimpleTab(String text, bool active, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: active ? Colors.black38 : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Add the painter class at the bottom
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

import 'package:eagle_badger/utils/responsive_helper.dart';
import 'package:eagle_badger/widgets/fill_selection_card.dart';
import 'package:eagle_badger/widgets/grid_selection_card.dart';
import 'package:eagle_badger/widgets/selection_card.dart';
import 'package:flutter/material.dart';
import 'survey_step_layout.dart';

class VoterProfilingScreen extends StatefulWidget {
  const VoterProfilingScreen({super.key});

  @override
  State<VoterProfilingScreen> createState() => _VoterProfilingScreenState();
}

class _VoterProfilingScreenState extends State<VoterProfilingScreen> {
  final PageController _pageController = PageController();

  int _currentStep = 1;
  final int _totalSteps = 6;

  List<Map<String, dynamic>> savedInteractions = [];
  String? _intentChoice;
  String? _patternChoice;
  String? _pvcChoice;
  String? _selectedConcern;
  String? _selectedParty;
  bool _isRecording = false;
  String _noteText = "";

  void _onContinue() {
    if (_currentStep < _totalSteps) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _saveAllDataToDatabase();
    }
  }

  void _saveAllDataToDatabase() {
    Map<String, dynamic> newInteraction = {
      'intent': _intentChoice,
      'pattern': _patternChoice,
      'pvc': _pvcChoice,
      'concern': _selectedConcern,
      'party': _selectedParty,
      'note': _noteText,
      'timestamp': DateTime.now().toString(),
    };
    setState(() {
      savedInteractions.add(newInteraction);
    });
    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
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
          "Interaction Saved Successfully!",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/fieldWork'));
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
    bool isLastStep = _currentStep == _totalSteps;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).colorScheme.onSurface,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isLastStep ? "Quick Note" : "Voter Profiling",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        bottom: isLastStep
            ? null
            : PreferredSize(
                preferredSize: Size.fromHeight(context.isSmall ? 50 : 70),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Divider(
                        color: Theme.of(context).colorScheme.tertiaryFixedDim,
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Survey Progress",
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                ),
                          ),
                          Text(
                            "$_currentStep of 5",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: _currentStep / 5,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.tertiaryFixedDim,
                        color: Theme.of(context).colorScheme.primary,
                        minHeight: context.isSmall ? 4 : 8,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const BouncingScrollPhysics(),
          onPageChanged: (index) => setState(() => _currentStep = index + 1),
          children: [
            // STEP 1: Intent
            SurveyStepLayout(
              profile: 'John Doe',
              title:
                  "Do you intent to vote in the upcoming presidential election?",
              content: Column(
                children: [
                  SelectionCard(
                    label: "Yes",
                    subLabel: "Selected",
                    isSelected: _intentChoice == "Yes",
                    onTap: () => setState(() => _intentChoice = "Yes"),
                  ),
                  SelectionCard(
                    label: "No",
                    subLabel: "Uncommitted",
                    isSelected: _intentChoice == "No",
                    onTap: () => setState(() => _intentChoice = "No"),
                  ),
                ],
              ),
            ),

            // STEP 2: Pattern
            SurveyStepLayout(
              title: "Past voting pattern known?",
              description: "Select the profile based on historical data.",
              content: Column(
                children: [
                  FillSelectionCard(
                    label: "Yes",
                    isSelected: _patternChoice == "Yes",
                    icon: Icons.check_circle,
                    onTap: () => setState(() => _patternChoice = "Yes"),
                  ),
                  FillSelectionCard(
                    label: "No",
                    isSelected: _patternChoice == "No",
                    icon: Icons.cancel_rounded,
                    onTap: () => setState(() => _patternChoice = "No"),
                  ),
                ],
              ),
            ),

            // STEP 3: PVC
            SurveyStepLayout(
              title: "PVC available?",
              description:
                  "Verify if the voters have their Permanent Voter Card on hand.",
              content: Column(
                children: [
                  FillSelectionCard(
                    label: "Yes",
                    isSelected: _pvcChoice == "Yes",
                    icon: Icons.check_circle,
                    onTap: () => setState(() => _pvcChoice = "Yes"),
                  ),
                  FillSelectionCard(
                    label: "No",
                    isSelected: _pvcChoice == "No",
                    icon: Icons.cancel_rounded,
                    onTap: () => setState(() => _pvcChoice = "No"),
                  ),
                ],
              ),
            ),

            // STEP 4: Concern
            SurveyStepLayout(
              title: "What is the main Concern?",
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.9,
                      children: [
                        GridSelectionCard(
                          label: "Economy",
                          icon: Icons.map,
                          isSelected: _selectedConcern == "Economy",
                          onTap: () =>
                              setState(() => _selectedConcern = "Economy"),
                        ),
                        GridSelectionCard(
                          label: "Electricity",
                          icon: Icons.lightbulb,
                          isSelected: _selectedConcern == "Electricity",
                          onTap: () =>
                              setState(() => _selectedConcern = "Electricity"),
                        ),
                        GridSelectionCard(
                          label: "Security",
                          icon: Icons.hub,
                          isSelected: _selectedConcern == "Security",
                          onTap: () =>
                              setState(() => _selectedConcern = "Security"),
                        ),
                        GridSelectionCard(
                          label: "Corruption",
                          icon: Icons.balance,
                          isSelected: _selectedConcern == "Corruption",
                          onTap: () =>
                              setState(() => _selectedConcern = "Corruption"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    OtherConcernTile(
                      isSelected: _selectedConcern == "Other",
                      onTap: () => setState(() => _selectedConcern = "Other"),
                    ),
                  ],
                ),
              ),
            ),
            // STEP 5: Party
            SurveyStepLayout(
              title: "Which will vote for?",
              content: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
                children: [
                  FillGridCard(
                    label: "APC",
                    isSelected: _selectedParty == "APC",
                    onTap: () => setState(() => _selectedParty = "APC"),
                  ),
                  FillGridCard(
                    label: "PDP",
                    isSelected: _selectedParty == "PDP",
                    onTap: () => setState(() => _selectedParty = "PDP"),
                  ),
                  FillGridCard(
                    label: "ADC",
                    isSelected: _selectedParty == "ADC",
                    onTap: () => setState(() => _selectedParty = "ADC"),
                  ),
                  FillGridCard(
                    label: "LP",
                    isSelected: _selectedParty == "LP",
                    onTap: () => setState(() => _selectedParty = "LP"),
                  ),
                ],
              ),
            ),
            // STEP 6: Quick Note
            _buildQuickNoteStep(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomButton(context),
    );
  }

  // --- COMPONENT WIDGETS ---
  Widget _buildQuickNoteStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          SizedBox(height: context.isSmall ? 15 : 30),
          Text(
            "Tap to Record Voice Note",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 30),
          _buildVoiceRecorderUI(isRecording: _isRecording),
          const SizedBox(height: 20),
          if (_isRecording)
            Text(
              'Listening for audio....',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Short Note",
              style: TextStyle(color: Colors.grey[400], fontSize: 14),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white10),
            ),
            child: TextField(
              maxLines: null,
              onChanged: (val) => _noteText = val,
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
              decoration: InputDecoration(
                hintText: "Type a quick summary of the interaction...",
                hintStyle: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildMetadataRow(
            Icons.location_on,
            "Location: 123 Liberty St (Captured)",
          ),
          const SizedBox(height: 12),
          _buildMetadataRow(
            Icons.person,
            "Subject: Robert Miller • District 4",
          ),
        ],
      ),
    );
  }

  Widget _buildVoiceRecorderUI({required bool isRecording}) {
    return GestureDetector(
      onTap: () => setState(() => _isRecording = !_isRecording),
      child: Container(
        padding: context.isSmall ? EdgeInsets.all(15) : EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: isRecording
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.primaryContainer,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.mic,
          color: Theme.of(context).colorScheme.onSurface,
          size: context.isSmall ? 38 : 48,
        ),
      ),
    );
  }

  Widget _buildMetadataRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primaryFixed, size: 16),
        const SizedBox(width: 8),
        Text(text, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        color: Theme.of(context).colorScheme.surface,
        child: SizedBox(
          height: context.isSmall ? 50 : 56,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _onContinue,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              _currentStep == _totalSteps ? "Save Interaction" : "Continue",
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ),
      ),
    );
  }
}

//-- Check Mark --
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
  bool shouldRepaint(CheckmarkPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

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
        title: const Icon(Icons.check_circle, color: Colors.green, size: 60),
        content: const Text(
          "Interaction Saved Successfully!",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Back to dashboard
              },
              child: const Text(
                "Done",
                style: TextStyle(
                  color: Color(0xFFC6102E),
                  fontWeight: FontWeight.bold,
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isLastStep ? "Quick Note" : "Voter Profiling",
          style: const TextStyle(color: Colors.white, fontSize: 22),
        ),
        bottom: isLastStep
            ? null
            : PreferredSize(
                preferredSize: const Size.fromHeight(70),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const Divider(color: Colors.white10, thickness: 1),
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
                        backgroundColor: Colors.white10,
                        color: Theme.of(context).colorScheme.primary,
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
      ),
      body: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(), // Swipeable pages
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
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.0,
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
      bottomNavigationBar: _buildBottomButton(context),
    );
  }

  // --- COMPONENT WIDGETS ---

  Widget _buildQuickNoteStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 30),
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
              decoration: const InputDecoration(
                hintText: "Type a quick summary of the interaction...",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
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
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: isRecording
              ? const Color(0xFFC6102E)
              : const Color(0xFF381A1A),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.mic, color: Colors.white, size: 48),
      ),
    );
  }

  Widget _buildMetadataRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 16),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
      color: Theme.of(context).colorScheme.surface,
      child: SizedBox(
        height: 56,
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
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPartyOption(
    BuildContext context, {
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondaryContainer,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFFC6102E) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}

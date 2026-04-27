import 'package:eagle_badger/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'survey_templates.dart';

class SurveyFlowScreen extends StatefulWidget {
  const SurveyFlowScreen({super.key});

  @override
  State<SurveyFlowScreen> createState() => _SurveyFlowScreenState();
}

class _SurveyFlowScreenState extends State<SurveyFlowScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 1;
  final int _totalSteps = 11;

  List<Map<String, dynamic>> savedInteractions = [];
  Map<String, dynamic> surveyData = {};

  String _getAppBarTitle() {
    switch (_currentStep) {
      case 1:
        return "Opponent Activity";
      case 2:
      case 3:
        return "Other Indicators";
      default:
        return "Voter intentions";
    }
  }

  void _onStepSelected(String key, String value) {
    setState(() {
      surveyData[key] = value;
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      if (_currentStep < _totalSteps) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      } else {
        _finishSurvey();
      }
    });
  }

  void _finishSurvey() {
    setState(() {
      savedInteractions.add({
        ...surveyData,
        'timestamp': DateTime.now().toString(),
      });
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(
        title: _getAppBarTitle(),
        onBackTap: () => Navigator.pop(context),
      ),
      body: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (index) => setState(() => _currentStep = index + 1),
        children: [
          _buildBinaryStep(
            stepKey: "logistics_seen",
            title: "Opponent logistics seen?",
            description:
                "Report immediate visual confirmation of opponent vehicles.",
          ),
          _buildBinaryStep(
            stepKey: "branded_paraphernalia",
            title: "Are people in the area wearing branded paraphernalia?",
          ),
          _buildBinaryStep(
            stepKey: "stickers_indicators",
            title:
                "Do cars or houses around the area have stickers for opponents or clients?",
          ),
          _buildGridStep(
            context,
            stepKey: "voter_choice_presidential",
            question:
                "If the election were held today, who would you vote for at the Presidential level?",
            options: ["Party A", "Party B", "Party C", "Undecided"],
          ),
          _buildGridStep(
            context,
            stepKey: "voter_choice_governorship",
            question:
                "If the election were held today, who would you vote for at the Governorship level?",
            options: ["Party A", "Party B", "Party C", "Undecided"],
          ),
          _buildGridStep(
            context,
            stepKey: "voter_choice_lga",
            question:
                "Who do you intend to vote for at the Local Government (LGA) Chairmanship level?",
            options: ["Party A", "Party B", "Party C", "Undecided"],
          ),
          _buildGridStep(
            context,
            stepKey: "voter_choice_nass",
            question:
                "Who do you intend to vote for at the National Assembly level?",
            options: ["Party A", "Party B", "Party C", "Undecided"],
          ),
          _buildGridStep(
            context,
            stepKey: "voter_choice_state_assembly",
            question:
                "Who do you intend to vote for at the State Assembly level?",
            options: ["Party A", "Party B", "Party C", "Undecided"],
          ),
          _buildGridStep(
            context,
            stepKey: "public_support_party",
            question:
                "In public places you visit most (buses, churches, mosques, gatherings), which candidate or party do people mostly support?",
            options: ["Party A", "Party B", "Party C", "Undecided"],
          ),
          _buildGridStep(
            context,
            stepKey: "public_support_strength",
            question:
                "How strong is the support you hear in public spaces for the leading candidate/party?",
            options: ["Party A", "Party B", "Party C", "Undecided"],
          ),
          _buildGridStep(
            context,
            stepKey: "strongest_discussion_locs",
            question:
                "Which locations show the strongest political discussions?",
            options: ["Party A", "Party B", "Party C", "Undecided"],
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBinaryStep({
    required String stepKey,
    required String title,
    String? description,
  }) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          if (description != null) ...[
            const SizedBox(height: 10),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
          const SizedBox(height: 40),
          SelectionButton(
            label: "Yes",
            icon: Icons.check_circle,
            isSelected: surveyData[stepKey] == "Yes",
            onTap: () => _onStepSelected(stepKey, "Yes"),
          ),
          const SizedBox(height: 15),
          SelectionButton(
            label: "No",
            icon: Icons.cancel,
            isSelected: surveyData[stepKey] == "No",
            onTap: () => _onStepSelected(stepKey, "No"),
          ),
        ],
      ),
    );
  }

  Widget _buildGridStep(
    BuildContext context, {
    required String stepKey,
    required String question,
    required List<String> options,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 30),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: 1.15,
            children: options
                .map(
                  (opt) => InkWell(
                    onTap: () => _onStepSelected(stepKey, opt),
                    child: Container(
                      decoration: BoxDecoration(
                        color: surveyData[stepKey] == opt
                            ? const Color(0xFFC6102E)
                            : const Color(0xFF1C1C1E),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          opt,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: 1,
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).colorScheme.onPrimary,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/fieldWork');
            break;
          case 1:
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/fieldWork');
            break;
          case 3:
            Navigator.pushReplacementNamed(context, '/fieldWork');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_view),
          label: "Dashboard",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.analytics), label: "Activity"),
        BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: "Alerts",
        ),
      ],
    );
  }
}

import 'package:eagle_badger/utils/responsive_helper.dart';
import 'package:eagle_badger/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class ReportIncidentScreen extends StatefulWidget {
  const ReportIncidentScreen({super.key});

  @override
  State<ReportIncidentScreen> createState() => _ReportIncidentScreenState();
}

class _ReportIncidentScreenState extends State<ReportIncidentScreen> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(
        title: 'Report Incident',
        onBackTap: () => Navigator.pop(context),
        actionText: 'Cancel',
        actionColor: Theme.of(context).colorScheme.primary,
        onActionTap: () {},
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  Text(
                    "What happened?",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Select the category that best describes the incident you are witnessing in the field.",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildIncidentTile(
                    "Violence",
                    "Physical harm, fighting, or threats of force",
                    Icons.sports_kabaddi,
                  ),
                  _buildIncidentTile(
                    "Vote buying",
                    "Exchange of money, food, or gifts for votes",
                    Icons.how_to_vote,
                  ),
                  _buildIncidentTile(
                    "Intimidation",
                    "Harassment or pressure on voters/staff",
                    Icons.gavel,
                  ),
                  _buildIncidentTile(
                    "Disruption",
                    "Blocking access or logistics interference",
                    Icons.grid_view_rounded,
                  ),
                  _buildIncidentTile(
                    "Other",
                    "Any other irregular activity or concerns",
                    Icons.more_horiz,
                  ),

                  const SizedBox(height: 15),
                  _buildSecurityFooter(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIncidentTile(String title, String subtitle, IconData icon) {
    bool isSelected = _selectedCategory == title;

    return GestureDetector(
      onTap: () => {
        setState(() => _selectedCategory = title),
        Navigator.pushNamed(context, '/evidenceCapture'),
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 16),
        padding: context.isSmall ? EdgeInsets.all(8) : EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondaryFixed,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
                size: context.isSmall ? 16 : 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityFooter() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock,
              color: Theme.of(context).colorScheme.onSurface,
              size: 14,
            ),
            SizedBox(width: 6),
            Text(
              "Secure Incident Reporting",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Your report is encrypted and sent directly to the mobilization hub. Please prioritize your physical safety before completing this report.",
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

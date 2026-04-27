import 'package:eagle_badger/utils/responsive_helper.dart';
import 'package:eagle_badger/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class LocalPulseScreen extends StatefulWidget {
  const LocalPulseScreen({super.key});

  @override
  State<LocalPulseScreen> createState() => _LocalPulseScreenState();
}

class _LocalPulseScreenState extends State<LocalPulseScreen> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // --- HEADER ---
            CustomAppBar(
              title: 'Local Pulse: Ward 4',
              onBackTap: () => Navigator.pop(context),
            ),

            // --- PAGE INDICATOR ---
            const SizedBox(height: 20),
            _buildPageIndicator(),

            // --- ANALYSIS CARD (SWIPEABLE) ---
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemCount: 4,
                itemBuilder: (context, index) => _buildPulseCard(),
              ),
            ),

            // --- SWIPE PROMPT ---
            const SizedBox(height: 20),
            Column(
              children: [
                Text(
                  "Swipe to continue",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Icon(
                  Icons.keyboard_double_arrow_up,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),

            // --- ACTION BUTTONS ---
            Padding(
              padding: context.isSmall
                  ? EdgeInsets.all(10)
                  : EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/fieldWork');
                      },
                      child: _buildActionButton(
                        Icons.save,
                        "Save",
                        isSecondary: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildActionButton(
                      Icons.share,
                      "Brief Team",
                      isSecondary: false,
                    ),
                  ),
                ],
              ),
            ),

            // --- BOTTOM NAVIGATION FOOTER ---
            _buildNextStopFooter(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 4,
          width: index == _currentPage ? 24 : 8,
          decoration: BoxDecoration(
            color: index == _currentPage
                ? const Color(0xFFC6102E)
                : Colors.grey[800],
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }

  Widget _buildPulseCard() {
    return Container(
      margin: EdgeInsets.all(context.isSmall ? 15 : 20),
      padding: EdgeInsets.symmetric(
        horizontal: context.isSmall ? 15 : 30,
        vertical: context.isSmall ? 20 : 40,
      ),
      decoration: BoxDecoration(
        color: const Color.fromARGB(
          255,
          151,
          153,
          155,
        ), // Grey card color from design
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          // Top Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCardIcon(Icons.lightbulb),
              const SizedBox(
                height: 40,
                child: VerticalDivider(
                  color: Colors.black26,
                  thickness: 1,
                  width: 40,
                ),
              ),
              _buildCardIcon(Icons.account_balance),
            ],
          ),
          SizedBox(height: context.isSmall ? 20 : 40),
          Text(
            "People here care most about electricity & market safety",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: context.isSmall ? 10 : 20),
          Text(
            "Analysis shows these two concerns correlate with high voter anxiety in this sector.",
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.black54),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              "AI Confidence Score: 94%",
              style: TextStyle(
                color: Color.fromARGB(255, 26, 31, 36),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardIcon(IconData icon) {
    return Container(
      padding: context.isSmall ? EdgeInsets.all(8) : EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.black12,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.black, size: context.isSmall ? 22 : 32),
    );
  }

  Widget _buildActionButton(
    IconData icon,
    String label, {
    required bool isSecondary,
  }) {
    return Container(
      height: context.screenHeight * 0.07,
      decoration: BoxDecoration(
        color: isSecondary
            ? Theme.of(context).colorScheme.tertiaryContainer
            : Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
        border: isSecondary
            ? Border.all(color: Theme.of(context).colorScheme.tertiaryFixedDim)
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.onSurface,
            size: context.isSmall ? 25 : 30,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextStopFooter() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: context.isSmall ? 10 : 20),
      padding: context.isSmall ? EdgeInsets.all(10) : EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.tertiaryFixedDim,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.navigation,
              color: Theme.of(context).colorScheme.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Next Stop",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                Text(
                  "12 Adeyemi Street, Ikeja",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          Text(
            "2 min",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

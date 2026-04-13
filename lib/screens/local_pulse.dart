import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

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
      backgroundColor: const Color(0xFF1A0F0F),
      body: SafeArea(
        child: Column(
          children: [
            // --- HEADER ---
            _buildHeader(context),

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
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 12,
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
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/fieldWork');
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

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          ),
          const Expanded(
            child: Center(
              child: Text(
                "Local Pulse: Ward 4",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 48), // Balance for back button
        ],
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
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
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
          const SizedBox(height: 40),
          const Text(
            "People here care most about electricity & market safety",
            style: TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Analysis shows these two concerns correlate with high voter anxiety in this sector.",
            style: TextStyle(
              color: Color.fromARGB(186, 16, 24, 32),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
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
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.black12,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.black, size: 32),
    );
  }

  Widget _buildActionButton(
    IconData icon,
    String label, {
    required bool isSecondary,
  }) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: isSecondary
            ? Theme.of(context).colorScheme.tertiaryContainer
            : Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
        border: isSecondary ? Border.all(color: Colors.white10) : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 30,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextStopFooter() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF381A1A),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.navigation, color: Color(0xFFC6102E)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Next Stop",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 12,
                  ),
                ),
                const Text(
                  "12 Adeyemi Street, Ikeja",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          const Text(
            "2 min",
            style: TextStyle(
              color: Color(0xFFC6102E),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

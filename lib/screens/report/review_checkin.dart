import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReviewCheckInScreen extends StatelessWidget {
  const ReviewCheckInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Review Check-In",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Summary Overview",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              "Please verify the details of your interaction before submitting to the campaign database.",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            const SizedBox(height: 20),

            // GPS Status Box
            _buildGpsStatusBox(context),

            const SizedBox(height: 30),
            Text(
              "Interaction Details",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),

            // Detail Card
            _buildInteractionDetailCard(context),

            const SizedBox(height: 30),
            const Text(
              "Logged Location",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // Map Placeholder
            _buildMapSection(),

            const SizedBox(height: 20),

            // Volunteer Notes Box
            _buildNotesBox(context),

            const SizedBox(height: 40),

            // Submit Button
            ElevatedButton(
              onPressed: () {
                // Trigger your success dialog here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Submit Check-In",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildGpsStatusBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(204, 30, 36, 30),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color.fromARGB(255, 12, 60, 12)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "GPS & Timestamp Auto-logged",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Verified at 10:45 AM • Lincoln Heights",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
          const CircleAvatar(
            backgroundColor: Color(0xFF2E3D2E),
            child: Icon(Icons.location_on, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionDetailCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondaryFixed,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildDetailRow(context, "Campaign Area", "District 7 - Ward B"),
          Divider(
            color: Theme.of(context).colorScheme.onPrimary,
            thickness: 0.1,
          ),
          _buildDetailRow(context, "Contact Person", "Sarah Jenkins"),
          Divider(
            color: Theme.of(context).colorScheme.onPrimary,
            thickness: 0.1,
          ),
          _buildDetailRow(
            context,
            "Support Level",
            "Strong Support",
            isPositive: true,
            showIcon: true,
          ),
          Divider(
            color: Theme.of(context).colorScheme.onPrimary,
            thickness: 0.1,
          ),
          _buildDetailRow(
            context,
            "Materials Distributed",
            "12 Flyers, 2 Stickers",
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value, {
    bool isPositive = false,
    bool isLast = false,
    bool showIcon = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  color: isPositive ? Colors.green : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              if (showIcon) ...[
                const SizedBox(width: 8),
                const Icon(Icons.thumb_up, color: Colors.green, size: 14),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          Image.asset(
            'assets/images/map_placeholder.png',
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.black54,
              ),
              child: const Text(
                "Lat: 38.8977° N, Lon: 77.0365° W",
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesBox(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondaryFixed,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Volunteer Notes",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "\"Very receptive to the education platform. Requested a follow-up call regarding the upcoming town hall meeting next Tuesday.\"",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

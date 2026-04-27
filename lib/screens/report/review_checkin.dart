import 'package:eagle_badger/utils/responsive_helper.dart';
import 'package:eagle_badger/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class ReviewCheckInScreen extends StatelessWidget {
  const ReviewCheckInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(
        title: 'Review Check-In',
        onBackTap: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        padding: context.isSmall
            ? EdgeInsets.all(20)
            : EdgeInsets.symmetric(horizontal: 24),
        child: SafeArea(
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
              Text(
                "Logged Location",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 12),

              // Map Placeholder
              _buildMapSection(context),

              const SizedBox(height: 20),

              // Volunteer Notes Box
              _buildNotesBox(context),

              const SizedBox(height: 40),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/resultSheet');
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
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
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
          CircleAvatar(
            backgroundColor: Color(0xFF2E3D2E),
            child: Icon(
              Icons.location_on,
              color: Theme.of(context).colorScheme.onSurface,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionDetailCard(BuildContext context) {
    return Container(
      padding: context.isSmall ? EdgeInsets.all(10) : EdgeInsets.all(20),
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
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: isPositive
                      ? Theme.of(context).colorScheme.tertiaryFixed
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
              if (showIcon) ...[
                const SizedBox(width: 8),
                Icon(
                  Icons.thumb_up,
                  color: Theme.of(context).colorScheme.tertiaryFixed,
                  size: 14,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection(BuildContext context) {
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
              child: Text(
                "Lat: 38.8977° N, Lon: 77.0365° W",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
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

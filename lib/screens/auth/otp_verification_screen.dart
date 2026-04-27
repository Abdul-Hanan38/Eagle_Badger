import 'package:eagle_badger/utils/responsive_helper.dart';
import 'package:eagle_badger/widgets/custom_appbar.dart';
import 'package:eagle_badger/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:eagle_badger/utils/responsive_helper.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double pinwidth = context.relativeWidth(0.14);
    double pinheight = pinwidth * 1.15;

    final defaultPinTheme = PinTheme(
      width: pinwidth,
      height: pinheight,
      textStyle: TextStyle(
        fontSize: context.screenWidth * 0.05,
        color: Theme.of(context).colorScheme.onSurface,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
        ),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
        color: Theme.of(context).colorScheme.primary,
        width: 2,
      ),
    );
    return Scaffold(
      appBar: CustomAppBar(
        title: 'OTP Verification',
        onBackTap: () => Navigator.pop(context),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: context.isSmall ? 30 : 60),
                  Center(
                    child: Text(
                      'Security Verification',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text.rich(
                    TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        const TextSpan(text: "We've sent a 6-digit code to "),
                        TextSpan(
                          text: '+1 (555) 000-0000. ',
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                        const TextSpan(
                          text:
                              "Please enter it below to continue your mobilization effort",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: context.isSmall ? 20 : 40),
                  Pinput(
                    length: 6,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    showCursor: true,
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text.rich(
                      TextSpan(
                        style: Theme.of(context).textTheme.bodySmall,
                        children: [
                          TextSpan(text: "Didn't receive code?"),
                          TextSpan(
                            text: 'Resend in 00:55',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: context.isSmall ? 80 : 120),
                  // Bottom Navigation Button.
                  CustomButton(
                    title: 'Verify & Sync',
                    rightIcon: Icons.sync,
                    onPressed: () =>
                        Navigator.pushNamed(context, '/permission'),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color.fromARGB(30, 243, 150, 166),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Field Optimized',
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Verification works offline via secure local protocol. Your data will sync once a connection is established.',
                            textAlign: TextAlign.center,
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:eagle_badger/widgets/custom_appbar.dart';
import 'package:eagle_badger/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:eagle_badger/utils/responsive_helper.dart';

final phoneFormatter = MaskTextInputFormatter(
  mask: '(###) ###-####',
  filter: {"#": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Login',
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
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: Card(
                        color: Theme.of(context).colorScheme.primary,
                        child: Image.asset('assets/images/eagle.png'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: Text(
                      'Political Intelligence',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(height: context.isSmall ? 15 : 30),
                  Text(
                    'Enter your mobile number',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: context.isSmall ? 26 : 32,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'A high-fidelity political intelligence and mobilization platform for field volunteers.',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Mobile Number',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    keyboardType: TextInputType.phone,
                    inputFormatters: [phoneFormatter],
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      hintText: "(555) 000-0000",
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.surfaceBright,
                      ),
                      filled: true,
                      fillColor: Theme.of(
                        context,
                      ).colorScheme.secondaryContainer,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: context.isSmall ? 18 : 20,
                        vertical: context.isSmall ? 20 : 24,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 2,
                        ), // Brand red when typing
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'By Continuing, you agree to receive SMS alerts for verification and compaign updates',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Bottom Navigation Button.
                  CustomButton(
                    title: 'Send Verification Code',
                    rightIcon: Icons.arrow_forward_ios_outlined,
                    onPressed: () => Navigator.pushNamed(context, '/otp'),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Need Help Signing in?',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
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

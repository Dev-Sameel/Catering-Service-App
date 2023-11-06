import 'package:catering/Refactoring/methods/app_bar_cuper.dart';
import 'package:flutter/material.dart';

import '../../../../Refactoring/methods/tile_text.dart';
import '../../../../Refactoring/styles/colors.dart';
import '../../../../Refactoring/widgets/others.dart';


class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: customAppBar(null, null, null, 'TERMS & CONDITIONS'),
    body:  Container(
        decoration: BoxDecoration(
          gradient: orangeGradient,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
            ),
          ],
        ),
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.all(20.0),
        child: ScrollConfiguration(
          behavior: RemoveGlow(),
          child: ListView(
            shrinkWrap: true,
            children: [
              doubleTextColumn(
                '1. Acceptance of Terms',
                'By using the "Food Pilot" app, you agree to these Terms and Conditions. If you do not agree, please do not use the app.',
              ),
              doubleTextColumn('2. User Registration',
                  'You must provide accurate and complete information during registration. You are responsible for maintaining the confidentiality of your password.'),
              doubleTextColumn('3. Use of the App',
                  "You agree to use the app only for lawful purposes and in compliance with these terms."),
              doubleTextColumn('4. Privacy and Data',
                  'We collect, use, and share your information as described in our Privacy Policy.'),
              doubleTextColumn('5. Termination',
                  'We reserve the right to terminate or suspend your account for any reason.'),
              doubleTextColumn('6. Changes to the App and Terms',
                  'We may update the app and these terms. By continuing to use the app, you agree to any changes.'),
              doubleTextColumn('', ''),
            ],
          ),
        ),
      ),);
  }
}
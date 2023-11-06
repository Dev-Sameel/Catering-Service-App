import 'package:catering/Refactoring/methods/app_bar_cuper.dart';
import 'package:catering/Refactoring/methods/tile_text.dart';
import 'package:catering/Refactoring/styles/colors.dart';
import 'package:catering/Refactoring/widgets/others.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: customAppBar(null, null, null, 'PRIVACY POLICY'),
      body: Container(
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
                '1. Introduction',
                'This Privacy Policy is for the "Food Pilot" mobile application, owned and operated by Cyber Aliens. We are committed to protecting your privacy and handling your personal information responsibly. This policy outlines how we collect, use, and protect the information you provide when using our app.',
              ),
              doubleTextColumn('2. Information We Collect',
                  'We are collecting user personal information for registration ie..User name,photo,address,age,blodd group,date of birth,mobile number'),
              doubleTextColumn('3. How We Use Your Information',
                  "We collect and use your personal information for the following purposes:\n* To provide our catering services\n* To improve our app's functionality and user experience\n* To communicate with you\n* To personalize your experience"),
              doubleTextColumn('4. Data Security',
                  'We take appropriate security measures to protect your personal information from unauthorized access, disclosure, alteration, or destruction.'),
              doubleTextColumn('5. Third-Party Links',
                  'Our app may contain links to third-party websites or services. We are not responsible for the content or privacy practices of these third parties.'),
              doubleTextColumn('6. Changes to this Privacy Policy',
                  'We may update our Privacy Policy to reflect changes in our practices. We will notify you of any significant changes.'),
              doubleTextColumn('', ''),
            ],
          ),
        ),
      ),
    );
  }
}

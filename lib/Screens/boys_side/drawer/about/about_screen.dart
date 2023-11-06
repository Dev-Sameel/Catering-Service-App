import 'package:catering/Refactoring/methods/app_bar_cuper.dart';
import 'package:catering/Refactoring/methods/image_text.dart';
import 'package:catering/Refactoring/methods/sizedbox.dart';
import 'package:catering/Refactoring/methods/tile_text.dart';
import 'package:catering/Refactoring/styles/colors.dart';
import 'package:catering/Refactoring/widgets/others.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Refactoring/widgets/elevated_button.dart';
import 'privacy_policy.dart';
import 'terms_conditions.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(null, null, null, 'ABOUT'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: kWhite,boxShadow: [BoxShadow(blurRadius: 10,color: bgColor.withOpacity(0.7),offset: const Offset(5, 5))]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ScrollConfiguration(
                  behavior: RemoveGlow(),
                  child: ListView(children: [
                    Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: const Image(
                              width: 50,
                              image: AssetImage('assets/images/foodpilotIcon.jpg'),
                              fit: BoxFit.cover,
                            )),
                        sBoxW10(),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              tileText('Food Pilot', 20, FontWeight.bold, kBlack),
                              tileText('Developed by Cyber Alience', 15,
                                  FontWeight.normal, kBlack),
                              tileText(
                                  'Version 1.0.0', 15, FontWeight.normal, kBlack),
                            ]),
                      ],
                    ),
                    const Divider(
                      height: 20,
                      color: bgColor,
                    ),
                    tileText('Enjoying Food Pilot?', 16, FontWeight.bold,
                        kBlack.withOpacity(0.5)),
                    const SizedBox(
                      height: 25,
                    ),
                    imageNtext2(
                        'assets/images/frameIcons/star.png', 'Rate 5 stars', () {}),
                    sBoxH20(),
                    imageNtext2('assets/images/frameIcons/share.png', 'Share App',
                        () {
                      Share.share("progressing....");
                    }),
                    const SizedBox(
                      height: 40,
                    ),
                    tileText(
                        'Follow us', 16, FontWeight.bold, kBlack.withOpacity(0.5)),
                    const SizedBox(
                      height: 25,
                    ),
                    imageNtext2(
                        'assets/images/frameIcons/instagram.png', 'Instagram', () {
                      String url2 =
                          'https://instagram.com/dev.sameel?igshid=ZHQ1a2Q5YWg4dnRx';
                      if (url2.isNotEmpty) {
                        // ignore: deprecated_member_use
                        launch(url2);
                      }
                    }),
                    const SizedBox(
                      height: 40,
                    ),
                    tileText(
                        'Support', 16, FontWeight.bold, kBlack.withOpacity(0.5)),
                    const SizedBox(
                      height: 25,
                    ),
                    tileText(
                        'To contact us directly,please send an email to cyberaliens@gmail.com',
                        15,
                        FontWeight.normal,
                        kBlack),
                  ]),
                ),
              ),
              Column(
                children: [
                  const Divider(
                    height: 20,
                    color: bgColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomTextButton(
                          onPressed: () {
                             Get.to(()=>const PrivacyPolicy());
                          },
                          color: kBlack.withOpacity(0.7),
                          tSize: 17,
                          text: 'Privacy Policy'),
                      CustomTextButton(
                          onPressed: () {
                           Get.to(()=>const TermsConditions());
                          },
                          color: kBlack.withOpacity(0.7),
                          tSize: 17,
                          text: 'Terms & Conditions')
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

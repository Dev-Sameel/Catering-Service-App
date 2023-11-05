import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Refactoring/styles/colors.dart';
import '../../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) {
        return const Scaffold(
          backgroundColor: bgColor,
          body: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/splash logo.png'),width: 250,
                )
              ],
            ),
          ),
        );
      }
    );
  }
}

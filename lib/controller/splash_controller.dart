import 'dart:developer';

import 'package:catering/Screens/admin_side/a_home.dart';
import 'package:catering/Screens/boys_side/home.dart';
import 'package:catering/Screens/main_screens/login_page/login_page.dart';
import 'package:catering/Screens/main_screens/onboarding/intro.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  @override
  void onInit() async{
    checkUserLoggedIn();
    final sharedPrefs = await SharedPreferences.getInstance();
    log('keyyyyyyyyyyyyyyyyy${sharedPrefs.getString('splashKey').toString()}');
    super.onInit();
  }

  Future<void> gotoLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    final sharedPrefs = await SharedPreferences.getInstance();
    final userLogged = sharedPrefs.getBool('onBoardingKey');
    log('oooonnnn${userLogged.toString()}');
    if (userLogged == null) {
      Get.offAll(() => const OnBoardingScreen());
      await sharedPrefs.setBool('onBoardingKey', false);
      log(userLogged.toString());
    } else {
      Get.offAll(() => LoginPage());
    }
  }

  Future<void> checkUserLoggedIn() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final userLogged = sharedPrefs.getString('splashKey');
    log(sharedPrefs.getString('splashKey').toString());
    if (userLogged == 'logOut'||userLogged==null) {
      log('key value${sharedPrefs.getString('splashKey').toString()}');
      log(sharedPrefs.getString('splashKey').toString());
      gotoLogin();
    } else {
      log(sharedPrefs.getString('splashKey').toString());
      await Future.delayed(const Duration(seconds: 2));
      final userId=sharedPrefs.getString('uID');
      userLogged == 'bHome'
          ? Get.offAll(() => HomeScreen(uID: userId,))
          : Get.offAll(() => AHomePage());
    }
  }
}

import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // Wait for 3 seconds and then navigate to the login screen
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed('/login'); // Replace with your login route
    });
  }
}

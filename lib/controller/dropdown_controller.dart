import 'package:get/get.dart';

class CustomDropDownController extends GetxController {
  RxString selectedValue = ''.obs;

  void updateSelectedValue(String? value) {
    selectedValue.value = value!;
  }
}

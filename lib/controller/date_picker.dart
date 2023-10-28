import 'package:get/get.dart';

class DatePickerController extends GetxController {
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  void setDate(DateTime? date) {
    selectedDate.value = date;
  }
}

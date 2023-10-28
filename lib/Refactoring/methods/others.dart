import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../styles/colors.dart';

getxSnakBar(String title, String message, Color? bColor) {
  return Get.snackbar(
    title,
    message,
    backgroundColor: bColor ?? kWhite,
    // titleText: Text(title)
  );
}

String capitalize(String text) {
  return text[0].toUpperCase() + text.substring(1);
}

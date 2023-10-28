import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final messageController = TextEditingController();
  RxBool showSendButton = false.obs; // Use RxBool instead of bool

  String get typedText => messageController.text;

  void onTextChanged(String text) {
    showSendButton.value = text.isNotEmpty;
  }
}

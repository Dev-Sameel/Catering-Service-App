
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Screens/main_screens/login_page/login_page.dart';

logoutDialog() {
  return Get.defaultDialog(
    title: 'Logout',
    middleText: 'Are you sure want to logout',
    middleTextStyle: TextStyle(color: Colors.grey[600]),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 17),
              )),
          TextButton(
              onPressed: () {
                Get.to(()=> LoginPage());
              },
              child: const Text('Confirm', style: TextStyle(fontSize: 17))),
        ],
      )
    ],
    contentPadding: const EdgeInsets.only(left: 40, right: 40),
  );
}

import 'dart:developer';

import 'package:catering/Refactoring/firebase/variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../styles/colors.dart';
import '../widgets/elevated_button.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'others.dart';
import 'sizedbox.dart';

Future<void> addConfirmedWork(
    List<String> workIds, String uId, String workId) async {
  final workRef = await addWorkCollection.doc(workId);
  final DocumentReference userSkillsDoc =
      FirebaseFirestore.instance.collection('User Reg').doc(uId);

  try {
    // Get the current skills data from Firestore
    DocumentSnapshot snapshot = await userSkillsDoc.get();
    List<Map<String, dynamic>> currentWork =
        List<Map<String, dynamic>>.from(snapshot.get('confirmedWork'));
    final workSnap = await workRef.get();

    // Add new work entries
    for (String workId in workIds) {
      currentWork.add({
        'workId': workId,
        'busfare': 0, // Add 0 as the default value for busfare
      });
    }

    // Update the document with the new work entries
    await userSkillsDoc.update({'confirmedWork': currentWork});

    if (workSnap.exists) {
      final data = workSnap.data();
      int currentBoysCount = data!['vacancy'];

      if (currentBoysCount > 0) {
        // Decrease the "boysCount" by 1
        currentBoysCount--;

        // Update the Firestore document with the decreased "boysCount"
        await workRef.update({'vacancy': currentBoysCount});
        log('Boys count updated to $currentBoysCount');
      } else {
        log('Boys count is already at zero.');
      }
    } else {
      print('Document with ID $workId does not exist.');
    }

    Get.back(); // Assuming you are using GetX for navigation
  } catch (e) {
    getxSnakBar('Error', 'Error finding is: $e', null);
  }
}

Future<dynamic> workDialogBoxSecond(String uId, String workId) {
  return Get.defaultDialog(
    contentPadding: const EdgeInsets.all(10),
    radius: 6,
    title: "Work Details",
    titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
    middleText:
        "Thank you for choosing this work.After pressing the confirm button,don't miss work",
    middleTextStyle: const TextStyle(
      fontSize: 19,
      color: kBlack,
    ),
    actions: [
      sBoxH20(),
      confirmButton('Cancel', kBlack, kWhite, null),
      sBoxW10(),
      confirmButton('Confirm', kBlack, kWhite, () async {
        await addConfirmedWork([workId], uId, workId);
      }),
    ],
  );
}


import 'dart:developer';

import 'package:catering/Refactoring/methods/others.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';



class ConfirmedWorkController extends GetxController {
 RxList<Map<String, dynamic>> confirmedWorks = <Map<String, dynamic>>[].obs;
  String uId = '';

  @override
  void onInit() {
    super.onInit();
    // confirmedWorks = <Map<String, dynamic>>[].obs;
    getConfirmedWorks();
  }

   void initController(String userId) {
    uId = userId;
    getConfirmedWorks();
  }


// void getConfirmedWorks() async {
//   try {
//     final DocumentSnapshot userSkillsDoc = await FirebaseFirestore.instance
//         .collection('User Reg')
//         .doc(uId)
//         .get();

//     if (userSkillsDoc.exists) {
//      List<Map<String, dynamic>> currentConfirmedWorks =
//             List<Map<String, dynamic>>.from(
//                 userSkillsDoc.get('confirmedWork') ?? []);

//         confirmedWorks.assignAll(currentConfirmedWorks);
//     } else {
//       getxSnakBar('Error', 'User document does not exist for ID: $uId', null);
//     }
//   } catch (e) {
//     // Handle error
//     getxSnakBar('Error', 'Error fetching confirmed works: $e', null);
//   }
// }
void getConfirmedWorks() async {
  try {
    final DocumentSnapshot userSkillsDoc = await FirebaseFirestore.instance
        .collection('User Reg')
        .doc(uId)
        .get();

    if (userSkillsDoc.exists) {
      List<Map<String, dynamic>> currentConfirmedWorks =
          List<Map<String, dynamic>>.from(
              userSkillsDoc.get('confirmedWork') ?? []);

      confirmedWorks.assignAll(currentConfirmedWorks);
    } else {
      getxSnakBar('Error', 'User document does not exist for ID: $uId', null);
    }
  } catch (e) {
    // Handle error
    Future.delayed(Duration.zero, () {
      // getxSnakBar('Error', 'Error fetching confirmed works: $e', null);
      log('Error fetching confirmed works: $e');
    });
  }
}

}
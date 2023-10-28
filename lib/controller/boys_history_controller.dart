import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../Refactoring/firebase/variables.dart';
import '../model/user.dart';

class BoysHistoryController extends GetxController {
  final List<UserData> users = <UserData>[].obs;

  @override
  void onInit() {
    fetchRecords();
    userRegCollection.snapshots().listen((records) {
      mapRecords(records);
    });
    super.onInit();
  }

  fetchRecords() async {
    final records = await userRegCollection.get();
    mapRecords(records);
  }

  void mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var list = records.docs.map(
      (item) {
        try {
          // return UserData(
          //   confirmedWork: item['confirmedWork'],
          //   photo: item['photo'],
          //   id: item.id,
          //   name: item['name'] ?? '',
          //   address: item['address'] ?? '',
          //   bloodGroup: item['bloodGroup'] ?? '',
          //   dob: item['dob'] ?? '',
          //   mobile: item['mobile'] ?? 0,
          //   password: item['password'] ?? 0,
          // );
          return UserData.fromJson(item.data(),item.id);
        } catch (e) {
          if (kDebugMode) {
            print('Error parsing document: $e');
          }
          if (kDebugMode) {
            print('Document data: ${item.data()}');
          }
          rethrow; // Rethrow the exception to propagate it further
        }
      },
    ).toList();

    users.assignAll(list);
  }

  deleteUserData(String id) {
    userRegCollection.doc(id).delete();
  }
}

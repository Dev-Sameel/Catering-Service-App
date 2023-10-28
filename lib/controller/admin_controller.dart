import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../Refactoring/firebase/variables.dart';
import '../model/admin.dart';

class AdminController extends GetxController {
  final List<Admin> admin = <Admin>[].obs;

  @override
  void onInit() {
    fetchRecords();
    adminCollection.snapshots().listen((records) {
      mapRecords(records);
    });
    super.onInit();
  }

  fetchRecords() async {
    final records = await adminCollection.get();
    mapRecords(records);
  }

  void mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var list = records.docs.map(
      (item) {
        try {
          return Admin.fromJson(item.data());
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

    admin.assignAll(list);
  }

  deleteUserData(String id) {
    adminCollection.doc(id).delete();
  }
}

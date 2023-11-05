import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../Refactoring/firebase/variables.dart';
import '../model/add_work_model.dart';

class WorkHistoryController extends GetxController {
  final List<AddWorkModel> works = <AddWorkModel>[].obs;

  @override
  void onInit() {
    fetchRecords();
    addWorkCollection.snapshots().listen((records) {
      mapRecords(records);
    });
    super.onInit();
  }

  fetchRecords() async {
    final records = await addWorkCollection.get();
    mapRecords(records);
  }

  void mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var list = records.docs.map(
      (item) {
        try {
          // return UserData(
          //   photo: item['photo'],
          //   id: item.id,
          //   name: item['name'] ?? '',
          //   address: item['address'] ?? '',
          //   bloodGroup: item['bloodGroup'] ?? '',
          //   dob: item['dob'] ?? '',
          //   mobile: item['mobile'] ?? 0,
          //   password: item['password'] ?? 0,
          // );
          return AddWorkModel.fromJson(item.data(),item.id);
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

    works.assignAll(list);
  }

  deleteWorkData(String id) {
    addWorkCollection.doc(id).delete();
  }

  
}

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Refactoring/firebase/variables.dart';
import '../../Refactoring/methods/first_dialogbox.dart';
import '../../Refactoring/methods/others.dart';
import '../../Refactoring/methods/tile_text.dart';
import '../../Refactoring/styles/colors.dart';
import '../../Refactoring/styles/container.dart';
import '../../Refactoring/widgets/drawer_tile.dart';
import '../../Refactoring/widgets/others.dart';
import '../../controller/work_history_controller.dart';
import '../../model/add_work_model.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  final WorkHistoryController controller = Get.put(WorkHistoryController());
  final String? uID;
  HomeScreen({this.uID, super.key});

  Map<String, dynamic>? data;

  Future<Map<String, dynamic>?> getDataFromFirebase() async {
    try {
      CollectionReference<Map<String, dynamic>> collection =
          FirebaseFirestore.instance.collection('User Reg');

      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await collection.doc(uID).get();

      if (documentSnapshot.exists) {
        data = documentSnapshot.data()!;
      } else {
        Get.snackbar('Error', 'Document does not exist');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error retrieving data: $e');
    }
    return null;
  }

  Future<void> checkAttendedWork(
      String code, AddWorkModel data, String workId) async {
    final DocumentSnapshot userSkillsDoc =
        await FirebaseFirestore.instance.collection('User Reg').doc(uID).get();
    // log(userSkillsDoc.data().toString());

    if (userSkillsDoc.exists) {
      List<Map<String, dynamic>> currentConfirmedWorks =
          List<Map<String, dynamic>>.from(
              userSkillsDoc.get('confirmedWork') ?? []);
      log(currentConfirmedWorks.toString());
      // ignore: unused_local_variable
      var count = 0;
      for (int i = 0; i < currentConfirmedWorks.length; i++) {
        log(currentConfirmedWorks[i]['workId']);
        final DocumentSnapshot abcd = await FirebaseFirestore.instance
            .collection('Add Work')
            .doc(currentConfirmedWorks[i]['workId'])
            .get();

        final codecheck = abcd.get('code');
        log('codecheckkkkkkkk$codecheck');
        log('codeeeeeeee$code');
        if (codecheck == code) {
          count++;
        }
      }

      if (count != 0) {
        getxSnakBar(
            'Alert', "You can't attend two works on the same day", null);
      } else {
        await workDialogBoxFirst(data, uID!, workId);
      }
    } else {
      log('User document does not exist for ID: $uID');
    }
  }

  @override
  Widget build(BuildContext context) {
    log(uID.toString());
    List<String> titleMessage = [
      'My Profile',
      'Confirmed Work',
      'Edit Password',
      'Leave Form',
      'Chat',
      'About',
      'Logout',
    ];
    List<String> imagePaths = [
      'assets/images/Icons/name.png',
      'assets/images/Icons/confirmed.png',
      'assets/images/Icons/editpass.png',
      'assets/images/Icons/leave.png',
      'assets/images/Icons/chat.png',
      'assets/images/Icons/about.png',
      'assets/images/Icons/logout.png',
    ];
    return Scaffold(
      backgroundColor: bgColor,
      drawer: FutureBuilder(
          future: getDataFromFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Drawer(
                width: MediaQuery.of(context).size.width*0.72,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height*0.35,
                      child: Image(
                        image: NetworkImage(data?['photo'] ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: ScrollConfiguration(
                          behavior: RemoveGlow(),
                        child: ListView(
                          children: [
                            DrawerTile(
                              title: titleMessage[0],
                              id: 1,
                              imagePaths: imagePaths[0],
                              data: data,
                            ),
                            DrawerTile(
                                uId: uID,
                                title: titleMessage[1],
                                id: 2,
                                imagePaths: imagePaths[1]),
                            DrawerTile(
                                uId: uID,
                                title: titleMessage[2],
                                id: 3,
                                imagePaths: imagePaths[2]),
                            DrawerTile(
                                title: titleMessage[3],
                                id: 4,
                                imagePaths: imagePaths[3]),
                            DrawerTile(
                                uId: uID,
                                data: data,
                                title: titleMessage[4],
                                id: 5,
                                imagePaths: imagePaths[4]),
                            DrawerTile(
                                imagePaths: imagePaths[5],
                                id: 6,
                                title: titleMessage[5]),
                            DrawerTile(
                                title: titleMessage[6],
                                id: 7,
                                imagePaths: imagePaths[6]),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu,
              size: 40.0,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 20, 20, 21),
        title: const Text('HOME'),
        centerTitle: true,
      ),
      body: ScrollConfiguration(
        behavior: RemoveGlow(),
        child: StreamBuilder(
            stream: addWorkCollection.snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              controller.mapRecords(snapshot.data);

              return ListView.builder(
                itemCount: controller.works.length,
                itemBuilder: (context, index) {
                  final workDetails = controller.works[index];
                  final tileColor =
                      workDetails.vacancy <= 0 ? redGradient : greenGradient;
                  return Container(
                    height: 90,
                    margin: const EdgeInsets.only(left: 30, right: 30, top: 25),
                    decoration: hContainerDec(tileColor),
                    child: Center(
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ListTile(
                              onTap: () {
                                checkAttendedWork(workDetails.code, workDetails,
                                    workDetails.id.toString());
                                // log(workDetails.id.toString());
                                // workDialogBoxFirst(workDetails,uID!,workDetails.id.toString());
                              },
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  tileText(workDetails.date, 20,
                                      FontWeight.w500, kWhite),
                                  tileText(capitalize(workDetails.teamName), 18,
                                      FontWeight.w500, kWhite),
                                  tileText('Vacancy : ${workDetails.vacancy}',
                                      18, FontWeight.w500, kWhite)
                                ],
                              ),
                              trailing: FittedBox(
                                fit: BoxFit.fill,
                                child: Column(
                                  children: [
                                    tileText(workDetails.code, 35,
                                        FontWeight.w500, kWhite),
                                    tileText(workDetails.siteTime, 18,
                                        FontWeight.w500, kWhite),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          workDetails.vacancy <= 0
                              ? InkWell(
                                  onTap: () => getxSnakBar(
                                      'Alert⚠', 'This work is full', null),
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 90,
                                        decoration: BoxDecoration(
                                            color: kBlack.withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      const Align(
                                          alignment: Alignment.center,
                                          child: Image(
                                            image: AssetImage(
                                                'assets/images/lock.png'),
                                            width: 40,
                                          )),
                                    ],
                                  ),
                                )
                              : const Icon(null)
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}

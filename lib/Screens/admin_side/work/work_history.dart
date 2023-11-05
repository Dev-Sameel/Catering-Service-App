
import 'dart:developer';

import 'package:catering/Refactoring/widgets/others.dart';
import 'package:catering/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../../../Refactoring/firebase/variables.dart';
import '../../../Refactoring/methods/app_bar_cuper.dart';
import '../../../Refactoring/methods/delete_dialogbox.dart';
import '../../../Refactoring/methods/first_dialogbox.dart';
import '../../../Refactoring/methods/others.dart';
import '../../../Refactoring/methods/tile_text.dart';
import '../../../Refactoring/styles/colors.dart';
import '../../../Refactoring/styles/container.dart';
import '../../../controller/boys_history_controller.dart';
import '../../../controller/work_history_controller.dart';
import '../a_home.dart';
import 'edit_work.dart';

class WorkHistory extends StatelessWidget {
  WorkHistory({Key? key}) : super(key: key);

  final WorkHistoryController controller = Get.put(WorkHistoryController());
  final BoysHistoryController boysHisController = Get.put(BoysHistoryController());

  deleteWorkIdFromBoys(String deleteId)async
  {
    List<UserData> boysData=boysHisController.users;
    for(int i=0;i<boysData.length;i++)
    {
       final DocumentSnapshot userSkillsDoc = await FirebaseFirestore.instance
        .collection('User Reg')
        .doc(boysData[i].id)
        .get();
        log(boysData[i].id.toString());

        List<Map<String, dynamic>> currentConfirmedWorks =
          List<Map<String, dynamic>>.from(
              userSkillsDoc.get('confirmedWork') ?? []);
              log(currentConfirmedWorks.toString());
              for (int j = 0; j < currentConfirmedWorks.length; j++) {
             try{if(currentConfirmedWorks[j]['workId']==deleteId)
              {
                log('found at ${i+1} list');
                currentConfirmedWorks.removeAt(j);
                log('second time${currentConfirmedWorks.toString()}');
              }
              else{
                log('Not found');
              }
              
              }
              catch (e)
              {
                getxSnakBar('Error', e.toString(), null);
              }
              }
              log('after exit looooop======>${currentConfirmedWorks.toString()}');
              await FirebaseFirestore.instance
        .collection('User Reg')
        .doc(boysData[i].id)
        .update({'confirmedWork': currentConfirmedWorks});
              
    }
    
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: 
     
            customAppBar(null, () => Get.offAll(() => const AHomePage()), null, 'WORK HISTORY'),
      
      body: StreamBuilder(
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

          return ScrollConfiguration(
            behavior: RemoveGlow(),
            child: ListView.builder(
              itemCount: controller.works.length,
              itemBuilder: (context, index) {
                final workDetails = controller.works[index];
                final tileColor = workDetails.vacancy<=0 ? redGradient : greenGradient;
                return Card(
                  margin: const EdgeInsets.only(left: 30, right: 30, top: 25),
                  elevation: 10.0,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Slidable(
                    startActionPane: ActionPane(
                      motion: const BehindMotion(),
                      children: [
                        SlidableAction(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          onPressed: (context) {
                            Get.to(() => EditWork(
                              locationMap: workDetails.locationMap,
                                  code: workDetails.code,
                                  id: workDetails.id!,
                                  boysCount: workDetails.boysCount,
                                  date: workDetails.date,
                                  location: workDetails.siteLocation,
                                  siteTime: workDetails.siteTime,
                                  teamName: workDetails.teamName,
                                  workType: workDetails.workType,
                                ));
                          },
                          icon: Icons.edit,
                          label: 'Edit',
                        ),
                        SlidableAction(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          icon: Icons.delete,
                          label: 'Delete',
                          onPressed: (context) {
                              deleteDialogBox(context, () async{
                               controller.deleteWorkData(workDetails.id!);
                               deleteWorkIdFromBoys(workDetails.id!);
                              Get.back();

                            });
                          },
                        ),
                      ],
                    ),
                    child: Container(
                      height: 90,
                      decoration: hContainerDec(tileColor),
                      child: Center(
                        child: Padding(
                       padding: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            onTap: () {
                              workDialogBoxFirst(workDetails, null, null);
                            },
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                tileText(workDetails.date, 20,
                                        FontWeight.w500, kWhite),
                                    tileText(capitalize(workDetails.teamName), 18,
                                        FontWeight.w500, kWhite),
                                    tileText(
                                        'Vacancy : ${workDetails.vacancy}',
                                        18,
                                        FontWeight.w500,
                                        kWhite)
                              ],
                            ),
                            trailing: FittedBox(
                              fit: BoxFit.fill,
                              child: Column(
                                children: [
                                  tileText(workDetails.code, 35, FontWeight.w500, kWhite),
                                  tileText(
                                    workDetails.siteTime,
                                    18,
                                    FontWeight.w500,
                                    kWhite,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

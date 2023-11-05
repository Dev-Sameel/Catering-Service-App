

import 'dart:developer';


import 'package:catering/Refactoring/methods/app_bar_cuper.dart';
import 'package:catering/Refactoring/widgets/others.dart';
import 'package:catering/Screens/boys_side/drawer/confirmed/work_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Refactoring/methods/tile_text.dart';
import '../../../../Refactoring/styles/colors.dart';
import '../../../../Refactoring/styles/container.dart';
import '../../../../controller/confirmed_work.dart';
import '../../../../model/add_work_model.dart';

class ConfirmedWork extends StatelessWidget {
 final String uId;
  
   const ConfirmedWork({required this.uId,super.key});

  @override
 Widget build(BuildContext context) {
  ConfirmedWorkController controller=Get.put(ConfirmedWorkController());
  controller.initController(uId);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: customAppBar(null, null, null, 'CONFIRMED WORK'),
      body: ScrollConfiguration(
        behavior: RemoveGlow(),
        child: Obx(() {
          if (controller.confirmedWorks.isEmpty) {
            return Center(
              child:tileText('No Confirmed Works Available', 20, FontWeight.bold, kWhite.withOpacity(0.3))
            );
          } else {
            return ListView.builder(
              itemCount: controller.confirmedWorks.length,
              itemBuilder: (context, index) {
                // String documesntId = controller.confirmedWorks[index].toString();
                String documentId = controller.confirmedWorks[index]['workId'];
                log(documentId);
                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('Add Work')
                      .doc(documentId)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || !snapshot.data!.exists) {
                      return const Text('Document does not exist');
                    } else {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
      
                      final workDetails = AddWorkModel(
                        vacancy: data['vacancy'],
                        locationMap: data['locationMap'],
                        code: data['code'],
                        boysCount: data['boysCount'],
                        date: data['date'],
                        siteLocation: data['siteLocation'],
                        siteTime: data['siteTime'],
                        teamName: data['teamName'],
                        workType: data['workType'],
                      );
      
                      return Container(
                        height: 90,
                        margin:
                            const EdgeInsets.only(left: 30, right: 30, top: 25),
                        decoration: hContainerDec(greenGradient),
                        child: Center(
                          child: ListTile(
                            onTap: () {
                               Get.to(()=>WorkDetails(workDetails: workDetails,uID: uId,windex: index,));
                            },
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                tileText(workDetails.date, 20, FontWeight.w500,
                                    kWhite),
                                tileText(
                                  '${workDetails.teamName} - ${workDetails.boysCount}',
                                  18,
                                  FontWeight.w500,
                                  kWhite,
                                )
                              ],
                            ),
                            trailing: FittedBox(
                              fit: BoxFit.fill,
                              child: Column(
                                children: [
                                  tileText(workDetails.code, 35, FontWeight.w500, kWhite),
                                  tileText(workDetails.siteTime, 18,
                                      FontWeight.w500, kWhite),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            );
          }
        }),
      ),
    );
  }
}
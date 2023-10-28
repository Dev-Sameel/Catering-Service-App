
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../../../Refactoring/firebase/variables.dart';
import '../../../Refactoring/methods/app_bar_cuper.dart';
import '../../../Refactoring/methods/delete_dialogbox.dart';
import '../../../Refactoring/methods/tile_text.dart';
import '../../../Refactoring/styles/colors.dart';
import '../../../Refactoring/styles/container.dart';
import '../../../controller/work_history_controller.dart';
import '../a_home.dart';
import 'edit_work.dart';

class WorkHistory extends StatelessWidget {
  WorkHistory({Key? key}) : super(key: key);

  final WorkHistoryController controller = Get.put(WorkHistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: const Text('Work History'),
        centerTitle: true,
        leading:
            customAppBar(null, () => Get.offAll(() => const AHomePage()), null, 'EDIT PROFILE'),
      ),
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

          return ListView.builder(
            itemCount: controller.works.length,
            itemBuilder: (context, index) {
              final workDetails = controller.works[index];
              final tileColor = index % 2 == 0 ? greenGradient : redGradient;
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
                          deleteDialogBox(context, () {
                            controller.deleteWorkData(workDetails.id!);
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
                      child: ListTile(
                        onTap: () {
                          // workDialogBoxFirst();
                        },
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            tileText(
                              workDetails.date,
                              20,
                              FontWeight.w500,
                              kWhite,
                            ),
                            tileText(
                              '${workDetails.teamName} - ${workDetails.boysCount}',
                              18,
                              FontWeight.w500,
                              kWhite,
                            ),
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
              );
            },
          );
        },
      ),
    );
  }
}

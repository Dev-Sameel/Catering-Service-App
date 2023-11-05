
import 'package:catering/Refactoring/methods/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/add_work_model.dart';
import '../styles/colors.dart';
import '../widgets/elevated_button.dart';
import 'second_dialogbox.dart';
import 'tile_text.dart';

Future<dynamic> workDialogBoxFirst(
    AddWorkModel data, String? uId, String? workId) {
  return Get.defaultDialog(
      radius: 6,
      title: "Work Details",
      titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      middleText: 'Team : ${data.teamName.toUpperCase()}',
      middleTextStyle:
          const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      actions: [
        Container(
          constraints: BoxConstraints(maxWidth: Get.width * 0.8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              doubleText('Location', data.siteLocation),
              doubleText('Site Time', data.siteTime),
              doubleText('Date', data.date),
              doubleText('Type', data.workType),
              doubleText('Boys Count', data.boysCount.toString()),
              sBoxH20(),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:uId!=null? [
                  confirmButton('Cancel', kBlack, kWhite, null),
                  sBoxW10(),
                  confirmButton('Next', kBlack, kWhite, () async {
                    Get.back();
                    await workDialogBoxSecond(uId, workId!);
                  }),
                ]:[]
              )
              
            ],
          ),
        )
      ]);
}

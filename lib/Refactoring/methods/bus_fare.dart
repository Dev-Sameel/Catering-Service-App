import 'dart:developer';



import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/confirmed_work.dart';
import '../firebase/variables.dart';
import '../styles/colors.dart';
import '../widgets/elevated_button.dart';
import '../widgets/text_field.dart';
import 'sizedbox.dart';

Future addBusFire(String? uID, int? index, int value) async {
  final user = await userRegCollection.doc(uID).get();
  List<Map<String, dynamic>> currentConfirmedWorks =
      List<Map<String, dynamic>>.from(user.get('confirmedWork') ?? []);
  currentConfirmedWorks[index!]['busfare'] = value;
  await userRegCollection
      .doc(uID)
      .update({'confirmedWork': currentConfirmedWorks});
      Get.back();
}

baseFareDialog(BuildContext context, String? uID, int? index) {
  final fareController = TextEditingController();
  log(uID ?? '');
  ConfirmedWorkController controller = Get.put(ConfirmedWorkController());
  controller.initController(uID ?? '');
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: SizedBox(
          height: 190,
          child: Column(
            children: [
              const Text('Home to Site Expense\n---------------',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: kRed),textAlign: TextAlign.center,),
              sBoxH20(),
              CustomTextField(
                label: 'Enter Bus Fare',
                enableColor: Colors.grey,
                focusColor: kBlack,
                textColor: kBlack,
                controller: fareController,
                textType: TextInputType.number,
              ),
              sBoxH20(),
              //  confirmButton('ADD', 'cancel',kBlack,kWhite)
              ConfireButton(
                label: 'Add',
                onChanged: () {
                  addBusFire(uID, index, int.parse(fareController.text));
                },
              )
            ],
          ),
        ),
      );
    },
  );
}

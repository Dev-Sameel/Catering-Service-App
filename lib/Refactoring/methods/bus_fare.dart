import 'dart:developer';

import 'package:catering/Refactoring/methods/others.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/confirmed_work.dart';
import '../firebase/variables.dart';
import '../styles/colors.dart';
import '../widgets/elevated_button.dart';
import '../widgets/text_field.dart';

Future addBusFire(
    String? uID, int? index, int value, BuildContext context) async {
  final user = await userRegCollection.doc(uID).get();
  List<Map<String, dynamic>> currentConfirmedWorks =
      List<Map<String, dynamic>>.from(user.get('confirmedWork') ?? []);
  currentConfirmedWorks[index!]['busfare'] = value;
  await userRegCollection
      .doc(uID)
      .update({'confirmedWork': currentConfirmedWorks});
  // ignore: use_build_context_synchronously
  Navigator.pop(context);
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
        contentPadding: const EdgeInsets.all(0),
        backgroundColor: kTransperant,
        content:  Container(
         height: 250,
          padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          
            gradient:orangeGradient
            ,
            
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Home to Site Expense\n---------------',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: kWhite),
                textAlign: TextAlign.center,
              ),
              CustomTextField(
                icon: Icons.attach_money,
                label: 'Enter Bus Fare',
                fiilColor: kBlack
          .withOpacity(0.3),
                controller: fareController,
                textType: TextInputType.number,
              ),
              //  confirmButton('ADD', 'cancel',kBlack,kWhite)
              ConfireButton(
                label: 'Add',
                onChanged: () {
                  if (fareController.text.isNotEmpty) {
                    addBusFire(
                        uID, index, int.parse(fareController.text), context);
                  }
                  else
                  {
                    getxSnakBar('Alert', 'Please Enter BusFare', null);
                  }
                },
              )
            ],
          ),
        ),
      );
    },
  );
}

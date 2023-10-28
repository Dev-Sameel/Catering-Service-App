

import 'package:catering/Screens/admin_side/work/work_history.dart';

import '../../../Refactoring/firebase/variables.dart';
import '../../../Refactoring/methods/app_bar_cuper.dart';
import '../../../Refactoring/methods/image_text.dart';
import '../../../Refactoring/methods/others.dart';
import '../../../Refactoring/styles/colors.dart';
import '../../../Refactoring/widgets/custom_dropdown.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Refactoring/widgets/date_picker_buton.dart';
import '../../../Refactoring/widgets/elevated_button.dart';
import '../../../Refactoring/widgets/text_field.dart';
import '../../../model/add_work_model.dart';
import '../../../controller/date_picker.dart';
import '../../../controller/dropdown_controller.dart';

// ignore: must_be_immutable
class EditWork extends StatelessWidget {
  String code;
  String id;
  String teamName;
  String location;
  String siteTime;
  String date;
  int boysCount;
  String workType;
  final teamNameController = TextEditingController();
  final locationController = TextEditingController();
  final codeController = TextEditingController();
  final siteTimeController = TextEditingController();
  final boysCountController = TextEditingController();
  final DatePickerController dateController = Get.put(DatePickerController());

  final CustomDropDownController dropDownController =
      Get.put(CustomDropDownController());

  EditWork({
    super.key,
    required this.id,
    required this.code,
    required this.boysCount,
    required this.date,
    required this.location,
    required this.siteTime,
    required this.teamName,
    required this.workType,
  });

  Future addWorkToFireStore() async {
    var updatedWorkDetails = AddWorkModel(
        boysCount: int.parse(boysCountController.text),
        date: parseDateDrop(dateController.selectedDate.value!),
        siteLocation: locationController.text,
        siteTime: siteTimeController.text,
        code: codeController.text,
        teamName: teamNameController.text,
        workType: dropDownController.selectedValue.value);
    await addWorkCollection.doc(id).update(updatedWorkDetails.toJson());
   Future.delayed(Duration.zero, () {
    Get.offAll(() => WorkHistory());
  });
   codeController.text='';
   teamNameController.text = '';
    locationController.text = '';
    siteTimeController.text = '';
    dropDownController.selectedValue.value = '';
    boysCountController.text = '';
    dateController.selectedDate.value = null;

  }

  @override
  Widget build(BuildContext context) {
    codeController.text=code;
    teamNameController.text = teamName;
    locationController.text = location;
    siteTimeController.text = siteTime;
    dropDownController.selectedValue.value = workType;
    boysCountController.text = boysCount.toString();
    dateController.selectedDate.value = DateFormat('dd MMM yyyy').parse(date);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      appBar: customAppBar(null, null, null, 'EDIT WORK'),
      body: Container(
        height: 500,
        margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomTextField(
              fiilColor: kBlack
        .withOpacity(0.3),
              icon: Icons.event_note,
              label: 'Team Name',
              controller: teamNameController,
            ),
            CustomTextField(
              fiilColor: kBlack
        .withOpacity(0.3),
              icon: Icons.location_on,
              label: 'Site Location',
              controller: locationController,
            ),
            CustomTextField(
              fiilColor: kBlack
        .withOpacity(0.3),
              icon: Icons.timer,
              label: 'Site Time',
              controller: siteTimeController,
            ),
            CustomDropDown(
                menuItems: const ['BreakFast', 'Lunch', 'Dinner'],
                label: 'Select Work Type'),
                CustomTextField(fiilColor: kBlack
        .withOpacity(0.3),label: 'Work Id',controller: codeController,icon: Icons.numbers,),  
            CustomTextField(
              fiilColor: kBlack
        .withOpacity(0.3),
              icon: Icons.format_list_numbered,
              label: 'Boys Count',
              textType: TextInputType.number,
              controller: boysCountController,
            ),
            CustomDatePicker(label: 'Date Of Birth'),
            ConfireButton(
              
                label: 'Update',
                onChanged: () async {
                   if (siteTimeController.text.isNotEmpty &&
                      teamNameController.text.isNotEmpty &&
                      dateController.selectedDate.value != null &&
                      dropDownController.selectedValue.value != '' &&
                      codeController.text.isNotEmpty&&
                      locationController.text.isNotEmpty &&
                      boysCountController.text.isNotEmpty) {
                    await addWorkToFireStore();
                  } else {
                    
                    getxSnakBar('Alert', 'Please fill all fields', null);
                  }

                 
                })
          ],
        ),
      ),
    );
  }
}

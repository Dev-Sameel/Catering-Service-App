



import 'dart:developer';

import 'package:catering/Refactoring/widgets/others.dart';
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
  String locationMap;
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
  final mapController = TextEditingController();
  final DatePickerController dateController = Get.put(DatePickerController());

  final CustomDropDownController dropDownController =
      Get.put(CustomDropDownController());

  EditWork({
    super.key,
    required this.locationMap,
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
    final  workRef=await addWorkCollection.doc(id).get();
    final workData= workRef.data();
    log('vacccaaacac${workData!['vacancy'].toString()}');
    log('boysssssss${workData['boysCount'].toString()}');

    var updatedWorkDetails = AddWorkModel(
      vacancy: workData['vacancy'],
        locationMap: mapController.text,
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
    mapController.text='';

  }

  @override
  Widget build(BuildContext context) {
    codeController.text=code;
    mapController.text=locationMap;
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
          padding: const EdgeInsets.all(20.0),
          margin: const EdgeInsets.all(20.0),
        child: ScrollConfiguration(
          behavior: RemoveGlow(),
          child: ListView(
             itemExtent: 70.0,
          shrinkWrap: true,
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
                label: 'Location Name',
                controller: locationController,
              ),
              CustomTextField(
                fiilColor: kBlack
          .withOpacity(0.3),
                icon: Icons.location_on,
                label: 'Location Map',
                controller: mapController,
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
                     mapController.text.isNotEmpty&&
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
      ),
    );
  }
}

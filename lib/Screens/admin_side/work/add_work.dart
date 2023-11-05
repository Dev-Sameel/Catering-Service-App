


import 'package:catering/Refactoring/widgets/others.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Refactoring/firebase/variables.dart';
import '../../../Refactoring/methods/app_bar_cuper.dart';
import '../../../Refactoring/methods/image_text.dart';
import '../../../Refactoring/methods/others.dart';
import '../../../Refactoring/styles/colors.dart';
import '../../../Refactoring/widgets/custom_dropdown.dart';
import '../../../Refactoring/widgets/date_picker_buton.dart';
import '../../../Refactoring/widgets/elevated_button.dart';
import '../../../Refactoring/widgets/text_field.dart';
import '../../../controller/date_picker.dart';
import '../../../controller/dropdown_controller.dart';
import '../../../model/add_work_model.dart';
import 'work_history.dart';

class AddWork extends StatelessWidget {
  final teamNameController = TextEditingController();
  final codeController = TextEditingController();
  final mapController = TextEditingController();
  final locationController = TextEditingController();
  final siteTimeController = TextEditingController();
  final boysCountController = TextEditingController();
  final DatePickerController dateController = Get.put(DatePickerController());
  final CustomDropDownController dropDownController =
      Get.put(CustomDropDownController());

  AddWork({super.key});

  Future addWorkToFireStore() async {
    var workDetails = AddWorkModel(
      vacancy: int.parse(boysCountController.text),
      locationMap: 'Location Not Added',
        boysCount: int.parse(boysCountController.text),
        date: parseDateDrop(dateController.selectedDate.value!),
        code: codeController.text,
        siteLocation: locationController.text,
        siteTime: siteTimeController.text,
        teamName: teamNameController.text,
        workType: dropDownController.selectedValue.value);
    await addWorkCollection.add(workDetails.toJson());
    Get.offAll(()=>WorkHistory());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      appBar: customAppBar(null, null, null, 'ADD WORK'),
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
              CustomTextField(fiilColor: kBlack
          .withOpacity(0.3),
                icon: Icons.event_note,
                label: 'Team Name',
                controller: teamNameController,
              ),
              CustomTextField(fiilColor: kBlack
          .withOpacity(0.3),
                icon: Icons.location_city,
                label: 'Location Name',
                controller: locationController,
              ),
                 CustomTextField(fiilColor: kBlack
          .withOpacity(0.3),
                icon: Icons.location_on,
                label: 'Location Map',
                controller: mapController,
              ),
              CustomTextField(fiilColor: kBlack
          .withOpacity(0.3),
                icon: Icons.timer,
                label: 'Site Time',
                controller: siteTimeController,
              ),
              CustomDropDown(
                  menuItems: const ['BreakFast', 'Lunch', 'Dinner'],
                  label: 'Select Work Type'),
        
              CustomTextField(label: 'Work Id',controller: codeController,icon: Icons.numbers,fiilColor: kBlack
          .withOpacity(0.3),),    
              CustomTextField(
                fiilColor: kBlack
          .withOpacity(0.3),
                icon: Icons.format_list_numbered,
                label: 'Boys Count',
                textType: TextInputType.number,
                controller: boysCountController,
              ),
              CustomDatePicker(label: 'Date'),
              ConfireButton(
                
                  label: 'ADD',
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/date_picker.dart';

import '../methods/image_text.dart';
import '../styles/colors.dart';

class CustomDatePicker extends StatelessWidget {
  final String label;
final DatePickerController controller=Get.put(DatePickerController());

  CustomDatePicker({ required this.label, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          onTap: () async {
            final date = await showDatePicker(
                context: context,
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: kWhite,
            onSecondary: Color.fromARGB(255, 230, 0, 0),
            onPrimary: Color.fromARGB(255, 0, 26, 44),
            surface: Color.fromARGB(255, 0, 37, 248),
            onSurface: Color.fromARGB(255, 255, 255, 255),
            secondary: Colors.white,
            
          ),
          dialogBackgroundColor: const Color.fromARGB(255, 0, 26, 44),
          textTheme: const TextTheme(
            titleMedium: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
        child: child ?? const Text(""),
      );
    },
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(9999, 12, 31),
  
            );

            if (date != null) {
              controller.setDate(date);
            }
          },
         child: Obx(() => Container(
            margin: EdgeInsets.only(bottom: 19),
            // width: double.infinity,
            decoration: BoxDecoration(
              color: kBlack
        .withOpacity(0.3),
              border: Border.all(color: kWhite,width: 1.5),
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50),bottomRight: Radius.circular(50)),
            ),
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 40),
              child: Row(
                children: [
                  const Icon(Icons.calendar_month, size: 23, color: kWhite),
                  Expanded(
                    child: Center(
                      child: Text(
                        controller.selectedDate.value == null
                            ? label
                            : parseDateDrop(controller.selectedDate.value!),
                        style:  TextStyle(color:controller.selectedDate.value == null? kWhite.withOpacity(0.8):kWhite, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
   

 
}

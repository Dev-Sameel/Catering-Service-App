import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/dropdown_controller.dart';
import '../styles/colors.dart';

// ignore: must_be_immutable
class CustomDropDown extends StatelessWidget {
  CustomDropDownController controller = Get.put(CustomDropDownController());
  List<String> menuItems = [];
  String label;
  CustomDropDown({required this.label, required this.menuItems, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      margin: EdgeInsets.only(bottom: 19),
      decoration: BoxDecoration(
        color: kBlack
        .withOpacity(0.3),
        border: Border.all(color: kWhite,width: 1.5),
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50),bottomRight: Radius.circular(50)),
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            const Icon(Icons.category, size: 23, color: kWhite),
            Expanded(
              child: Center(
                child: Obx(() {
                  return DropdownButton<String>(
                    value: controller.selectedValue.value == ''
                        ? null
                        : controller.selectedValue.value,
                    onChanged: (value) {
                      controller.updateSelectedValue(value);
                    },
                    dropdownColor: Color.fromARGB(255, 85, 22, 2),
                    iconEnabledColor: kWhite,
                    borderRadius: BorderRadius.circular(10),
                    underline: const SizedBox(),
                    hint: Text(label, style:  TextStyle(color: kWhite.withOpacity(0.8))),
                    items: menuItems.map((e) {
                      return DropdownMenuItem<String>(
                        value: e,
                        child: Text(e, style: const TextStyle(color: kWhite)),
                      );
                    }).toList(),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

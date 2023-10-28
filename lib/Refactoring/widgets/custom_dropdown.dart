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
      decoration: BoxDecoration(
        color: kBlack
        .withOpacity(0.3),
        border: Border.all(color: cFire),
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
                    dropdownColor: kBlack,
                    borderRadius: BorderRadius.circular(10),
                    underline: const SizedBox(),
                    hint: Text(label, style: const TextStyle(color: kWhite)),
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

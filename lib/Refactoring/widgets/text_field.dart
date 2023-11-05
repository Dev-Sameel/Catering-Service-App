import 'package:country_picker/country_picker.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/authontication_controll.dart';
import '../styles/colors.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  AuthenticationControll authController = Get.put(AuthenticationControll());
  IconData? icon;
  String? checkValue;
  Color? fiilColor;
  Color? borderColor;
  TextEditingController? controller;
  Color enableColor;
  Color focusColor;
  Color textColor;
  final String label;
  IconData? seIcon;
  final int? length;
  final TextInputType? textType;
  final bool showHintText;
  final bool showLabel;
  final ValueChanged<String>? onChanged;
  Color? iconColor;

  CustomTextField({
    this.fiilColor = Colors.grey,
    this.iconColor = kWhite,
    this.onChanged,
    this.checkValue,
    this.seIcon,
    this.controller,
    this.showHintText = true,
    this.showLabel = false,
    this.enableColor = kWhite,
    this.focusColor = kBlack,
    this.textColor = kWhite,
    this.length,
    this.icon,
    required this.label,
    this.textType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return TextField(
        obscureText: checkValue == 'password'
            ? authController.isPasswordVisible.value
            : authController.isPasswordNonVisible.value,
        onChanged: onChanged,
        maxLength: length,
        controller: controller,
        textAlign: TextAlign.center,
        style: TextStyle(color: textColor),
        keyboardType: textType,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            fillColor: fiilColor,
            filled: true,
            suffixIcon: checkValue == 'password'
                ? InkWell(
                    child: Icon(
                      authController.isPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: kBlack,
                      size: 20,
                    ),
                    onTap: () {
                      authController.isPasswordVisible.value =
                          !authController.isPasswordVisible.value;
                    },
                  )
                : Icon(
                    seIcon,
                    color: iconColor,
                    size: 25,
                  ),
            prefixIcon: checkValue == 'phoneAuth'
                ? Container(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        authController.controllerText.value;
                        showCountryPicker(
                            context: context,
                            countryListTheme: const CountryListThemeData(
                              bottomSheetHeight: 550,
                            ),
                            onSelect: (value) {
                              // Restrict selection to India
                              if (value.countryCode == 'IN') {
                                authController.setSelectedCountry(value);
                              } else {
                                Get.snackbar('Alert', 'Only India is allowed',
                                    backgroundColor: kWhite);
                              }
                            });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${authController.selectedCountry.value.flagEmoji} + ${authController.selectedCountry.value.phoneCode}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: kWhite,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ))
                : Icon(
                    icon,
                    color: iconColor,
                    size: 25,
                  ),
            counterStyle: TextStyle(color: textColor),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: focusColor, width: 1.5),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: enableColor, width: 1.5),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50)),
            ),
            isDense: true,
            hintText: showHintText ? label : null,
            hintStyle: TextStyle(
              color: textColor.withOpacity(0.8),
            ),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(50))),
      );
    });
  }
}




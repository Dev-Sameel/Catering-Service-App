
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../methods/buttons.dart';
import '../methods/date_picker.dart';
import '../styles/colors.dart';

class CostumEButton extends StatelessWidget {
  final LinearGradient? gradient;
  final double? radius;
  final String label;
  final VoidCallback onChanged;

  const CostumEButton(
      {super.key,
      required this.onChanged,
      required this.label,
      this.radius = 50,
      this.gradient = buttonGradient});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: gradient, borderRadius: BorderRadius.circular(radius!)),
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onChanged,
        style: ButtonStyle(
          backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
          foregroundColor: const MaterialStatePropertyAll(bgColor),
          shadowColor: const MaterialStatePropertyAll(Colors.transparent),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
              color: kWhite,
              fontSize: MediaQuery.of(context).size.height / 42,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

SizedBox confirmButton(
    String text, Color bColor, Color tColor, VoidCallback? onChanged) {
  return SizedBox(
      width: 100,
      child: TextButton(
        onPressed: onChanged ??
            () {
              // if (value == 'next') {
              //   Get.back();
              //   // workDialogBoxSecond();
              // } else if (value == 'confirm') {
              //   Get.back();
              // } else {
              //   Get.back();
              // }

              Get.back();
            },
        child: Text(
          text,
          style: const TextStyle(color: bFire, fontSize: 20),
        ),
      ));
}

datePickerButton(BuildContext context, String label) {
  return InkWell(
    overlayColor: const MaterialStatePropertyAll(kTransperant),
    onTap: () {
      datePicker(context);
    },
    child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: cFire),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Container(
          margin: const EdgeInsets.only(left: 10, right: 40),
          child: Row(
            children: [
              const Icon(Icons.calendar_month, size: 23, color: kWhite),
              Expanded(
                child: Center(
                  child: Text(
                    label,
                    style: const TextStyle(color: kWhite, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        )),
  );
}

class ConfireButton extends StatelessWidget {
  final Color? bColor;
  final Color? fColor;
  final String label;
  final VoidCallback onChanged;
  const ConfireButton({
    super.key,
    required this.label,
    required this.onChanged,
    this.bColor = cFire,
    this.fColor = bgColor,
  });

  @override
  Widget build(BuildContext context) {
    final mWidth = MediaQuery.of(context).size.width;
    final mHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.only(bottom: 19),
      decoration: BoxDecoration(
        
          color: bgColor, borderRadius: BorderRadius.circular(50)),
      width: mWidth * 0.3,
      height: mHeight * 0.06,
      child: ElevatedButton(
        onPressed: onChanged,
        style: customBStyle(bColor!, fColor!),
        child: Text(
          label,
          style: TextStyle(
              color: kWhite,
              fontSize: mHeight / 43,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class CustomEButton2 extends StatelessWidget {
  final VoidCallback onPressed;
  final double kHeight;

  const CustomEButton2(
      {super.key, required this.kHeight, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kHeight / 15,
      width: double.infinity,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                offset: const Offset(5, 5),
                color: kBlack.withOpacity(0.25),
                spreadRadius: 0,
                blurRadius: 15)
          ],
          borderRadius: BorderRadius.circular(50),
          border:
              Border.all(width: 2.5, color: const Color.fromARGB(162, 255, 123, 0)),
          gradient: buttonGradient2),
      child: ElevatedButton(
        onPressed: onPressed,
        style: const ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(kTransperant),
            backgroundColor: MaterialStatePropertyAll(kTransperant),
            shadowColor: MaterialStatePropertyAll(kTransperant),
            overlayColor: MaterialStatePropertyAll(kTransperant)),
        child: Text('Login',
            style: TextStyle(
                color: kWhite,
                fontWeight: FontWeight.bold,
                fontSize: kHeight / 39)),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;
  final double tSize;
  const CustomTextButton({
    required this.onPressed,
    required this.color,
    required this.tSize,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: const ButtonStyle(
            overlayColor:
                MaterialStatePropertyAll(kTransperant)),
        onPressed: onPressed,
        child:  Text(
          text,
          style: TextStyle(color: color,fontSize: tSize),
        ));
  }
}

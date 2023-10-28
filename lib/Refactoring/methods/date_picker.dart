import 'package:flutter/material.dart';

import '../styles/colors.dart';


datePicker(BuildContext context) {
  return showDatePicker(
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
}
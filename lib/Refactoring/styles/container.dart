import 'package:flutter/material.dart';

BoxDecoration hContainerDec(RadialGradient tileColor) {
  return BoxDecoration(
      boxShadow: contShadow(),
      gradient: tileColor,
      borderRadius: const BorderRadius.all(Radius.circular(10)));
}

contShadow() {
  return [
    const BoxShadow(
      color: Color.fromARGB(255, 78, 78, 78),
      blurRadius: 15,
      spreadRadius: 1,
      offset: Offset(5, 5),
    ),
    const BoxShadow(
      color: Color.fromARGB(255, 0, 0, 0),
      blurRadius: 15,
      spreadRadius: 1,
      offset: Offset(-5, -5),
    ),
  ];
}



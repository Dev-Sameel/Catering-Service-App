import 'package:flutter/material.dart';

const aFire = Color.fromRGBO(255, 166, 15, 1);
const bFire = Color.fromRGBO(245, 130, 11, 1);
const cFire = Color.fromRGBO(255, 203, 43, 1);
const kWhite = Colors.white;
const kBlack = Colors.black;
const kRed = Colors.red;
const bgColor = Color.fromARGB(255, 36, 35, 34);
const kTransperant = Colors.transparent;
const incomeColor = Color.fromARGB(255, 115, 206, 107);
const expenseColor = Color.fromARGB(255, 223, 89, 89);
const kOrange = Color.fromARGB(255, 255, 60, 0);
const buttonGradient = LinearGradient(
  colors: [aFire, bFire],
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
);

const yellowNwhite = LinearGradient(
  colors: [cFire, kWhite],
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
);

const greenGradient = RadialGradient(
  center: Alignment.topCenter,
  radius: 3,
  colors: [incomeColor, bgColor],
);

const redGradient = RadialGradient(
  center: Alignment.topCenter,
  radius: 3,
  colors: [expenseColor, bgColor],
);

const snakbarGradient = LinearGradient(
  colors: [Color.fromRGBO(212, 247, 145, 1), Color.fromRGBO(9, 191, 215, 1)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

const confirmButtonGradient = LinearGradient(
  colors: [
    Color.fromRGBO(187, 63, 221, 1),
    Color.fromRGBO(251, 109, 169, 1),
    Color.fromRGBO(255, 159, 124, 1),
  ],
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
);

LinearGradient costumGradient(AlignmentGeometry begin, AlignmentGeometry end) {
  return LinearGradient(
    colors: const [aFire, Color.fromRGBO(245, 124, 11, 1)],
    begin: begin,
    end: end,
  );
}

const asd = RadialGradient(
  center: Alignment.topCenter,
  radius: 3,
  colors: [aFire, bFire],
);

const buttonGradient2 = LinearGradient(colors: [
  Color.fromARGB(255, 255, 60, 0),
  Color.fromARGB(255, 255, 115, 0),
  Color.fromARGB(255, 255, 153, 0)
]);

const senderGradient = LinearGradient(colors: [
  Color.fromARGB(255, 75, 75, 75),
  Color.fromARGB(255, 75, 75, 75),
]);

const youGradient = LinearGradient(colors: [
  Color.fromARGB(255, 245, 106, 25),
 Color.fromARGB(255, 255, 159, 81),
   
]);


const orangeGradient = RadialGradient(
  center: Alignment.topCenter,
  radius: 3,
  colors: [  Color.fromARGB(255, 255, 113, 70),
  Color.fromARGB(255, 255, 173, 105),
  Color.fromARGB(255, 255, 227, 185)],
);
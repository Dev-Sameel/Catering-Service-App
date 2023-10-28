import 'package:flutter/material.dart';

import '../styles/colors.dart';

ButtonStyle customBStyle(Color bColor,Color fColor)
{
  return const ButtonStyle(backgroundColor: MaterialStatePropertyAll(kTransperant),foregroundColor: MaterialStatePropertyAll(kTransperant),shadowColor: MaterialStatePropertyAll(kTransperant));
}
import 'package:flutter/material.dart';

import '../styles/colors.dart';

Text tileText(String text, double fontSize, FontWeight fontWeight,Color color) {
  return Text(text,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ));
}

Row doubleText(String title,String subTitle)
{
  return  Row(
                children: [
                  tileText('$title : ', 19, FontWeight.w500, kBlack),
                  Expanded(child: tileText(subTitle, 19,FontWeight.normal , kBlack)),
                ],
              );
}

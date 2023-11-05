
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../styles/colors.dart';
import 'sizedbox.dart';
import 'tile_text.dart';

Container imageNtext(String text, String image,double imageWidth,double height) {
  return Container(
    height: height,
    margin: const EdgeInsets.only(left: 35),
    child: Row(
      children: [
        Image(
          image: AssetImage(image),
          width: imageWidth,
        ),
        sBoxW10(),
        Expanded(child: tileText(text, 20, FontWeight.normal, kBlack)),
      ],
    ),
  );
}

 String parseDateDrop(DateTime date) {
    final formatter = DateFormat('dd MMM yyyy');
    return formatter.format(date);
  }

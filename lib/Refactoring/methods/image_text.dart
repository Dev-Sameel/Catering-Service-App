
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../styles/colors.dart';
import 'sizedbox.dart';
import 'tile_text.dart';

Container imageNtext(String text, String image,double imageWidth,double height,double? leftMarg) {
  return Container(
    height: height,
    margin:  EdgeInsets.only(left: leftMarg??35),
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


InkWell imageNtext2(String image,String title,VoidCallback onpressed,) =>  InkWell(onTap: onpressed,child: Row(children: [Image(image: AssetImage(image),width: 25,),sBoxW10(),tileText(title, 18, FontWeight.normal, kBlack)],));
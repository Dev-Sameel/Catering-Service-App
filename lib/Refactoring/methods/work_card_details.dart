import 'package:flutter/material.dart';

import '../../model/add_work_model.dart';
import '../styles/colors.dart';
import '../styles/container.dart';
import 'bus_fare.dart';
import 'tile_text.dart';
import 'view_full_details.dart';

SizedBox workCardDetails(String text,int value,BuildContext context,String image,AddWorkModel? workDetails,int? index,String? uid) {
  
  return SizedBox(
    height: 150,
    width: 150,
    child: GestureDetector(
      onTap: () {
        value==0 ? viewFullDetails(workDetails!,index,uid) : baseFareDialog(context,uid,index);
      },
      child: Container(
        decoration: BoxDecoration(color: bgColor, boxShadow: contShadow()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
             Image(image: AssetImage(image),width: 40,color: kWhite,),
            tileText(text, 15, FontWeight.normal, kWhite),
          ],
        ),
      ),
    ),
  );
}

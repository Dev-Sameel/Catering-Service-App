


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/add_work_model.dart';
import '../firebase/variables.dart';
import '../styles/colors.dart';

import 'sizedbox.dart';
import 'tile_text.dart';


Future<dynamic> viewFullDetails(AddWorkModel data,int? index,String? uid) async{
  final user = await userRegCollection.doc(uid).get();
  List<Map<String, dynamic>> currentConfirmedWorks =
      List<Map<String, dynamic>>.from(user.get('confirmedWork') ?? []);
 final fare= currentConfirmedWorks[index!]['busfare'] ;
  return Get.defaultDialog(
      radius: 6,
      title: "Work Details",
      titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      middleText: 'Team : ${data.teamName.toUpperCase()}',
      middleTextStyle:
          const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      actions: [
        Container(
          constraints: BoxConstraints(maxWidth: Get.width * 0.8),
          child: Column(
             mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              Row(
               
                children: [
                tileText('Location :', 19, FontWeight.w500, kBlack),
               data.locationMap=='Location Not Added'?const Text(' Map Not Added',style: TextStyle(color: kRed),): IconButton(onPressed: (){
                  
             
                // ignore: deprecated_member_use
                launch(data.locationMap);
            
                }, icon: const Icon(Icons.location_on,size: 45,color: kRed,))
              ],),
              doubleText('Site Time', data.siteTime),
              doubleText('Date', data.date),
              doubleText('Type', data.workType),
              doubleText('Boys Count', data.boysCount.toString()),
              sBoxH20(),
              doubleText('Bus Fare', fare.toString()),
              
            
            ],
          ),
        )
      ]);
}

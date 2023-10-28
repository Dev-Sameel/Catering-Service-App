
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Refactoring/methods/image_text.dart';
import '../../../Refactoring/methods/tile_text.dart';
import '../../../Refactoring/styles/colors.dart';


// ignore: must_be_immutable
class MyProfile extends StatelessWidget {
 
  String name;
  String photo;
  String dob;
  String address;
  int mobile;
  String bloodGroup;
   MyProfile({required this.name,required this.address,required this.dob,required this.bloodGroup,required this.photo,required this.mobile,super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                color: bgColor,
              ),
              Container(
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  children: [
                   
                    imageNtext(
                        '$mobile', 'assets/images/Icons/phone.png', 45),
                    imageNtext(
                        dob, 'assets/images/Icons/birth.png', 45),
                    imageNtext(address,
                        'assets/images/Icons/address.png', 45)
                  ],
                ),
              ),
            ],
          ),
           Positioned(
            top: 55,
            left: 95,
            child: CircleAvatar(
              radius: 90,
              backgroundImage: NetworkImage(photo),
              
            ),
          ),
          Positioned(
              top: 260,
              left: 35,
              child: Container(
                width: 300,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kWhite,
                    boxShadow: [
                      BoxShadow(color: kBlack.withOpacity(0.6), blurRadius: 15),
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    tileText(name, 21, FontWeight.w500, kBlack),
                    imageNtext(bloodGroup, 'assets/images/blood.png', 30)
                  ],
                ),
              )),
          Positioned(
              top: 40,
              left: 12,
              child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    CupertinoIcons.back,
                    color: kWhite,
                    size: 35,
                  )))
        ],
      ),
    );
  }
}

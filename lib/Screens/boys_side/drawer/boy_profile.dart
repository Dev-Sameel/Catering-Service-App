import 'dart:developer';

import 'package:catering/Refactoring/methods/others.dart';
import 'package:catering/Refactoring/widgets/others.dart';
import 'package:catering/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Refactoring/methods/image_text.dart';
import '../../../Refactoring/methods/tile_text.dart';
import '../../../Refactoring/styles/colors.dart';
import '../edit_boys_profile.dart';

// ignore: must_be_immutable
class MyProfile extends StatelessWidget {
  String uId;
  String name;
  String photo;
  String dob;
  String address;
  int mobile;
  String bloodGroup;
  UserData? userData;
  MyProfile(
      {
        required this.uId,
        required this.name,
      required this.address,
      required this.dob,
      required this.bloodGroup,
      required this.photo,
      required this.mobile,
      this.userData,
      super.key});

  @override
  Widget build(BuildContext context) {
    final mHight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.height;
    return Scaffold(
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               Container(
//                 height: 300,
//                 width: double.infinity,
//                 color: bgColor,
//               ),
//               Container(
//                 padding: const EdgeInsets.only(top: 100),
//                 child: Column(
//                   children: [

//                     imageNtext(
//                         '$mobile', 'assets/images/Icons/phone.png', 45),
//                     imageNtext(
//                         dob, 'assets/images/Icons/birth.png', 45),
//                     imageNtext(capitalize(address),
//                         'assets/images/Icons/address.png', 45)
//                   ],
//                 ),
//               ),
//             ],
//           ),
//            Positioned(
//             top: 55,
//             left: 95,
//             child: CircleAvatar(
//               radius: 90,
//               backgroundImage: NetworkImage(photo),

//             ),
//           ),
//           Positioned(
//               top: 260,
//               left: 35,
//               child: Container(
//                 width: 300,
//                 height: 80,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: kWhite,
//                     boxShadow: [
//                       BoxShadow(color: kBlack.withOpacity(0.6), blurRadius: 15),
//                     ]),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     tileText(capitalize(name), 21, FontWeight.w500, kBlack),
//                     imageNtext(bloodGroup, 'assets/images/blood.png', 30)
//                   ],
//                 ),
//               )),
//           Positioned(
//               top: 40,
//               left: 12,
//               child: IconButton(
//                   onPressed: () {
//                     Get.back();
//                   },
//                   icon: const Icon(
//                     CupertinoIcons.back,
//                     color: kWhite,
//                     size: 35,
//                   )))
//         ],
//       ),
//     );
//   }
// }
      body: Stack(
        children: [
          Container(
            color: Color.fromARGB(255, 255, 192, 192).withOpacity(0.5),
            height: mHight * 0.36,
          ),
          Column(
            children: [
              ClipPath(
                clipper: WaveClipper(),
                child: Container(
                    width: double.infinity,
                    height: mHight * 0.36,
                    color: Colors.blue,
                    child: Stack(
                      children: [
                        Image(
                          image: NetworkImage(photo),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                        ProfileContainer(
                          bLeft: 0,
                          bRight: 300,
                          color: Color.fromARGB(255, 255, 192, 192)
                              .withOpacity(0.5),
                          mHeight: mHight * 0.42,
                        ),
                        ProfileContainer(
                          bLeft: 200,
                          bRight: 0,
                          color: Color.fromARGB(255, 189, 201, 255)
                              .withOpacity(0.5),
                          mHeight: mHight * 0.35,
                        ),
                      ],
                    )),
              ),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                      Color.fromARGB(255, 189, 201, 255).withOpacity(0.5),
                      Color.fromARGB(255, 255, 192, 192).withOpacity(0.5)
                    ],
                        begin: Alignment.bottomCenter,
                        end: AlignmentDirectional.topCenter)),
                child: ScrollConfiguration(
                  behavior: RemoveGlow(),
                  child: ListView(
                    children: [
                      imageNtext(capitalize(name),
                          'assets/images/Icons/name.png', 45, 60),
                      imageNtext(
                          '$mobile', 'assets/images/Icons/phone.png', 45, 60),
                      imageNtext(dob, 'assets/images/Icons/birth.png', 45, 60),
                      imageNtext(
                          bloodGroup, 'assets/images/Icons/blood.png', 45, 60),
                      imageNtext(capitalize(address),
                          'assets/images/Icons/address.png', 45, 80)
                    ],
                  ),
                ),
              ))
            ],
          ),
          Positioned(
              top: mHight * 0.22,
              right: mWidth * 0.08,
              child: CircleAvatar(
                radius: 70,
                backgroundColor: kWhite,
                child: CircleAvatar(
                  radius: 65,
                  backgroundColor: kBlack,
                  backgroundImage: NetworkImage(photo),
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
                    color: kBlack,
                    size: 35,
                  ))),
          Positioned(
              top: 40,
              right: 12,
              child: IconButton(
                  onPressed: () {
                    Get.to(() => EditBoysProfile(
                      uId: uId,
                        name: name,
                        address: address,
                        dob: dob,
                        bloodGroup: bloodGroup,
                        photo: photo,
                        mobile: mobile));
                  },
                  icon: const Icon(
                    Icons.edit_note,
                    color: kBlack,
                    size: 35,
                  )))
        ],
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height); // Start at the bottom-left corner

    final firstControlPoint = Offset(size.width / 4, size.height - 20);
    final firstEndPoint = Offset(size.width / 2, size.height - 40);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    final secondControlPoint = Offset(size.width * 3 / 4, size.height - 60);
    final secondEndPoint = Offset(size.width, size.height - 20);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0); // Line to the top-right corner
    path.lineTo(0, 0); // Line back to the top-left corner

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class ProfileContainer extends StatelessWidget {
  final Color color;
  final double bLeft;
  final double bRight;
  final double mHeight;

  const ProfileContainer(
      {super.key,
      required this.bLeft,
      required this.bRight,
      required this.color,
      required this.mHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(bLeft),
              bottomRight: Radius.circular(bRight))),
    );
  }
}

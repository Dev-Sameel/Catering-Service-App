import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../styles/colors.dart';

AppBar customAppBar( Widget? widgetTitle,VoidCallback? onpressed,Widget? action,String? title) {
  return AppBar(
    backgroundColor: bgColor,
    title:title!=null? Text(title):widgetTitle,
    centerTitle: true,
    leading: IconButton(
        onPressed: onpressed ?? () {
                Get.back();
              },
        icon: const Icon(
          CupertinoIcons.back,
          color: kWhite,
          size: 35,
        )),
    actions: title==null?<Widget>[action!]:null,
  );
}
// class CustomAppBar extends StatelessWidget {
//   final String? title;
//   final 
//   const CustomAppBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//     backgroundColor: bgColor,
//     title: Text(title),
//     centerTitle: true,
//     leading: IconButton(
//         onPressed: onpressed ?? () {
//                 Get.back();
//               },
//         icon: const Icon(
//           CupertinoIcons.back,
//           color: kWhite,
//           size: 35,
//         )),
//     actions: title=='BOYS HISTORY'?<Widget>[action!]:null,
//   );
//   }
// }

import 'package:catering/Refactoring/methods/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UiHelper{
  static void showLoadingDialog(String title,BuildContext context)
  {
    AlertDialog loadingDialog=AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
           CircularProgressIndicator(),
           sBoxH20(),
           Text(title),
        ],
      ),
    );
    showDialog(context: context,barrierDismissible: false, builder: (context) {
      return loadingDialog;
    },);
  }

  static void showAlertDialog(BuildContext context,String title,String content)
  {
    AlertDialog alertDialog=AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(onPressed: (){
          Get.back();
        }, child: Text('Ok'))
      ],
    );

    showDialog(context: context, builder: (context) => alertDialog,);
  }
}
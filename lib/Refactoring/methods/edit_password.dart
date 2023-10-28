
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../firebase/variables.dart';
import '../styles/colors.dart';
import '../widgets/elevated_button.dart';
import '../widgets/text_field.dart';
import 'others.dart';

// ignore: non_constant_identifier_names
Future changePass(String Uid,int oldPass,newPass)async
{
  final user=userRegCollection;
  userRegCollection.doc(Uid).get();

   QuerySnapshot querySnapshot =
          await user.where('password', isEqualTo: oldPass).get();
       if (querySnapshot.docs.isNotEmpty) {

        await userRegCollection.doc(Uid).update({'password':newPass});
        Get.back();
        getxSnakBar('success', 'Successfully Updated', null);
       }  
       else {

            getxSnakBar('Error', 'Old password is incorrect', null);
      } 
}

editPassword(BuildContext context,String uID) {
  final oldPassController=TextEditingController();
  final newPassController=TextEditingController();
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: bgColor,
        content: SizedBox(
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            
              CustomTextField(
                controller: oldPassController,
                  label: 'Enter Old Password',
                  // enableColor: Colors.grey,
                  // focusColor: kBlack,
                  // textColor: kBlack),
                  textType: TextInputType.number,
                  length: 5,
              ),
              CustomTextField(
                controller: newPassController,
                  label: 'Enter New Password',
                  // enableColor: Colors.grey,
                  // focusColor: kBlack,
                  // textColor: kBlack),
                  textType: TextInputType.number,
                  length: 5,
              ),
              // confirmButton('Update', 'cancel',cFire,bgColor)
              ConfireButton(label: 'Update', onChanged: () {
                changePass(uID, int.parse(oldPassController.text),int.parse(newPassController.text));
              },)
            ],
          ),
        ),
      );
    },
  );
}

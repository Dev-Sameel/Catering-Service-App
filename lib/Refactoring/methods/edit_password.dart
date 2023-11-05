import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../firebase/variables.dart';
import '../styles/colors.dart';
import '../widgets/elevated_button.dart';
import '../widgets/text_field.dart';
import 'others.dart';

// ignore: non_constant_identifier_names
Future changePass(String Uid, int oldPass, newPass) async {
  final user = userRegCollection;
  userRegCollection.doc(Uid).get();

  QuerySnapshot querySnapshot =
      await user.where('password', isEqualTo: oldPass).get();
  if (querySnapshot.docs.isNotEmpty) {
    await userRegCollection.doc(Uid).update({'password': newPass});
    Get.back();
    getxSnakBar('success', 'Successfully Updated', null);
  } else {
    getxSnakBar('Error', 'Old password is incorrect', null);
  }
}

editPassword(BuildContext context, String uID) {
  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(10.0),
        backgroundColor: kTransperant,
        content: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: orangeGradient,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                  icon: Icons.lock_open,
                  controller: oldPassController,
                  label: 'Enter Old Password',
                  fiilColor: kBlack.withOpacity(0.3),
                  textType: TextInputType.number,
                  length: 5,
                ),
                CustomTextField(
                  icon: Icons.lock,
                  controller: newPassController,
                  label: 'Enter New Password',
                  fiilColor: kBlack.withOpacity(0.3),
                  textType: TextInputType.number,
                  length: 5,
                ),
                ConfireButton(
                  label: 'Update',
                  onChanged: () {
                    if (oldPassController.text.isNotEmpty &&
                        newPassController.text.isNotEmpty) {
                      if (newPassController.length == 5) {
                        changePass(uID, int.parse(oldPassController.text),
                            int.parse(newPassController.text));
                      } else {
                        getxSnakBar('Alert', 'Must Enter 5 Digit Password', null);
                      }
                    } else {
                      getxSnakBar('Alert', 'Please enter a password', null);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}


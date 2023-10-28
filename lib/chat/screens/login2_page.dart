import 'dart:developer';

import 'package:catering/Refactoring/methods/others.dart';
import 'package:catering/Refactoring/styles/colors.dart';
import 'package:catering/Refactoring/widgets/elevated_button.dart';
import 'package:catering/Refactoring/widgets/text_field.dart';
import 'package:catering/chat/screens/sign_up_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helprer/ui_helper.dart';
import '../model/user_model.dart';
import 'chat_home_page.dart';

class LoginPage2 extends StatefulWidget {
  const LoginPage2({super.key});

  @override
  State<LoginPage2> createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void checkValues() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == '' || password == '') {
      getxSnakBar('Incomplete Data', 'Please fill all fields', null);
    } else {
      logIn(email, password);
    }
  }

  void logIn(String email, String password) async {
    UserCredential? credential;
          UiHelper.showLoadingDialog('Loading....', context);

    try {
      credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (ex) {
      Get.back();
      UiHelper.showAlertDialog(context, 'An Error Occured', ex.code.toString());
    }

    if (credential != null) {
      String uid = credential.user!.uid;
      DocumentSnapshot userData =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      UserModel userModel =
          UserModel.fromMap(userData.data() as Map<String, dynamic>);
      log('LogIn Successfully');
       Navigator.push(context, MaterialPageRoute(builder: (context) => ChatHomePage(firebaseUser: credential!.user!, userModel: userModel),));
      //  Get.to(()=>CompleteProfile());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'ChatApp',
                  style: TextStyle(fontSize: 30, color: kRed),
                ),
                CustomTextField(
                  enableColor: kRed,
                  fiilColor: kBlack,
                  label: 'Email Address',
                  controller: emailController,
                ),
                CustomTextField(
                  enableColor: kRed,
                  fiilColor: kBlack,
                  label: 'Password',
                  controller: passwordController,
                ),
                ConfireButton(
                  label: 'Log In',
                  onChanged: () {
                    checkValues();
                  },
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account"),
            TextButton(
              onPressed: () {
                Get.to(() => SignUpPage());
              },
              child: Text("Sign Up"),
            )
          ],
        ),
      ),
    );
  }
}

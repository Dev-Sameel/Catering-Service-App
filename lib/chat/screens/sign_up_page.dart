import 'dart:developer';
// import 'dart:math';

import 'package:catering/chat/helprer/ui_helper.dart';
import 'package:catering/chat/model/user_model.dart';
import 'package:catering/chat/screens/complete_profile.dart';
import 'package:catering/chat/screens/login2_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Refactoring/methods/others.dart';
import '../../Refactoring/styles/colors.dart';
import '../../Refactoring/widgets/elevated_button.dart';
import '../../Refactoring/widgets/text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
    final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController=TextEditingController();

  void checkValues(){
    String email=emailController.text.trim();
    String password=passwordController.text.trim();
    String cPassword=confirmPasswordController.text.trim();

    if(email==''||password==''||cPassword=='')
    {
      getxSnakBar('Incomplete Data', 'Please fill all fields', null);
    }
    else if(password!=cPassword)
    {
      getxSnakBar('Error', 'Password not match', null);
    }
    else
    {
      signUp(email, password);
    }
  }

  void signUp(String email, String password) async{
    UserCredential? credential;
    UiHelper.showLoadingDialog('Creating new account.....', context);
    try{
      credential =await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(ex){
      Get.back();
       UiHelper.showAlertDialog(context, 'An Error Occured', ex.code.toString());
    }

    if(credential!=null)
    {
      String uid=credential.user!.uid;
      UserModel newUser=UserModel(uid: uid,email: email,fullName: '',profilePic: '');
      await FirebaseFirestore.instance.collection('users').doc(uid).set(newUser.toMap()).then((value) {
        log('New User Created');
        Navigator.push(context, MaterialPageRoute(builder: (context) => CompleteProfile(firebaseUser: credential!.user!, userModel: newUser),));
      });
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
                 CustomTextField(
                  enableColor: kRed,
                  fiilColor: kBlack,
                  label: 'Confirm Password',
                  controller: confirmPasswordController,
                ),
                ConfireButton(
                  label: 'Sign Up',
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
            Text("Already have an account"),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Log In"),
            )
          ],
        ),
      ),
    );
  }
}
import 'dart:developer';

import 'package:catering/Screens/boys_side/registration_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Refactoring/firebase/variables.dart';
import '../../../Refactoring/methods/others.dart';
import '../../../Refactoring/styles/colors.dart';
import '../../../Refactoring/widgets/elevated_button.dart';
import '../../../Refactoring/widgets/text_field.dart';
import '../../../controller/authontication_controll.dart';
import '../../admin_side/a_home.dart';
import '../../boys_side/home.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthenticationControll authController =
      Get.put(AuthenticationControll());
  LoginPage({super.key});

  Future<void> checkNameInFirestore(int mobile, int password) async {
    try {
      CollectionReference users = userRegCollection;
      CollectionReference admin = adminCollection;

      QuerySnapshot userQuerySnapshot = await users
          .where('mobile', isEqualTo: mobile)
          .where('password', isEqualTo: password)
          .get();

      QuerySnapshot adminQuerySnapshot = await admin
          .where('phone', isEqualTo: mobile)
          .where('password', isEqualTo: password)
          .get();

      if (userQuerySnapshot.docs.isNotEmpty ||
          adminQuerySnapshot.docs.isNotEmpty) {
        if (userQuerySnapshot.docs.isNotEmpty) {
          String userId = userQuerySnapshot.docs.first.id;
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          await sharedPreferences.setString('splashKey', 'bHome');
          await sharedPreferences.setString('uID',userId);
          log(sharedPreferences.getString('uID').toString());
          log(sharedPreferences.getString('splashKey').toString());
          
          Get.offAll(() => HomeScreen(uID: userId));
        }
        if (adminQuerySnapshot.docs.isNotEmpty) {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          await sharedPreferences.setString('splashKey', 'aHome');
          log(sharedPreferences.getString('splashKey').toString());
          Get.offAll(() => const AHomePage());
        }
        Get.snackbar('success', 'Successfully Login', backgroundColor: kWhite);
      } else {
        Get.snackbar(
            'Error', 'Account not found. Please check username and password',
            backgroundColor: kWhite);
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: kWhite);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      body: Padding(
        padding: EdgeInsets.only(top: mHeight / 8),
        child: Column(
          children: [
            const Image(image: AssetImage('assets/images/3dLogin.png')),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                width: mWidth,
                decoration: const BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(70),
                        topRight: Radius.circular(70))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      length: 10,
                      textColor: kBlack,
                      focusColor: const Color.fromARGB(255, 230, 54, 0),
                      enableColor: const Color.fromARGB(255, 255, 153, 0),
                      fiilColor: const Color.fromARGB(255, 255, 249, 246),
                      iconColor: const Color.fromARGB(255, 194, 45, 0),
                      onChanged: (value) {
                        mobileController.text = value;
                      },
                      icon: Icons.phone,
                      label: 'Mobile Number',
                      textType: TextInputType.number,
                      controller: mobileController,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      length: 5,
                      textColor: kBlack,
                      focusColor: const Color.fromARGB(255, 230, 54, 0),
                      enableColor: const Color.fromARGB(255, 255, 153, 0),
                      fiilColor: const Color.fromARGB(255, 255, 249, 246),
                      iconColor: const Color.fromARGB(255, 194, 45, 0),
                      onChanged: (value) {
                        passwordController.text = value;
                      },
                      icon: Icons.lock,
                      label: 'Password',
                      textType: TextInputType.number,
                      controller: passwordController,
                      checkValue: 'password',
                    ),
                    // Align(
                    //     alignment: Alignment.centerRight,
                    //     child: CustomTextButton(
                    //         color: bgColor,
                    //         tSize: 15,
                    //         text: 'Forgot Password?',
                    //         onPressed: () {})),
                    const SizedBox(height: 15),
                    CustomEButton2(
                        kHeight: mHeight,
                        onPressed: () async {
                          if (mobileController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) {
                            if (mobileController.text.length == 10 &&
                                passwordController.text.length == 5) {
                              await checkNameInFirestore(
                                  int.parse(mobileController.text),
                                  int.parse(passwordController.text));
                            } else {
                              getxSnakBar(
                                  'Alert',
                                  'Must have mobile number is 10 digits and password is 5 digit',
                                  null);
                            }
                          } else {
                            getxSnakBar('Error',
                                'Enter Phonenumber and Password', null);
                          }
                        }),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        CustomTextButton(
                            onPressed: () {
                              Get.to(() => RegistrationScreen());
                            },
                            color: kOrange,
                            tSize: mHeight / 44,
                            text: 'Register')
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

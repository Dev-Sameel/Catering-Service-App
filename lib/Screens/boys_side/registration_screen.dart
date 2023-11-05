import 'dart:developer';
import 'dart:io';

import 'package:catering/Refactoring/methods/sizedbox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Refactoring/firebase/variables.dart';
import '../../../Refactoring/methods/app_bar_cuper.dart';
import '../../../Refactoring/methods/image_text.dart';
import '../../../Refactoring/styles/colors.dart';
import '../../../Refactoring/widgets/custom_dropdown.dart';
import '../../../Refactoring/widgets/date_picker_buton.dart';
import '../../../Refactoring/widgets/elevated_button.dart';
import '../../../Refactoring/widgets/others.dart';
import '../../../Refactoring/widgets/text_field.dart';
import '../../../controller/authontication_controll.dart';
import '../../../controller/date_picker.dart';
import '../../../controller/dropdown_controller.dart';
import '../../../controller/image_controller.dart';
import '../../../model/user.dart';
import '../main_screens/otp.dart';
import '../main_screens/login_page/login_page.dart';

class RegistrationScreen extends StatelessWidget {
    // ignore: non_constant_identifier_names
  final AuthenticationControll AuthControll = Get.put(AuthenticationControll());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final ImagePickerController controller = Get.put(ImagePickerController());
  final DatePickerController dateController = Get.put(DatePickerController());
  final CustomDropDownController dropDownController = Get.put(CustomDropDownController());

    Future addBoyData() async {
    log('hi');
    String downloadURL = await controller.uploadImageToFirebase();
    var addUserData = UserData(
     
      photo: downloadURL,
      name: nameController.text,
      address: addressController.text,
      dob: parseDateDrop(dateController.selectedDate.value!),
      bloodGroup: dropDownController.selectedValue.value,
      mobile: int.parse(mobileController.text),
      password: int.parse(passwordController.text),
    );

       DocumentReference docRef = await userRegCollection.add(addUserData.toJson());
  // Update the id field in addUserData with the generated document ID
  await docRef.update({'id': docRef.id});

  // Now addUserData contains the generated ID
  addUserData.id = docRef.id;
    Get.offAll(()=>LoginPage());
  }

  RegistrationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
        appBar: customAppBar(null, null, null, 'REGISTRATION'),
        body: Container(
          decoration: BoxDecoration(
            gradient:orangeGradient
            ,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
              ),
            ],
          ),
          padding: const EdgeInsets.all(20.0),
          margin: const EdgeInsets.all(20.0),
          child:  Column(
            children: [
              Obx(() {
                return Stack(
                  alignment: Alignment.center,
                  children: [
              
                    controller.image.value.path == ''
                        ? Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration:  BoxDecoration(
                              
                              border: Border.all(color: kWhite,width: 3),
                              boxShadow: const [
                                BoxShadow(
                                 
                                  blurRadius: 10,
                                  color: Color.fromARGB(255, 134, 62, 40)
                                ),
                              ],
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              backgroundColor: bgColor,
                              radius: 70,
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/uploadImage.png',
                                  fit: BoxFit.cover,
                                  width: 140,
                                  height: 140,
                                ),
                              ),
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration:  BoxDecoration(
                              border:  Border.all(color: kWhite,width: 3),
                              boxShadow: const [
                                BoxShadow(
                                 
                                  
                                  blurRadius: 10,
                                  color: Color.fromARGB(255, 134, 62, 40)
                                ),
                              ],
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              backgroundColor: bgColor,
                              radius: 70,
                              child: ClipOval(
                                child: Image.file(
                                  File(controller.image.value.path),
                                  fit: BoxFit.cover,
                                  width: 140,
                                  height: 140,
                                ),
                              ),
                            ),
                          ),
                    Positioned(
                      bottom: 20,
                      right: 0,
                      child: IconButton(
                          onPressed: () {
                            controller.getImage();
                          },
                          icon: const Icon(
                            Icons.add_a_photo,
                            color: kWhite,
                            size: 35,
                            shadows: [
                              Shadow(
                                  color: Color.fromARGB(255, 134, 62, 40),
                                  blurRadius: 20,
                                  offset: Offset(1, 5))
                            ],
                          )),
                    ),
                    
                  ],
                );
              }),
              Expanded(
                child: SizedBox(
                  height: 500,
                  child: ScrollConfiguration(
                    behavior: RemoveGlow(),
                    child: ListView(
                          itemExtent: 70.0,
        shrinkWrap: true,
                      children: [
                        CustomTextField(
                          enableColor: kWhite,
                          focusColor: kBlack,
                          
                          fiilColor: kBlack
                        .withOpacity(0.3),
                            label: 'Name',
                            controller: nameController,
                            icon: Icons.person),
                        CustomTextField(
                          enableColor: kWhite,
                          focusColor: kBlack,
                          fiilColor: kBlack
                        .withOpacity(0.3),
                          label: 'Address',
                          controller: addressController,
                          icon: Icons.location_pin,
                        ),
                        CustomDatePicker(label: 'Date Of Birth',),
                        CustomDropDown(
                            label: 'Select Blood Group',
                            menuItems: const [
                              'A+ve',
                              'A-ve',
                              'B+ve',
                              'B-ve',
                              'O+ve',
                              'O-ve',
                              'AB+ve',
                              'AB-ve',
                            ]),
                        CustomTextField(
                          enableColor: kWhite,
                          focusColor: kBlack,
                          fiilColor: kBlack
                        .withOpacity(0.3),
                          checkValue: 'phoneAuth',
                          icon: Icons.phone,
                          label: 'Mobile Number',
                          length: 10,
                          textType: TextInputType.number,
                          controller: mobileController,
                        ),
                        CustomTextField(
                          enableColor: kWhite,
                          focusColor: kBlack,
                          fiilColor: kBlack
                        .withOpacity(0.3),
                          icon: Icons.lock,
                          label: 'Password',
                          length: 5,
                          textType: TextInputType.number,
                          controller: passwordController,
                        ),
                        // ElevatedButton(
                        //   style: customBStyle(cFire, kBlack),
                        //   onPressed: () async {
                        //     if (
                        //       // controller.image.value.path != '' &&
                        //         nameController.text.isNotEmpty &&
                        //         addressController.text.isNotEmpty &&
                        //         dateController.selectedDate.value != null &&
                        //         dropDownController.selectedValue.value != '' &&
                        //         mobileController.text.isNotEmpty &&
                        //         passwordController.text.isNotEmpty) {
                        //       // signInWithPhoneNumber(
                        //       //     "+${AuthControll.selectedCountry.value.phoneCode}${mobileController.text}",
                        //       //     controller.image.value.path,
                        //       //     nameController.text,
                        //       //     addressController.text,
                        //       //     dateController.selectedDate.value!,
                        //       //     dropDownController.selectedValue.value,
                        //       //     mobileController.text,
                        //       //     passwordController.text);
                        //       await addBoyData();
                        //     } else {
                        //       Get.snackbar('Alert',
                        //           'Please fill all fields and select an image',
                        //           backgroundColor: kWhite);
                        //     }
                        //   },
                        //   child: const Text('Add'),
                        // ),
                        ConfireButton(label: 'ADD', onChanged:() async{
                           if (
                              controller.image.value.path != '' &&
                                nameController.text.isNotEmpty &&
                                addressController.text.isNotEmpty &&
                                dateController.selectedDate.value != null &&
                                dropDownController.selectedValue.value != '' &&
                                mobileController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty) {
                              signInWithPhoneNumber(
                                  "+${AuthControll.selectedCountry.value.phoneCode}${mobileController.text}",
                                  controller.image.value.path,
                                  nameController.text,
                                  addressController.text,
                                  dateController.selectedDate.value!,
                                  dropDownController.selectedValue.value,
                                  mobileController.text,
                                  passwordController.text);
                              // await addBoyData();
                            } else {
                              Get.snackbar('Alert',
                                  'Please fill all fields and select an image',
                                  backgroundColor: kWhite);
                            }
                                
                                
                        }, )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

  Future<void> signInWithPhoneNumber(
    String phoneNumber,
    String image,
    String name,
    String address,
    DateTime date,
    String dropdown,
    String mobile,
    String password,
  ) async {
    log(phoneNumber);
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) async {
        String smsCode = '';
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: smsCode,
        );
        Get.to(()=>
            OtpPage(
                date: date,
                address: address,
                dropdown: dropdown,
                image: image,
                mobile: mobile,
                name: name,
                password: password,
                phoneNumber: phoneNumber),
            arguments: [verificationId]);
        await auth.signInWithCredential(credential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  



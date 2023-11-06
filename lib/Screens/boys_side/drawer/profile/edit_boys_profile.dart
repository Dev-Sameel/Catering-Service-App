import 'dart:developer';
import 'dart:io';

import 'package:catering/Screens/boys_side/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../../Refactoring/firebase/variables.dart';
import '../../../../../Refactoring/methods/app_bar_cuper.dart';
import '../../../../../Refactoring/methods/image_text.dart';
import '../../../../../Refactoring/styles/colors.dart';
import '../../../../../Refactoring/widgets/custom_dropdown.dart';
import '../../../../../Refactoring/widgets/date_picker_buton.dart';
import '../../../../../Refactoring/widgets/elevated_button.dart';
import '../../../../../Refactoring/widgets/others.dart';
import '../../../../../Refactoring/widgets/text_field.dart';
import '../../../../../controller/authontication_controll.dart';
import '../../../../../controller/date_picker.dart';
import '../../../../../controller/dropdown_controller.dart';
import '../../../../../controller/image_controller.dart';
import '../../../../../model/user.dart';
import '../../../../Refactoring/methods/tile_text.dart';

// ignore: must_be_immutable
class EditBoysProfile extends StatelessWidget {
  String uId;
  String name;
  String photo;
  String dob;
  String address;
  int mobile;
  String bloodGroup;
  UserData? userData;

  EditBoysProfile(
      {required this.uId,
      required this.name,
      required this.address,
      required this.dob,
      required this.bloodGroup,
      required this.photo,
      required this.mobile,
      this.userData,
      super.key});
  // ignore: non_constant_identifier_names
  final AuthenticationControll AuthControll = Get.put(AuthenticationControll());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final ImagePickerController controller = Get.put(ImagePickerController());
  final DatePickerController dateController = Get.put(DatePickerController());
  final CustomDropDownController dropDownController =
      Get.put(CustomDropDownController());

  Future updateBoyProfile() async {
    log('hi');
    if (controller.image.value.path != '') {
      await controller.deleteImageFromFirebase(photo);
      String downloadURL = await controller.uploadImageToFirebase();
      await userRegCollection.doc(uId).update({
        'photo': downloadURL,
        'name': nameController.text,
        'address': addressController.text,
        'dob': parseDateDrop(dateController.selectedDate.value!),
        'bloodGroup': dropDownController.selectedValue.value
      });

      log(downloadURL);
      log(nameController.text);
      log(addressController.text);
      log(parseDateDrop(dateController.selectedDate.value!));
      log(dropDownController.selectedValue.value);
      log('not null image');
    }
    else{
      
      
      await userRegCollection.doc(uId).update({
        
        'name': nameController.text,
        'address': addressController.text,
        'dob': parseDateDrop(dateController.selectedDate.value!),
        'bloodGroup': dropDownController.selectedValue.value
      });

      log(nameController.text);
      log(addressController.text);
      log(parseDateDrop(dateController.selectedDate.value!));
      log(dropDownController.selectedValue.value);
      log('null');
    
    }

    // var updateBoyProfile = UserData(
    //   photo: downloadURL,
    //   name: nameController.text,
    //   address: addressController.text,
    //   dob: parseDateDrop(dateController.selectedDate.value!),
    //   bloodGroup: dropDownController.selectedValue.value,
    //   mobile: int.parse(mobileController.text),
    //   password: int.parse(passwordController.text),
    // );

    // await userRegCollection.doc(uId).update({'photo': downloadURL,'name':nameController.text,'address':addressController.text,'dob':parseDateDrop(dateController.selectedDate.value!),'bloodGroup':dropDownController.selectedValue.value});

    Get.offAll(()=>HomeScreen(uID: uId,));
  }

  @override
  Widget build(BuildContext context) {
    log(photo);
    controller.networkImageUrl.value = photo;
    nameController.text = name;
    addressController.text = address;
    dateController.selectedDate.value = DateFormat('dd MMM yyyy').parse(dob);
    dropDownController.selectedValue.value = bloodGroup;

    return Scaffold(
        backgroundColor: bgColor,
        appBar: customAppBar(null, null, null, 'EDIT PROFILE'),
        body: Container(
          height: MediaQuery.of(context).size.height*0.75,
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
          padding: const EdgeInsets.all(20.0),
          margin: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Obx(() {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    controller.image.value.path == ''
                        ? Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              border: Border.all(color: kWhite, width: 3),
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 10,
                                    color: Color.fromARGB(255, 134, 62, 40)),
                              ],
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              backgroundColor: bgColor,
                              radius: 70,
                              child: ClipOval(
                                child: Image.network(
                                  controller.networkImageUrl
                                      .value, // Use the network image URL here
                                  fit: BoxFit.cover,
                                  width: 140,
                                  height: 140,
                                ),
                              ),
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              border: Border.all(color: kWhite, width: 3),
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 10,
                                    color: Color.fromARGB(255, 134, 62, 40)),
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
                            Get.bottomSheet(
                              Container(
                                height: 250,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Column(
                                    children: [
                                      tileText('Upload Profile Picture', 20,
                                          FontWeight.w500, kBlack),
                                       Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ListTile(
                                                title: const Column(
                                                  children: [
                                                    Icon(Icons.photo_album,size: 45,),
                                                    Text(
                                                        'Select from Gallary'),
                                                  ],
                                                ),
                                      
                                                onTap: () => controller.getImage(ImageSource.gallery),
                            

                                              ),
                                            ListTile(
                                                title: const Column(
                                                  children: [
                                                    Icon(Icons.camera_alt,size: 47,),
                                                    Text(
                                                        'Select from Gallary'),
                                                  ],
                                                ),
                                      
                                                 onTap: () => controller.getImage(ImageSource.camera),
                                              ),
                                            ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              isScrollControlled: true,
                            );
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
                            fiilColor: kBlack.withOpacity(0.3),
                            label: 'Name',
                            controller: nameController,
                            icon: Icons.person),
                        CustomTextField(
                          enableColor: kWhite,
                          focusColor: kBlack,
                          fiilColor: kBlack.withOpacity(0.3),
                          label: 'Address',
                          controller: addressController,
                          icon: Icons.location_pin,
                        ),
                        CustomDatePicker(
                          label: 'Date Of Birth',
                        ),
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
                        ConfireButton(
                          label: 'UPDATE',
                          onChanged: () async {
                            if (nameController.text.isNotEmpty &&
                                addressController.text.isNotEmpty &&
                                dateController.selectedDate.value != null &&
                                dropDownController.selectedValue.value != '') {
                              // signInWithPhoneNumber(
                              //     "+${AuthControll.selectedCountry.value.phoneCode}${mobileController.text}",
                              //     controller.image.value.path,
                              //     nameController.text,
                              //     addressController.text,
                              //     dateController.selectedDate.value!,
                              //     dropDownController.selectedValue.value,
                              //     mobileController.text,
                              //     passwordController.text);
                              await updateBoyProfile();
                            } else {
                              Get.snackbar('Alert',
                                  'Please fill all fields and select an image',
                                  backgroundColor: kWhite);
                            }
                          },
                        )
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

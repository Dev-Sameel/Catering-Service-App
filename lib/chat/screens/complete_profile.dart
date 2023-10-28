import 'dart:developer';
import 'dart:io';

import 'package:catering/Refactoring/widgets/elevated_button.dart';
import 'package:catering/Refactoring/widgets/text_field.dart';
import 'package:catering/chat/helprer/ui_helper.dart';
import 'package:catering/chat/screens/chat_home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Refactoring/methods/others.dart';
import '../model/user_model.dart';

class CompleteProfile extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  const CompleteProfile({super.key,required this.firebaseUser,required this.userModel});

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  final nameController = TextEditingController();

  XFile? imageFile;

  void selectImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        imageFile = pickedFile;
      });
    }
  }

  void showPhotoOptions() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Upload Profile Picture'),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            ListTile(
              title: const Text('Select from Gallary'),
              leading: const Icon(Icons.photo_album),
              onTap: () => selectImage(ImageSource.gallery),
            ),
            ListTile(
              title: const Text('Take a photo'),
              leading: const Icon(Icons.camera_alt),
              onTap: () => selectImage(ImageSource.camera),
            )
          ]),
        );
      },
    );
  }

  void checkValues() {
    String fullName = nameController.text.trim();

    if (fullName == '' || imageFile == null) {
      getxSnakBar('Incomplete Data', 'Please fill all fields', null);
    } else {
      uploadData();
    }
  }

  void uploadData() async {
    UiHelper.showLoadingDialog('Uploading Image.....', context);
    if (imageFile != null) {
      File file = File(imageFile!.path);
      UploadTask uploadTask = FirebaseStorage.instance
          .ref('secondProfile')
          .child(widget.userModel.uid.toString())
          .putFile(file);
    TaskSnapshot snapshot=await uploadTask;

    String? imageUrl=await snapshot.ref.getDownloadURL();
    String? fullName=nameController.text.trim();

    widget.userModel.fullName=fullName;
    widget.userModel.profilePic = imageUrl;
    await FirebaseFirestore.instance.collection('users').doc(widget.userModel.uid).set(widget.userModel.toMap()).then((value) {
      log('Data Uploaded');
      Navigator.popUntil(context, (route) => route.isFirst);
        Get.offAll(()=>ChatHomePage(firebaseUser: widget.firebaseUser, userModel: widget.userModel));
      // Navigator.push(context, MaterialPageRoute(builder: (context) => ChatHomePage(firebaseUser: widget.firebaseUser, userModel: widget.userModel),));
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.all(30),
        child: ListView(
          children: [
            InkWell(
              onTap: () async {
                showPhotoOptions();
              },
              child: CircleAvatar(
                backgroundImage:
                    imageFile != null ? FileImage(File(imageFile!.path)) : null,
                radius: 80,
                child: imageFile == null
                    ? const Icon(
                        Icons.person,
                        size: 120,
                      )
                    : null,
              ),
            ),
            CustomTextField(
              label: 'Full Name',
              controller: nameController,
            ),
            const SizedBox(
              height: 20,
            ),
            ConfireButton(label: 'Submit', onChanged: () {
              checkValues();
            })
          ],
        ),
      ),
    );
  }
}

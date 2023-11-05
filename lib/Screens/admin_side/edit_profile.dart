import 'package:catering/Refactoring/widgets/others.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../Refactoring/firebase/variables.dart';
import '../../Refactoring/methods/app_bar_cuper.dart';
import '../../Refactoring/methods/others.dart';
import '../../Refactoring/styles/colors.dart';
import '../../Refactoring/widgets/elevated_button.dart';
import '../../Refactoring/widgets/text_field.dart';
import '../../controller/admin_controller.dart';
import '../../model/admin.dart';
import 'a_home.dart';

class EditProfile extends StatelessWidget {
  
  EditProfile({super.key});

  final AdminController controller = Get.put(AdminController());
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  Future<void> checkNameInFirestore(int oldPassword) async {
    try {
      CollectionReference admin =
          FirebaseFirestore.instance.collection('Admin Profile');

      QuerySnapshot querySnapshot =
          await admin.where('password', isEqualTo: oldPassword).get();
      dynamic documentId;

      if (querySnapshot.docs.isNotEmpty) {
        QuerySnapshot querySnapshot = await adminCollection.get();
        if (querySnapshot.size == 1) {
          var documentSnapshot = querySnapshot.docs[0];
          documentId = documentSnapshot.id;
        } else {
          getxSnakBar(
              'Error',
              'There are zero or more than one document in the collection.',
              null);
        }
        var updatedAdminDetails = Admin(
            name: nameController.text,
            password: int.parse(newPasswordController.text),
            phone: int.parse(phoneController.text));
        await adminCollection
            .doc(documentId)
            .update(updatedAdminDetails.toJson());
        Get.offAll(() => const AHomePage());
        Get.snackbar('success', 'Successfully Updated',
            backgroundColor: kWhite);
      } else {
        Get.snackbar('Error', 'Old password is incorrect',
            backgroundColor: kWhite);
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: kWhite);
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: bgColor,
      appBar: customAppBar(null, null, null, 'EDIT PROFILE'),
      body: StreamBuilder(
          stream: adminCollection.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final adminDetails = controller.admin[0];
            nameController.text = adminDetails.name;
            phoneController.text = adminDetails.phone.toString();
            return Center(
              child: Container(
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
                height: 400,
                child: ScrollConfiguration(
                  behavior: RemoveGlow(),
                  child: ListView(
                    itemExtent: 70.0,
                    shrinkWrap: true,
                    children: [
                      CustomTextField(
                          fiilColor: kBlack.withOpacity(0.3),
                          controller: nameController,
                          icon: Icons.movie_edit,
                          label: 'Enter Name',
                          showLabel: false,
                          showHintText: true),
                      CustomTextField(
                          fiilColor: kBlack.withOpacity(0.3),
                          length: 10,
                          controller: phoneController,
                          icon: Icons.phone,
                          label: 'Phone Number',
                          textType: TextInputType.number,
                          showLabel: false,
                          showHintText: true),
                      CustomTextField(
                          fiilColor: kBlack.withOpacity(0.3),
                          length: 5,
                          controller: oldPasswordController,
                          icon: Icons.lock_open,
                          label: 'Enter Old Password',
                          textType: TextInputType.number),
                      CustomTextField(
                          fiilColor: kBlack.withOpacity(0.3),
                          length: 5,
                          controller: newPasswordController,
                          icon: Icons.lock,
                          label: 'Enter New Password',
                          textType: TextInputType.number),
                      ConfireButton(
                          label: 'Update',
                          onChanged: () {
                            if (nameController.text.isNotEmpty &&
                                phoneController.text.isNotEmpty &&
                                oldPasswordController.text.isNotEmpty &&
                                newPasswordController.text.isNotEmpty) {
                              if (newPasswordController.length == 5) {
                                checkNameInFirestore(
                                    int.parse(oldPasswordController.text));
                              } else {
                                getxSnakBar(
                                    'Alert', 'Must Enter 5 Digit Password', null);
                              }
                            } else {
                              getxSnakBar(
                                  'Alert', 'Please fill all fields', null);
                            }
                          })
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

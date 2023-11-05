
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../Refactoring/firebase/variables.dart';
import '../../Refactoring/methods/image_text.dart';
import 'login_page/login_page.dart';
import '../../controller/image_controller.dart';
import '../../model/user.dart';

// ignore: must_be_immutable
class OtpPage extends StatefulWidget {
  String phoneNumber;

  String image;
  String name;
  String address;
  DateTime date;
  String dropdown;
  String mobile;
  String password;

  OtpPage(
      {required this.date,
      required this.address,
      required this.dropdown,
      required this.image,
      required this.mobile,
      required this.name,
      required this.password,
      required this.phoneNumber,
      super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();
  final TextEditingController _thirdController = TextEditingController();
  final TextEditingController _fourthController = TextEditingController();
  final TextEditingController _fifthController = TextEditingController();
  final TextEditingController _sixthController = TextEditingController();
  String? otpCode;
  final String verificationId = Get.arguments[0];
  FirebaseAuth auth = FirebaseAuth.instance;
  final ImagePickerController controller = Get.put(ImagePickerController());

  Future addBoyData() async {
    String downloadURL = await controller.uploadImageToFirebase();
    var addUserData = UserData(
      id: '',
      photo: downloadURL,
      name: widget.name,
      address: widget.address,
      dob: parseDateDrop(widget.date),
      bloodGroup: widget.dropdown,
      mobile: int.parse(widget.mobile),
      password: int.parse(widget.password),
    );

    // var userData = UserData(
    //   photo: addUserData.photo,
    //   name: addUserData.name,
    //   address: addUserData.address,
    //   dob: addUserData.dob,
    //   bloodGroup: addUserData.bloodGroup,
    //   mobile: addUserData.mobile,
    //   password: addUserData.password,
    //   id: ,
    // );
    // String id = await userRegCollection
    //     .add(userData.toJson())
    //     .then((DocumentReference doc) {
    //   return doc.id;
    // });

    // return id;
    // await userRegCollection.add(userData.toJson());
    // Get.offAll(()=>LoginPage());
    DocumentReference docRef =
        await userRegCollection.add(addUserData.toJson());

    // Update the id field in addUserData with the generated document ID
    await docRef.update({'id': docRef.id});

    // Now addUserData contains the generated ID
    addUserData.id = docRef.id;

    Get.offAll(LoginPage());
  }

  @override
  void dispose() {
    _firstController.dispose();
    _secondController.dispose();
    _thirdController.dispose();
    _fourthController.dispose();
    _fifthController.dispose();
    _sixthController.dispose();
    super.dispose();
  }

  // verify otp
  void verifyOtp(
    String verificationId,
    String userOtp,
  ) async {
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      // User? user = (await auth.signInWithCredential(creds)).user;
      UserCredential userCredential = await auth.signInWithCredential(creds);
      User? user = userCredential.user;
      if (user != null) {
        await addBoyData();
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        e.message.toString(),
        "Failed",
        colorText: Colors.white,
      );
    }
  }

  void _login() {
    if (otpCode != null) {
      verifyOtp(verificationId, otpCode!);
    } else {
      Get.snackbar(
        "Enter 6-Digit code",
        "Failed",
        colorText: Colors.white,
      );
    }
  }

  final ButtonStyle style = ElevatedButton.styleFrom(
      minimumSize: const Size(188, 48),
      backgroundColor: const Color(0xFFFD7877),
      elevation: 6,
      textStyle: const TextStyle(fontSize: 16),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(50),
      )));

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 24, color: Colors.white),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F2B2F),
      // backgroundColor: Color(0xff215D5F),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 200),
              buildText('Enter 6 digit OTP'),
              buildText('sent to your number'),
              const SizedBox(height: 50),
              Pinput(
                length: 6,
                showCursor: true,
                defaultPinTheme: PinTheme(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: const Color(0xff2C474A),
                    ),
                  ),
                  textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
                onCompleted: (value) {
                  setState(() {
                    otpCode = value;
                  });
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                  style: style,
                  onPressed: _login,
                  child: const Text(
                    'SIGN IN',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  )),
              const SizedBox(height: 80),
              const Text(
                "Didn't receive any code?",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              const Text(
                "Resend new code",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

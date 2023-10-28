// // import 'package:catering/workout/otp.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:country_picker/country_picker.dart';
// // import 'package:get/get.dart';

// // class AuthLogin extends StatefulWidget {
// //   @override
// //   _AuthLoginState createState() => _AuthLoginState();
// // }

// // class _AuthLoginState extends State<AuthLogin> {
// //   final TextEditingController phoneController = TextEditingController();

// //   Future<void> signInWithPhoneNumber(String phoneNumber,String uID) async {
// //     FirebaseAuth auth = FirebaseAuth.instance;

// //     await auth.verifyPhoneNumber(
// //       phoneNumber: phoneNumber,
// //       verificationCompleted: (PhoneAuthCredential credential) async {
// //         await auth.signInWithCredential(credential);
// //         // authentication successful, do something
// //       },
// //       verificationFailed: (FirebaseAuthException e) {
// //         // authentication failed, do something
// //       },
// //       codeSent: (String verificationId, int? resendToken) async {
// //         // code sent to phone number, save verificationId for later use
// //         String smsCode = ''; // get sms code from user
// //         PhoneAuthCredential credential = PhoneAuthProvider.credential(
// //           verificationId: verificationId,
// //           smsCode: smsCode,
// //         );
// //         Get.to(OtpPage(uID: uID), arguments: [verificationId]);
// //         await auth.signInWithCredential(credential);
// //         // authentication successful, do something
// //       },
// //       codeAutoRetrievalTimeout: (String verificationId) {},
// //     );
// //   }

// //   Country selectedCountry = Country(
// //     phoneCode: "91",
// //     countryCode: "IN",
// //     e164Sc: 0,
// //     geographic: true,
// //     level: 1,
// //     name: "India",
// //     example: "India",
// //     displayName: "India",
// //     displayNameNoCountryCode: "IN",
// //     e164Key: "",
// //   );

// //   void _userLogin() async {
// //     String mobile = phoneController.text;
// //     if (mobile == "") {
// //       Get.snackbar(
// //         "Please enter the mobile number!",
// //         "Failed",
// //         colorText: Colors.white,
// //       );
// //     } else {
// //       signInWithPhoneNumber("+${selectedCountry.phoneCode}$mobile");
// //     }
// //   }

// //   @override
// //   void dispose() {
// //     phoneController.dispose();
// //     super.dispose();
// //   }

// //   _buildSocialLogo(file) {
// //     return Column(
// //       mainAxisAlignment: MainAxisAlignment.center,
// //       children: <Widget>[
// //         Image.asset(
// //           file,
// //           height: 38.5,
// //         ),
// //       ],
// //     );
// //   }

// //   final ButtonStyle style = ElevatedButton.styleFrom(
// //       minimumSize: Size(188, 48),
// //       backgroundColor: Color(0xFF051B8B),
// //       elevation: 6,
// //       textStyle: const TextStyle(fontSize: 16),
// //       shape: const RoundedRectangleBorder(
// //           borderRadius: BorderRadius.all(
// //         Radius.circular(50),
// //       )));

// //   Widget buildText(String text) => Center(
// //         child: Text(
// //           text,
// //           style: TextStyle(fontSize: 24, color: Colors.white),
// //         ),
// //       );

// //   @override
// //   Widget build(BuildContext context) {
// //     phoneController.selection = TextSelection.fromPosition(
// //       TextPosition(
// //         offset: phoneController.text.length,
// //       ),
// //     );
// //     return Scaffold(
// //       backgroundColor: Color(0xff0F2B2F),
// //       // backgroundColor: Color(0xff215D5F),
// //       body: SingleChildScrollView(
// //         child: Container(
// //           padding: EdgeInsets.symmetric(horizontal: 20),
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: <Widget>[
// //               SizedBox(height: 200),
// //               buildText('Log In'),
// //               SizedBox(height: 50),
// //               Container(
// //                 margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
// //                 child: TextFormField(
// //                   keyboardType: TextInputType.number,
// //                   cursorColor: Colors.white,
// //                   controller: phoneController,
// //                   style: const TextStyle(
// //                     fontSize: 14,
// //                     fontWeight: FontWeight.bold,
// //                     color: Colors.grey,
// //                   ),
// //                   onChanged: (value) {
// //                     setState(() {
// //                       phoneController.text = value;
// //                     });
// //                   },
// //                   decoration: InputDecoration(
                  
// //                     hintText: "Mobile number",
// //                     hintStyle: TextStyle(
// //                       fontWeight: FontWeight.w500,
// //                       fontSize: 14,
// //                       color: Colors.grey.shade600,
// //                     ),
// //                     floatingLabelBehavior: FloatingLabelBehavior.never,
// //                     contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
// //                     focusedBorder: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(100.0),
// //                         borderSide: BorderSide(color: Colors.black)),
// //                     enabledBorder: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(100.0),
// //                         borderSide: BorderSide(color: Colors.black38)),
// //                     errorBorder: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(100.0),
// //                         borderSide:
// //                             BorderSide(color: Colors.white, width: 2.0)),
// //                     focusedErrorBorder: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(100.0),
// //                         borderSide:
// //                             BorderSide(color: Colors.black38, width: 2.0)),
// //                     prefixIcon: Container(
// //                       padding: const EdgeInsets.all(8.0),
// //                       child: InkWell(
// //                         onTap: () {
// //                           showCountryPicker(
// //                               context: context,
// //                               countryListTheme: const CountryListThemeData(
// //                                 bottomSheetHeight: 550,
// //                               ),
// //                               onSelect: (value) {
// //                                 // Restrict selection to India
// //                                 if (value.countryCode == 'IN') {
// //                                   setState(() {
// //                                     selectedCountry = value;
// //                                   });
// //                                 } else {
// //                                   Get.snackbar('Alert','Only India is allowed');
// //                                 }
// //                               });
// //                         },
// //                         child: Container(
// //                           padding: const EdgeInsets.all(8.0),
// //                           child: Text(
// //                             "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
// //                             style: const TextStyle(
// //                               fontSize: 14,
// //                               color: Colors.grey,
// //                               fontWeight: FontWeight.bold,
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                     suffixIcon: phoneController.text.length > 9
// //                         ? Container(
// //                             height: 30,
// //                             width: 30,
// //                             margin: const EdgeInsets.all(10.0),
// //                             decoration: const BoxDecoration(
// //                               shape: BoxShape.circle,
// //                               color: Colors.green,
// //                             ),
// //                             child: const Icon(
// //                               Icons.done,
// //                               color: Colors.white,
// //                               size: 20,
// //                             ),
// //                           )
// //                         : null,
// //                   ),
// //                 ),
// //               ),
// //               SizedBox(height: 30),
// //               ElevatedButton(
// //                   style: style,
// //                   onPressed: _userLogin,
// //                   child: const Text(
// //                     'GET OTP',
// //                     style: TextStyle(fontSize: 14, color: Colors.white),
// //                   )),
// //               SizedBox(height: 80),
// //               const Text(
// //                 "Or continue with  ",
// //                 style: TextStyle(fontSize: 12, color: Colors.grey),
// //               ),
// //               SizedBox(height: 20),
// //               // Row(
// //               //   mainAxisAlignment: MainAxisAlignment.center,
// //               //   crossAxisAlignment: CrossAxisAlignment.center,
// //               //   children: [
// //               //     GestureDetector(
// //               //       onTap: () {
// //               //         signFacebook();
// //               //       },
// //               //       child: _buildSocialLogo('assets/facebook.png'),
// //               //     ),
// //               //     SizedBox(width: 40),
// //               //     GestureDetector(
// //               //       onTap: () {
// //               //         signApple();
// //               //       },
// //               //       child: _buildSocialLogo('assets/apple.png'),
// //               //     ),
// //               //     SizedBox(width: 40),
// //               //     GestureDetector(
// //               //       onTap: () {
// //               //         signGoogle();
// //               //       },
// //               //       child: _buildSocialLogo('assets/google.png'),
// //               //     ),
// //               //   ],
// //               // ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:catering/Screens/boys_side/login_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_onboarding_screen/OnbordingData.dart';
// import 'package:flutter_onboarding_screen/flutteronboardingscreens.dart';

// class TestScreen extends StatelessWidget {
//     /*here we have a list of OnbordingScreen which we want to have, each OnbordingScreen have a imagePath,title and an desc.
//       */
//   final List<OnbordingData> list = [
//     OnbordingData(
//       imagePath: "images/pic11.png",
//       title: "Search",
//       desc:"Discover restaurants by type of meal, See menus and photos for nearby restaurants and bookmark your favorite places on the go",
//     ),
//     OnbordingData(
//       imagePath: "images/pic12.png",
//       title: "Order",
//       desc:"Best restaurants delivering to your doorstep, Browse menus and build your order in seconds",
//     ),
//     OnbordingData(
//       imagePath: "images/pic13.png",
//       title: "Eat",
//       desc:"Explore curated lists of top restaurants, cafes, pubs, and bars in Mumbai, based on trends.",
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     /* remove the back button in the AppBar is to set automaticallyImplyLeading to false
//   here we need to pass the list and the route for the next page to be opened after this. */
//     return new IntroScreen(list,MaterialPageRoute(builder: (context) => list[2]),
//     );
//   }
// }
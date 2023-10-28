import 'package:catering/Screens/admin_side/a_home.dart';
import 'package:catering/chat/screens/chat_home_page.dart';
import 'package:catering/chat/screens/login2_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import 'Screens/main_screens/splash_screen.dart';
import 'chat/helprer/firebase_helper.dart';
import 'chat/model/user_model.dart';



var uuid=const Uuid();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // User? currentUser = FirebaseAuth.instance.currentUser;
  // if (currentUser != null) {
  //   //Logged In
  //   UserModel? thisUserModel =
  //       await FirebaseHelper.getUserModelById(currentUser.uid);
  //   if (thisUserModel != null) {
  //     runApp(
  //         MyAppLoggedIn(firebaseUser: currentUser, userModel: thisUserModel));
  //   }
  //   else {
  //   runApp( MyApp());
  // }
  // } 
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return   GetMaterialApp(
      title: 'Flutter Demo',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// class MyAppLoggedIn extends StatelessWidget {
//   final UserModel userModel;
//   final User firebaseUser;
//   const MyAppLoggedIn({super.key,required this.userModel,required this.firebaseUser});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(debugShowCheckedModeBanner: false,
//     home: ChatHomePage(firebaseUser: firebaseUser, userModel: userModel),);
//   }
// }

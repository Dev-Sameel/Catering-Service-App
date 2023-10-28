import 'package:catering/chat/model/user_model.dart';
import 'package:catering/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper{
 static Future<UserModel?> getUserModelById(String uId) async{
    UserModel? userModel;
     var docSnap=await FirebaseFirestore.instance.collection('users').doc(uId).get();

     if(docSnap.data()!=null)
     {
      userModel = UserModel.fromMap(docSnap.data() as Map<String,dynamic>);
     }

     return userModel;
  }
}
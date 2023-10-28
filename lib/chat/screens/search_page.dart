// import 'dart:developer';

// import 'package:catering/Refactoring/firebase/variables.dart';
// import 'package:catering/Refactoring/methods/app_bar_cuper.dart';
// import 'package:catering/Refactoring/methods/sizedbox.dart';
// import 'package:catering/Refactoring/styles/colors.dart';
// import 'package:catering/chat/model/user_model.dart';
// import 'package:catering/chat/screens/chat_room_page.dart';
// import 'package:catering/main.dart';
// import 'package:catering/model/user.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../model/chat_room_model.dart';

// class SearchPage extends StatefulWidget {
//   final UserModel userData;
//   final User firebaseUser;

//   const SearchPage(
//       {super.key, required this.userData, required this.firebaseUser});

//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   final searchController = TextEditingController();

//   Future<ChatRoomModel?> getChatRoomModel(UserModel targetUser) async {
//     ChatRoomModel? chatRoom;
//    QuerySnapshot snapshot= await FirebaseFirestore.instance.collection('chatRooms')
//         .where('participants.${widget.userData.uid}', isEqualTo: true)
//         .where('participants.${targetUser.uid}', isEqualTo: true).get();
        

//         if(snapshot.docs.length>0)
//         {
//           log('ChatRoom Already Created');
//           var docData= snapshot.docs[0].data();
//           ChatRoomModel existingChatRoom = ChatRoomModel.fromMap(docData as Map<String,dynamic>);
//           chatRoom=existingChatRoom;
//         }
//         else
//         {
//           ChatRoomModel newChatRoom = ChatRoomModel(
//              chatRoomId: uuid.v1(),
//              lastMessage: '',
//              participants: {
//               widget.userData.uid.toString():true,
//               targetUser.uid.toString():true
//              },
//              users: [ widget.userData.uid.toString(),targetUser.uid.toString()],
//              createDon: DateTime.now()
             
//           );

//           await FirebaseFirestore.instance.collection('chatRooms').doc(newChatRoom.chatRoomId).set(newChatRoom.toMap());
//           chatRoom= newChatRoom;
//           log('New ChatRoom Created');
//         }
//         return chatRoom;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: customAppBar('Search Session', null),
//       body: SafeArea(
//           child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Container(
//           child: ListView(
//             children: [
//               TextField(
//                 controller: searchController,
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(), labelText: 'email add'),
//               ),
//               sBoxH20(),
//               CupertinoButton(
//                 child: Text('Search'),
//                 onPressed: () {
//                   setState(() {});
//                 },
//                 color: kBlack,
//               ),
//               sBoxH20(),
//               StreamBuilder(
//                 stream: FirebaseFirestore.instance.collection('users').where('email', isEqualTo: searchController.text)
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.active) {
//                     if (snapshot.hasData) {
//                       QuerySnapshot dataSnapShot =
//                           snapshot.data as QuerySnapshot;
//                       if (dataSnapShot.docs.length > 0) {
//                         Map<String, dynamic> userMap =
//                             dataSnapShot.docs[0].data() as Map<String, dynamic>;
//                         UserModel searchUser = UserModel.fromMap(userMap);
                        
//                         return ListTile(
//                           leading: CircleAvatar(
//                             radius: 30,
//                             backgroundImage: NetworkImage(searchUser.profilePic.toString()),
//                             backgroundColor: Colors.grey,
//                           ),
//                           title: Text(searchUser.fullName??'fdf'),
//                           subtitle: Text(searchUser.email??'fdf'),
//                           trailing: Icon(Icons.keyboard_arrow_right),
//                           onTap: () async{
//                           ChatRoomModel? chatRoomModel= await getChatRoomModel(searchUser);

//                             if(chatRoomModel!=null)
//                             {
//                               Get.to(() => ChatRoomPage(
//                                 targetUser: searchUser,
//                                 chatRoom: chatRoomModel,
//                                 firebaseUser: widget.firebaseUser,
//                                 userData: widget.userData));
//                             }
//                           },
//                         );
//                       } else {
//                         return Text('No Results Fond');
//                       }
//                     } else if (snapshot.hasError) {
//                       return Text('An Error Occured');
//                     } else {
//                       return Text('No Results Fond');
//                     }
//                   } else {
//                     return CircularProgressIndicator();
//                   }
//                 },
//               )
//             ],
//           ),
//         ),
//       )),
//     );
//   }
// }

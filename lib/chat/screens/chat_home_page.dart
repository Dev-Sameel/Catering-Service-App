import 'package:catering/Refactoring/methods/app_bar_cuper.dart';
import 'package:catering/Refactoring/styles/colors.dart';
import 'package:catering/chat/helprer/firebase_helper.dart';
import 'package:catering/chat/helprer/ui_helper.dart';
import 'package:catering/chat/model/chat_room_model.dart';
import 'package:catering/chat/model/user_model.dart';
import 'package:catering/chat/screens/chat_room_page.dart';
import 'package:catering/chat/screens/login2_page.dart';
import 'package:catering/chat/screens/search_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatHomePage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  const ChatHomePage(
      {super.key, required this.firebaseUser, required this.userModel});

  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: bgColor,actions: [IconButton(onPressed: (){
        Navigator.popUntil(context, (route) => route.isFirst);
        Get.offAll(()=>LoginPage2());
      }, icon: Icon(Icons.exit_to_app))],),
      body: SafeArea(
          child: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chatRooms')
              .where('users',arrayContains: widget.userModel.uid).orderBy('createDon')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                QuerySnapshot chatRoomSnapshot = snapshot.data as QuerySnapshot;
                return ListView.builder(
                  itemCount: chatRoomSnapshot.docs.length,
                  itemBuilder: (context, index) {
                    ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(
                        chatRoomSnapshot.docs[index].data()
                            as Map<String, dynamic>);

                    Map<String, dynamic> participants =
                        chatRoomModel.participants!;

                    List<String> participantsKey = participants.keys.toList();
                    participantsKey.remove(widget.userModel.uid);
                    return FutureBuilder(
                        future:
                            FirebaseHelper.getUserModelById(participantsKey[0]),
                        builder: (context, userData) {
                          if (userData.connectionState ==
                              ConnectionState.done) {
                            if (userData.data != null) {
                              UserModel targetUser = userData.data as UserModel;
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      targetUser.profilePic.toString()),
                                ),
                                title: Text(targetUser.fullName.toString()),
                                subtitle:chatRoomModel.lastMessage.toString()!=''?
                                    Text(chatRoomModel.lastMessage.toString()):Text('Say hi to your new friend',style: TextStyle(color: Colors.green),),
                                onTap: () {
                                  // Get.to(() => ChatRoomPage(
                                  //     targetUser: targetUser,
                                  //     chatRoom: chatRoomModel,
                                  //     firebaseUser: widget.firebaseUser,
                                  //     userData: widget.userModel));
                                },
                              );
                            } else {
                              return Container();
                            }
                          } else {
                            return Container();
                          }
                        });
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return Center(
                  child: Text('No Chats'),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         //// // UiHelper.showLoadingDialog('Loading....', context);

          // Get.to(() => SearchPage(
          //     userData: widget.userModel, firebaseUser: widget.firebaseUser));
        },
        child: Icon(Icons.search),
      ),
    );
  }
}

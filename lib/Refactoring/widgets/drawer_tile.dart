import 'dart:developer';

import 'package:catering/Refactoring/methods/others.dart';
import 'package:catering/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Screens/boys_side/drawer/confirmed/confirmed.dart';
import '../../Screens/boys_side/drawer/boy_profile.dart';
import '../../Screens/chat/model/chat_room_model.dart';
import '../../Screens/chat/screens/chat_room_page.dart';
import '../../model/user.dart';
import '../methods/edit_password.dart';
import '../methods/logout_box.dart';
import '../styles/colors.dart';

// ignore: must_be_immutable
class DrawerTile extends StatelessWidget {
  var userData;
  final String adminId = 'wzaxXP0cddR3k9KXVmsV';
  String? uId;
  Map<String, dynamic>? data;
  final String imagePaths;
  final String title;
  final int id;
  DrawerTile({
    this.uId,
    this.data,
    required this.imagePaths,
    required this.id,
    required this.title,
    super.key,
  });

  Future<ChatRoomModel?> getChatRoomModel(String userId) async {
    ChatRoomModel? chatRoom;
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('chatRooms')
        .where('participants.${adminId}', isEqualTo: true)
        .where('participants.${userId}', isEqualTo: true)
        .get();

    if (snapshot.docs.length > 0) {
      log('ChatRoom Already Created');
      var docData = snapshot.docs[0].data();
      ChatRoomModel existingChatRoom =
          ChatRoomModel.fromMap(docData as Map<String, dynamic>);
      chatRoom = existingChatRoom;
    } else {
      ChatRoomModel newChatRoom = ChatRoomModel(
          chatRoomId: uuid.v1(),
          lastMessage: '',
          participants: {adminId.toString(): true, userId.toString(): true},
          users: [adminId.toString(), userId.toString()],
          createDon: DateTime.now());

      await FirebaseFirestore.instance
          .collection('chatRooms')
          .doc(newChatRoom.chatRoomId)
          .set(newChatRoom.toMap());
      chatRoom = newChatRoom;
      log('New ChatRoom Created');
    }
    return chatRoom;
  }

 

  @override
  Widget build(BuildContext context) {
    
    try {
      if (data != null) {
        UserData userData = UserData.fromJson(data!, uId);
        log(userData.password.toString());
        log(userData.bloodGroup.toString());
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error parsing document: $e');
      }
    }
    return Column(
      children: [
        ListTile(
          leading: Image(
            image: AssetImage(imagePaths),
            width: 35,
          ),
          title: Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          onTap: () async {
            if (id == 1) {
              Get.to(() => MyProfile(
                     uId:data?['id']??'',
                    name: data?['name'] ?? '',
                    address: data?['address'] ?? '',
                    dob: data?['dob'] ?? '',
                    bloodGroup: data?['bloodGroup'] ?? '',
                    photo: data?['photo'] ?? '',
                    mobile: data?['mobile'] ?? '',
                  ));
            } else if (id == 2) {
              Get.to(() => ConfirmedWork(
                    uId: uId!,
                  ));
            } else if (id == 3) {
              editPassword(context, uId!);
            } else if (id == 4) {
              String url3 = 'mailto:pookkodansameel@gmail.com';
              if (url3.isNotEmpty) {
                // ignore: deprecated_member_use
                launch(url3);
              }
            } else if (id == 5) {
              UserData? userData = UserData.fromJson(data!, null);
              String userId = uId!;
              ChatRoomModel? chatRoomModel = await getChatRoomModel(userId);
              if (chatRoomModel != null) {
                Get.to(() => ChatRoomPage(
                    side: 'user',
                    targetUser: userData,
                    chatRoom: chatRoomModel,
                    // firebaseUser: widget.firebaseUser,
                    adminId: adminId));
              }
              // Get.to(() => const AChat());
            } else if (id == 6) {
              logoutDialog();
            }
          },
        ),
        if (title != 'Logout')
          const Divider(
            height: 20,
            color: bgColor,
          )
      ],
    );
  }
}

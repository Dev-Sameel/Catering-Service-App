import 'dart:developer';

import 'package:catering/Refactoring/methods/app_bar_cuper.dart';
import 'package:catering/Refactoring/methods/sizedbox.dart';
import 'package:catering/Refactoring/styles/colors.dart';
import 'package:catering/chat/model/chat_room_model.dart';
import 'package:catering/chat/model/message_model.dart';
import 'package:catering/main.dart';
import 'package:catering/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Refactoring/methods/others.dart';
import '../../controller/chat_controller.dart';

class ChatRoomPage extends StatelessWidget {
  final String side;
  final UserData targetUser;
  final String adminId;
  // final User firebaseUser;
  final ChatRoomModel chatRoom;
   ChatRoomPage(
      {super.key,
      required this.side,
      required this.targetUser,
      required this.chatRoom,
      // required this.firebaseUser,
      required this.adminId});

  void sendMessage() async {
    String msg = messageControll.text.trim();
    messageControll.clear();
    if (msg != '') {
      MessageModel newMessage = MessageModel(
          sender:
              side == 'admin' ? adminId : targetUser.id,
          createDon: DateTime.now(),
          messageId: uuid.v1(),
          seen: false,
          text: msg);
      await FirebaseFirestore.instance
          .collection('chatRooms')
          .doc(chatRoom.chatRoomId)
          .collection('message')
          .doc(newMessage.messageId)
          .set(newMessage.toMap());
      chatRoom.lastMessage = msg;
      FirebaseFirestore.instance
          .collection('chatRooms')
          .doc(chatRoom.chatRoomId)
          .set(chatRoom.toMap());
      log('Message Sent!');
    }
  }

  final messageControll = TextEditingController();
  @override
  Widget build(BuildContext context) {
        final ChatController chatController = Get.put(ChatController());
    return Scaffold(
        backgroundColor: bgColor,
        appBar:  AppBar(
          leading: IconButton(
        onPressed: () {
                Get.back();
              },
        icon: const Icon(
          CupertinoIcons.back,
          color: kWhite,
          size: 35,
        )),
          backgroundColor: Color.fromARGB(255, 44, 43, 42),
          title: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: kWhite,
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(
                    targetUser.photo.toString(),
                  ),
                ),
              ),
              sBoxW10(),
              Text(capitalize(targetUser.name.toString()))
            ],
          ),
        ),
        body: Stack(children: [
          Column(
            children: [
              Expanded(
                  child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('chatRooms')
                    .doc(chatRoom.chatRoomId)
                    .collection('message')
                    .orderBy('createDon', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      QuerySnapshot dataSnapShot =
                          snapshot.data as QuerySnapshot;
                      return ListView.builder(
                        reverse: true,
                        itemCount: dataSnapShot.docs.length,
                        itemBuilder: (context, index) {
                          MessageModel currentMessage = MessageModel.fromMap(
                              dataSnapShot.docs[index].data()
                                  as Map<String, dynamic>);

                          bool isSender = side == 'admin'
                              ? currentMessage.sender == adminId
                              : currentMessage.sender == targetUser.id;

                          return Align(
                            alignment: isSender
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width - 45),
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient:
                                        isSender ? youGradient : senderGradient,
                                    borderRadius: isSender
                                        ? const BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10))
                                        : const BorderRadius.only(
                                            bottomRight: Radius.circular(10),
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10))),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 80,
                                          top: 5,
                                          bottom: 20),
                                      child: Text(
                                        currentMessage.text.toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 4,
                                        right: 10,
                                        child: Row(
                                          children: [
                                            Text(
                                              pickSendTime(
                                                  currentMessage.createDon!),
                                              style: const TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.white),
                                            ),
                                            
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                            'An Error Occured! Please check your internet connection'),
                      );
                    } else {
                      return const Center(
                        child: Text('Say hi to your new friend'),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: kWhite,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: [
                    Flexible(
                        child: TextField(
                          onChanged: chatController.onTextChanged,
                      maxLines: null,
                      controller: messageControll,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: 'Enter Message'),
                    )),
                  ],
                ),
              ),
            ],
          ),
          Obx(
            () {
              return chatController.showSendButton.value
                            ? Positioned(
                bottom: -3,
                right: 25,
                child: Container(
                  width: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape
                          .circle, // You can use a different shape if desired
                      gradient: youGradient,
                      boxShadow: [BoxShadow(color: kBlack, blurRadius: 5)]),
                  padding: const EdgeInsets.all(8), // Adjust the padding as needed
                  child: IconButton(
                    icon: Icon(Icons.send), // Replace with your desired icon
                    onPressed: () {
                      sendMessage();
                    },
                  ),
                ),
              ): const SizedBox.shrink();
            }
          ),
        ]));
  }
}

String pickSendTime(DateTime date) {
  return DateFormat('h:mm a').format(date);
}

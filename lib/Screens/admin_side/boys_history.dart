import 'dart:developer';

import 'package:catering/Refactoring/methods/app_bar_cuper.dart';
import 'package:catering/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Refactoring/firebase/variables.dart';
import '../../Refactoring/methods/delete_dialogbox.dart';
import '../../Refactoring/methods/others.dart';
import '../../Refactoring/methods/tile_text.dart';
import '../../Refactoring/styles/colors.dart';
import '../../Refactoring/styles/container.dart';
import '../../Refactoring/widgets/others.dart';
import '../../chat/model/chat_room_model.dart';
import '../../chat/screens/chat_room_page.dart';
import '../../controller/boys_history_controller.dart';
import '../../controller/image_controller.dart';
import '../../main.dart';
import '../boys_side/drawer/my_profile.dart';

class BoysHistory extends StatefulWidget {
  const BoysHistory({super.key});

  @override
  State<BoysHistory> createState() => _BoysHistoryState();
}

class _BoysHistoryState extends State<BoysHistory> {
  List<UserData> _filteredUsers = [];

  final String adminId = 'wzaxXP0cddR3k9KXVmsV';

  final BoysHistoryController controller = Get.put(BoysHistoryController());

  final _searchController = TextEditingController();

  final ImagePickerController imageController =
      Get.put(ImagePickerController());

  Future<ChatRoomModel?> getChatRoomModel(UserData userData) async {
    ChatRoomModel? chatRoom;
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('chatRooms')
        .where('participants.$adminId', isEqualTo: true)
        .where('participants.${userData.id}', isEqualTo: true)
        .get();

    if (snapshot.docs.isNotEmpty) {
      log('ChatRoom Already Created');
      var docData = snapshot.docs[0].data();
      ChatRoomModel existingChatRoom =
          ChatRoomModel.fromMap(docData as Map<String, dynamic>);
      chatRoom = existingChatRoom;
    } else {
      ChatRoomModel newChatRoom = ChatRoomModel(
          chatRoomId: uuid.v1(),
          lastMessage: '',
          participants: {
            adminId.toString(): true,
            userData.id.toString(): true
          },
          users: [adminId.toString(), userData.id.toString()],
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
  void initState() {
    _filteredUsers = controller.users;
    super.initState();
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      // If the query is empty, show all users
      setState(() {
        _filteredUsers = controller.users; // Restore full user list
      });
    } else {
      // Filter users based on the search query
      final lowerCaseQuery = query.toLowerCase();
      setState(() {
        _filteredUsers = controller.users.where((user) {
          return user.name.toLowerCase().contains(lowerCaseQuery);
        }).toList();
      });
    }
  }

  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      // appBar: AppBar(
      //   title: isSearching
      //       ? CupertinoTextField(
      //           onChanged: (query) {
      //             setState(() {
      //               _performSearch(query);
      //             });
      //           },
      //           controller: _searchController,
      //           placeholder: 'Search for a user',
      //         )
      //       : const Text('boys history'),
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         setState(() {
      //           isSearching = !isSearching;
      //           if (!isSearching) {
      //             _searchController.clear();
      //             _performSearch('');
      //           }
      //         });
      //       },
      //       icon: isSearching ? const Icon(Icons.close) : const Icon(Icons.search),
      //     )
      //   ],
      // ),
      appBar: customAppBar(    isSearching
       ? CupertinoTextField(
           onChanged: (query) {
             setState(() {
               _performSearch(query);
             });
           },
           controller: _searchController,
           placeholder: 'Searching here',
         )
       : const Text('BOYS HISTORY'), null,    IconButton(
     onPressed: () {
       setState(() {
         isSearching = !isSearching;
         if (!isSearching) {
           _searchController.clear();
           _performSearch('');
         }
       });
     },
     icon: isSearching ? const Icon(Icons.close) : const Icon(Icons.search),
   ), null),
      body: ScrollConfiguration(
        behavior: RemoveGlow(),
        child: StreamBuilder(
          stream: userRegCollection.snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
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

            controller.mapRecords(snapshot.data!);

            return Column(
              children: [
                Stack(
                  children: [
                    const Image(
                      image: AssetImage('assets/images/woodBoard.png'),
                      height: 110,
                    ),
                    Positioned(
                      left: 40,
                      top: 63,
                      child: Text(
                        'Total boys count: ${controller.users.length}',
                        style: const TextStyle(
                          shadows: [
                            Shadow(
                              offset: Offset(1, 2),
                              color: Color.fromARGB(255, 34, 18, 0),
                              blurRadius: 10,
                            ),
                          ],
                          fontSize: 19,
                          color: Color.fromARGB(255, 240, 215, 187),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: GridView.builder(
                        itemCount: _filteredUsers.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                        itemBuilder: (context, index) {
                          final userDetails = _filteredUsers[index];
                          return SizedBox(
                            height: 200,
                            width: 200,
                            child: GestureDetector(
                              onTap: () async {
                                ChatRoomModel? chatRoomModel =
                                    await getChatRoomModel(userDetails);
                                if (chatRoomModel != null) {
                                  Get.to(() => ChatRoomPage(
                                        side: 'admin',
                                        targetUser: userDetails,
                                        chatRoom: chatRoomModel,
                                        adminId: adminId,
                                      ));
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: bgColor, boxShadow: contShadow()),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: CircleAvatar(
                                            radius: 38,
                                            backgroundColor: kWhite,
                                            child: CircleAvatar(
                                              backgroundColor: bFire,
                                              radius: 35,
                                              child: ClipOval(
                                                child: Image.network(
                                                  userDetails.photo,
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  fit: BoxFit.cover,
                                                  loadingBuilder:
                                                      (BuildContext context,
                                                          Widget child,
                                                          ImageChunkEvent?
                                                              loadingProgress) {
                                                    if (loadingProgress ==
                                                        null) {
                                                      return child;
                                                    } else {
                                                      return const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      );
                                                    }
                                                  },
                                                  errorBuilder: (BuildContext
                                                          context,
                                                      Object error,
                                                      StackTrace? stackTrace) {
                                                    return Image.asset(
                                                      'assets/images/emptyDp.jpg',
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                      fit: BoxFit.cover,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          top: -15,
                                          child: PopupMenuButton(
                                            color: kWhite,
                                            onSelected: (value) async {
                                              value == 'profile'
                                                  ? Get.to(() => MyProfile(
                                                        name: userDetails.name,
                                                        address:
                                                            userDetails.address,
                                                        dob: userDetails.dob,
                                                        bloodGroup: userDetails
                                                            .bloodGroup,
                                                        photo:
                                                            userDetails.photo,
                                                        mobile:
                                                            userDetails.mobile!,
                                                      ))
                                                  : deleteDialogBox(context,
                                                      () {
                                                      controller.deleteUserData(
                                                          userDetails.id ?? '');
                                                      imageController
                                                          .deleteImageFromFirebase(
                                                              userDetails
                                                                  .photo);
                                                      Get.back();
                                                    });
                                            },
                                            itemBuilder: (context) {
                                              return [
                                                const PopupMenuItem(
                                                  value: 'profile',
                                                  child: Text(
                                                    'Profile',
                                                    style: TextStyle(
                                                        color: bgColor),
                                                  ),
                                                ),
                                                const PopupMenuItem(
                                                  value: 'delete',
                                                  child: Text('Delete',
                                                      style: TextStyle(
                                                          color: bgColor)),
                                                )
                                              ];
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    tileText(capitalize(userDetails.name), 19,
                                        FontWeight.bold, kWhite),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

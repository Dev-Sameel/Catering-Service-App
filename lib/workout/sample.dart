// import 'dart:developer';

// import 'package:catering/model/user.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../Refactoring/firebase/variables.dart';
// import '../../Refactoring/methods/app_bar_cuper.dart';
// import '../../Refactoring/methods/delete_dialogbox.dart';
// import '../../Refactoring/methods/others.dart';
// import '../../Refactoring/styles/colors.dart';
// import '../../Refactoring/styles/container.dart';
// import '../../Refactoring/styles/font.dart';
// import '../../Refactoring/widgets/others.dart';
// import '../../chat/model/chat_room_model.dart';
// import '../../chat/screens/chat_room_page.dart';
// import '../../controller/boys_history_controller.dart';
// import '../../controller/image_controller.dart';
// import '../../main.dart';
// import '../boys_side/drawer/my_profile.dart';

// class BoysHistory extends StatefulWidget {

//   BoysHistory({super.key});

//   @override
//   State<BoysHistory> createState() => _BoysHistoryState();
// }

// class _BoysHistoryState extends State<BoysHistory> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     getUserStream();
//     searchController.addListener(() {onSearchChanged();});
//     super.initState();
//   }

//   onSearchChanged(){
//     log(searchController.text);
//     searchResultList();
//   }
//   final String adminId = 'wzaxXP0cddR3k9KXVmsV';

//   final BoysHistoryController controller = Get.put(BoysHistoryController());

//   final ImagePickerController imageController =
//       Get.put(ImagePickerController());

//   Future<ChatRoomModel?> getChatRoomModel(UserData userData) async {
//     ChatRoomModel? chatRoom;
//     QuerySnapshot snapshot = await FirebaseFirestore.instance
//         .collection('chatRooms')
//         .where('participants.${adminId}', isEqualTo: true)
//         .where('participants.${userData.id}', isEqualTo: true)
//         .get();

//     if (snapshot.docs.length > 0) {
//       log('ChatRoom Already Created');
//       var docData = snapshot.docs[0].data();
//       ChatRoomModel existingChatRoom =
//           ChatRoomModel.fromMap(docData as Map<String, dynamic>);
//       chatRoom = existingChatRoom;
//     } else {
//       ChatRoomModel newChatRoom = ChatRoomModel(
//           chatRoomId: uuid.v1(),
//           lastMessage: '',
//           participants: {
//             adminId.toString(): true,
//             userData.id.toString(): true
//           },
//           users: [adminId.toString(), userData.id.toString()],
//           createDon: DateTime.now());

//       await FirebaseFirestore.instance
//           .collection('chatRooms')
//           .doc(newChatRoom.chatRoomId)
//           .set(newChatRoom.toMap());
//       chatRoom = newChatRoom;
//       log('New ChatRoom Created');
//     }
//     return chatRoom;
//   }

//   List allResults=[];
//   List resultList=[];
//   final searchController=TextEditingController();
//   getUserStream() async
//   {
//     var data=await userRegCollection.orderBy('name').get();
//     setState(() {
//       allResults=data.docs;
//     });
//     searchResultList();
//   }

//   searchResultList()
//   {
//     var showResult=[];
//     if(searchController.text!='')
//     {
//       for(var userSnapShot in allResults)
//       {
//         var name=userSnapShot['name'].toString().toLowerCase();
//         if(name.contains(searchController.text.toLowerCase()))
//         {
//           showResult.add(userSnapShot);
//         }
//       }
//     }
//     else
//     {
//       showResult=List.from(allResults);
//     }

//     setState(() {
//       resultList=showResult;
//     });
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     searchController.removeListener(() {onSearchChanged();});
//     searchController.dispose();
//     super.dispose();
//   }

//   @override
//   void didChangeDependencies() {
//     // TODO: implement didChangeDependencies
//     getUserStream();
//     super.didChangeDependencies();
//   }
  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: bgColor,
//       appBar: AppBar(title: CupertinoSearchTextField(controller: searchController,),backgroundColor: cFire,),
//       body: ScrollConfiguration(
//         behavior: RemoveGlow(),
//         child: StreamBuilder(
//           stream: userRegCollection.snapshots(),
//           builder: (context, AsyncSnapshot snapshot) {
//             if (snapshot.hasError) {
//               return Center(
//                 child: Text('Error: ${snapshot.error}'),
//               );
//             }
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }

//             controller.mapRecords(snapshot.data!);

//             return Column(
//               children: [
//                 Stack(
//                   children: [
//                     Image(
//                       image: AssetImage('assets/images/woodBoard.png'),
//                       height: 110,
//                     ),
//                     Positioned(
//                       left: 40,
//                       top: 63,
//                       child: Text(
//                           'Total boys count: ${controller.users.length}',
//                           style: TextStyle(
//                               shadows: [
//                                 Shadow(
//                                     offset: Offset(1, 2),
//                                     color: Color.fromARGB(255, 34, 18, 0),
//                                     blurRadius: 10)
//                               ],
//                               fontSize: 19,
//                               color: Color.fromARGB(255, 240, 215, 187),
//                               fontWeight: FontWeight.bold)),
//                     ),
//                   ],
//                 ),
//                 Expanded(
//                   child: 
//                    ListView.builder(
//                        itemCount: resultList.length, // Use resultList instead of controller.users
//   itemBuilder: (context, index) {
//     final userDetails = resultList[index]; 
//                         return Container(
//                           decoration: BoxDecoration(
//                               gradient: LinearGradient(colors: [Color.fromARGB(255, 236, 199, 156),Color.fromARGB(255, 240, 215, 187)]),
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: contShadow()),
//                           height: 80,
//                           margin: const EdgeInsets.only(
//                               left: 30, right: 30, top: 20),
//                           child: Center(
//                             child: ListTile(
//                               visualDensity: VisualDensity(vertical:2.5),
//                               onTap: () async {
//                                 ChatRoomModel? chatRoomModel =
//                                     await getChatRoomModel(
//                                         controller.users[index]);
//                                 if (chatRoomModel != null) {
//                                   Get.to(() => ChatRoomPage(
//                                       side: 'admin',
//                                       targetUser: controller.users[index],
//                                       chatRoom: chatRoomModel,
//                                       // firebaseUser: widget.firebaseUser,
//                                       adminId: adminId));
//                                 }

//                                 // Get.to(() => const AChat());
//                               },
//                               leading: Container(
//                                 width: 80,
//                                 height: 80,
//                                 child: CircleAvatar(
//                                   backgroundColor: kWhite,
//                                   radius: 30,
//                                   child: ClipOval(
//                                     child: Image.network(
//                                       userDetails.data()['photo'],
//                                       width: 60,
//                                       height: 60,
//                                       fit: BoxFit.cover,
//                                       loadingBuilder: (BuildContext context,
//                                           Widget child,
//                                           ImageChunkEvent? loadingProgress) {
//                                         if (loadingProgress == null) {
//                                           // Image is loaded successfully
//                                           return child;
//                                         } else {
//                                           // Image is still loading
//                                           return const Center(
//                                             child: CircularProgressIndicator(),
//                                           );
//                                         }
//                                       },
//                                       errorBuilder: (BuildContext context,
//                                           Object error, StackTrace? stackTrace) {
//                                         // Error occurred while loading the image
//                                         return Image.asset(
//                                           'assets/images/emptyDp.jpg',
//                                           width: 60,
//                                           height: 60,
//                                           fit: BoxFit.cover,
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               title: Text(capitalize(userDetails.data()['name']),
//                                   style: const TextStyle(
//                                       fontSize: 20, color: Color.fromARGB(255, 133, 71, 1),fontWeight: FontWeight.bold,fontFamily: 'JosefinSans')),
//                               trailing: PopupMenuButton(
//                                 color: Color.fromARGB(255, 133, 71, 1),
//                                 onSelected: (value) async {
//                                   value == 'profile'
//                                       ? Get.to(() => MyProfile(
//                                             name: userDetails.name,
//                                             address: userDetails.address,
//                                             dob: userDetails.dob,
//                                             bloodGroup: userDetails.bloodGroup,
//                                             photo: userDetails.photo,
//                                             mobile: userDetails.mobile!,
//                                           ))
//                                       : deleteDialogBox(context, () {
//                                           controller.deleteUserData(
//                                               userDetails.id ?? '');
//                                           imageController
//                                               .deleteImageFromFirebase(
//                                                   userDetails.photo);
//                                           Get.back();
//                                         });
//                                 },
//                                 itemBuilder: (context) {
//                                   return [
//                                     const PopupMenuItem(
//                                       value: 'profile',
//                                       child: Text('Profile',style: TextStyle(color: kWhite),),
//                                     ),
//                                     const PopupMenuItem(
//                                       value: 'delete',
//                                       child: Text('Delete',style: TextStyle(color: kWhite)),
//                                     )
//                                   ];
//                                 },
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
                
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//------------------------------------------------
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';

// import '../Refactoring/firebase/variables.dart';
// import '../model/user.dart';

// class BoysHistoryController extends GetxController {
//   final List<UserData> users = <UserData>[].obs;

//   @override
//   void onInit() {
//     fetchRecords();
//     userRegCollection.snapshots().listen((records) {
//       mapRecords(records);
//     });
//     super.onInit();
//   }

//   fetchRecords() async {
//     final records = await userRegCollection.get();
//     mapRecords(records);
//   }

//   void mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
//     var list = records.docs.map(
//       (item) {
//         try {
//           // return UserData(
//           //   confirmedWork: item['confirmedWork'],
//           //   photo: item['photo'],
//           //   id: item.id,
//           //   name: item['name'] ?? '',
//           //   address: item['address'] ?? '',
//           //   bloodGroup: item['bloodGroup'] ?? '',
//           //   dob: item['dob'] ?? '',
//           //   mobile: item['mobile'] ?? 0,
//           //   password: item['password'] ?? 0,
//           // );
//           return UserData.fromJson(item.data(),item.id);
//         } catch (e) {
//           if (kDebugMode) {
//             print('Error parsing document: $e');
//           }
//           if (kDebugMode) {
//             print('Document data: ${item.data()}');
//           }
//           rethrow; // Rethrow the exception to propagate it further
//         }
//       },
//     ).toList();

//     users.assignAll(list);
//   }

//   deleteUserData(String id) {
//     userRegCollection.doc(id).delete();
//   }
// }
//-----------------------------------------------
                  // child: ListView.builder(
                  //   itemCount: resultList
                  //       .length, // Use resultList instead of controller.users
                  //   itemBuilder: (context, index) {
                  //     final userDetails = resultList[index];
                  //     return Container(
                  //       decoration: BoxDecoration(
                  //           gradient: const LinearGradient(colors: [
                  //             Color.fromARGB(255, 236, 199, 156),
                  //             Color.fromARGB(255, 240, 215, 187)
                  //           ]),
                  //           borderRadius: BorderRadius.circular(10),
                  //           boxShadow: contShadow()),
                  //       height: 80,
                  //       margin:
                  //           const EdgeInsets.only(left: 30, right: 30, top: 20),
                  //       child: Center(
                  //         child: ListTile(
                  //           visualDensity: const VisualDensity(vertical: 2.5),
                  //           onTap: () async {
                  //             ChatRoomModel? chatRoomModel =
                  //                 await getChatRoomModel(
                  //                     controller.users[index]);
                  //             if (chatRoomModel != null) {
                  //               Get.to(() => ChatRoomPage(
                  //                   side: 'admin',
                  //                   targetUser: controller.users[index],
                  //                   chatRoom: chatRoomModel,
                  //                   // firebaseUser: widget.firebaseUser,
                  //                   adminId: adminId));
                  //             }

                  //             // Get.to(() => const AChat());
                  //           },
                  //           leading: SizedBox(
                  //             width: 80,
                  //             height: 80,
                  //             child: CircleAvatar(
                  //               backgroundColor: kWhite,
                  //               radius: 30,
                  //               child: ClipOval(
                  //                 child: Image.network(
                  //                   userDetails.data()['photo'],
                  //                   width: 60,
                  //                   height: 60,
                  //                   fit: BoxFit.cover,
                  //                   loadingBuilder: (BuildContext context,
                  //                       Widget child,
                  //                       ImageChunkEvent? loadingProgress) {
                  //                     if (loadingProgress == null) {
                  //                       // Image is loaded successfully
                  //                       return child;
                  //                     } else {
                  //                       // Image is still loading
                  //                       return const Center(
                  //                         child: CircularProgressIndicator(),
                  //                       );
                  //                     }
                  //                   },
                  //                   errorBuilder: (BuildContext context,
                  //                       Object error, StackTrace? stackTrace) {
                  //                     // Error occurred while loading the image
                  //                     return Image.asset(
                  //                       'assets/images/emptyDp.jpg',
                  //                       width: 60,
                  //                       height: 60,
                  //                       fit: BoxFit.cover,
                  //                     );
                  //                   },
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //           title: Text(capitalize(userDetails.data()['name']),
                  //               style: const TextStyle(
                  //                   fontSize: 20,
                  //                   color: Color.fromARGB(255, 133, 71, 1),
                  //                   fontWeight: FontWeight.bold,
                  //                   fontFamily: 'JosefinSans')),
                  //           trailing: PopupMenuButton(
                  //             color: const Color.fromARGB(255, 133, 71, 1),
                  //             onSelected: (value) async {
                  //               value == 'profile'
                  //                   ? Get.to(() => MyProfile(
                  //                         name: userDetails.name,
                  //                         address: userDetails.address,
                  //                         dob: userDetails.dob,
                  //                         bloodGroup: userDetails.bloodGroup,
                  //                         photo: userDetails.photo,
                  //                         mobile: userDetails.mobile!,
                  //                       ))
                  //                   : deleteDialogBox(context, () {
                  //                       controller.deleteUserData(
                  //                           userDetails.id ?? '');
                  //                       imageController.deleteImageFromFirebase(
                  //                           userDetails.photo);
                  //                       Get.back();
                  //                     });
                  //             },
                  //             itemBuilder: (context) {
                  //               return [
                  //                 const PopupMenuItem(
                  //                   value: 'profile',
                  //                   child: Text(
                  //                     'Profile',
                  //                     style: TextStyle(color: kWhite),
                  //                   ),
                  //                 ),
                  //                 const PopupMenuItem(
                  //                   value: 'delete',
                  //                   child: Text('Delete',
                  //                       style: TextStyle(color: kWhite)),
                  //                 )
                  //               ];
                  //             },
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
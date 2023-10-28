import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../styles/colors.dart';

Future<void> deleteDialogBox(
    BuildContext context, VoidCallback onChanged) async {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 230,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Image(
                  image: AssetImage('assets/images/closeIcon.png'),
                  width: 80,
                  color: kRed,
                ),
                const Text('Are you sure?',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                const Text(
                  'Do you really want to delete these records? This process cannot be undone',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                          style: const ButtonStyle(
                              elevation: MaterialStatePropertyAll(0),
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.grey)),
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(fontSize: 15),
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                          style: const ButtonStyle(
                            elevation: MaterialStatePropertyAll(0),
                            backgroundColor: MaterialStatePropertyAll(kRed),
                          ),
                          onPressed: onChanged,
                          child: const Text('Delete',
                              style: TextStyle(fontSize: 15))),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      });
}

// class DeleteDialogBox extends StatelessWidget {

//   const DeleteDialogBox({required this.id,super.key,this.imageUrl});

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//           content: SizedBox(
//             height: 230,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 const Image(
//                   image: AssetImage('assets/images/closeIcon.png'),
//                   width: 80,
//                   color: kRed,
//                 ),
//                 const Text('Are you sure?',
//                     style:
//                         TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
//                 const Text(
//                   'Do you really want to delete these records? This process cannot be undone',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 14, color: Colors.grey),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       width: 100,
//                       child: ElevatedButton(
//                           style: const ButtonStyle(
//                               elevation: MaterialStatePropertyAll(0),
//                               backgroundColor:
//                                   MaterialStatePropertyAll(Colors.grey)),
//                           onPressed: () {
//                             Get.back();
//                           },
//                           child: const Text(
//                             'Cancel',
//                             style: TextStyle(fontSize: 15),
//                           )),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     SizedBox(
//                       width: 100,
//                       child: ElevatedButton(
//                           style: const ButtonStyle(
//                             elevation: MaterialStatePropertyAll(0),
//                             backgroundColor: MaterialStatePropertyAll(kRed),
//                           ),
//                           onPressed: () {
//                             controller.deleteUserData(id);
//                             imageController.deleteImageFromFirebase(imageUrl);
//                             Get.back();
//                           },
//                           child: const Text('Delete',
//                               style: TextStyle(fontSize: 15))),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         );
//   }
// }
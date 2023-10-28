import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
  Rx<File> image = File('').obs;
  Future getImage() async {
    try {
      final imagePick =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (imagePick == null) {
        return;
      }
      final imagTemp = File(imagePick.path);
      image.value = imagTemp;
    } on PlatformException catch (e) {
      return e;
    }
  }

  Rx<String> netWorkImage = ''.obs;

  Future<String> uploadImageToFirebase() async {
    String fileName = DateTime.now().microsecondsSinceEpoch.toString();

    try {
      Reference reference =
          FirebaseStorage.instance.ref().child('ProfileDp/$fileName.png');
      await reference.putFile(image.value);
      String downloadURL = await reference.getDownloadURL();
      netWorkImage.value = downloadURL;

      return downloadURL;
    } catch (e) {
      return '';
    }
  }

  Future<void> deleteImageFromFirebase(String imageUrl) async {
    try {
      Reference reference = FirebaseStorage.instance.refFromURL(imageUrl);

      await reference.delete();
    } catch (e) {
      Get.snackbar('Error', "'Error deleting image from Firebase Storage: $e'");
    }
  }
}

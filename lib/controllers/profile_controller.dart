import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kanoon4lawyers/authentication/signin_screen.dart';
import 'package:ndialog/ndialog.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController passwordController = TextEditingController();
  Stream<QuerySnapshot<Map<String, dynamic>>> allLawyers() {
    return FirebaseFirestore.instance.collection('lawyers').snapshots();
  }

  final picker = ImagePicker();
  XFile? _image;
  XFile? get image => _image;

  Future pickGalleryimage() async {
    isLoading.value = true;
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadProfilePicture();

      isLoading.value = false;
    }
      isLoading.value = false;

  }

  Future pickCameraimage() async {
    isLoading.value = true;

    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadProfilePicture();

      isLoading.value = false;
    }
      isLoading.value = false;

  }

  void pickImage(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 120,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    pickCameraimage();
                    Get.back();
                  },
                  leading: const Icon(
                    Icons.camera_alt,
                    color: Colors.green,
                  ),
                  title: const Text('Camera'),
                ),
                ListTile(
                  onTap: () {
                    pickGalleryimage();

                    Get.back();
                  },
                  leading: const Icon(
                    Icons.image,
                    color: Colors.green,
                  ),
                  title: const Text('Gallery'),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<String> uploadProfilePicture() async {
    isLoading.value = true;
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref('profileImage/');
      await ref.putFile(File(image!.path).absolute);
      String imageUrl = await ref.getDownloadURL();
      // print("Image URL : " + imageUrl);
      await FirebaseAuth.instance.currentUser!.updatePhotoURL(imageUrl);
      FirebaseFirestore.instance
          .collection('lawyers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'image': imageUrl.toString()}).then((value) {
        Fluttertoast.showToast(msg: 'Profile updated');
        isLoading.value = false;
        _image = null;
      });
      isLoading.value = false;

      return imageUrl;
    } on FirebaseException catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString());
    }

    return '';
  }
//

//
//

  logOut() async {
    await FirebaseAuth.instance.signOut();
    Get.to(() => const SigninScreen());
  }
  //
  //

  Future<void> updatePassword(
      {required String oldPassword,required BuildContext context, required String newPassword}) async {
        ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text('Please wait'), title: null);
    try {
progressDialog.show();

      await FirebaseAuth.instance.currentUser!.updatePassword(newPassword);

      await FirebaseFirestore.instance
          .collection('lawyers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'password': newPassword});
      Get.snackbar('Success', 'Password updated ');

      progressDialog.dismiss();
    } catch (e) {
      progressDialog.dismiss();
      Get.snackbar('Error', e.toString());
    }
  }

  //
  //
  //
  Future<String> uploadProfile(
    String email,
    String fileName,
    String filePath,
  ) async {
    // File file = File(FilePath);
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref('$email/').child(fileName);
      await ref.putFile(File(filePath));
      String imageUrl = await ref.getDownloadURL();
      // print("Image URL : " + imageUrl);
      await FirebaseAuth.instance.currentUser!.updatePhotoURL(imageUrl);
      return imageUrl;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return '';
  }
//
//
//

  Future<void> updateCaseStatus(
      {required String status,required BuildContext context, required String caseId}) async {
        ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text('Please wait'), title: null);
    try {
      // var uuid = const Uuid();
      // var id = uuid.v6();
progressDialog.show();
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(caseId)
          .update({'status': status});
      //
      //

      progressDialog.dismiss();
      Get.snackbar('Success', 'Case status updated successfully');
    } catch (error) {
      progressDialog.dismiss();

     
      Get.snackbar('Error', error.toString());
    }
  }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kanoon4lawyers/authentication/degree_data.dart';
import 'package:kanoon4lawyers/dashboard/dashboard.dart';
import 'package:kanoon4lawyers/models/account_model.dart';
import 'package:ndialog/ndialog.dart';

import '../authentication/signin_screen.dart';

class AuthController extends GetxController {
  //
  //
  RxBool isLoading = false.obs;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final picker = ImagePicker();
  XFile? _image;
  XFile? get image => _image;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//
  Position? currentPosition;

  Future<Position> getCurrentLocation() async {
    bool serviceEnable;
    LocationPermission permission;

    serviceEnable = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnable) {
      Fluttertoast.showToast(msg: "Location Service not enabled");
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: "You denied the permission");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: "You Denied Permission Forever");
    }

    return Geolocator.getCurrentPosition();
  }

//
//
  Future<void> signUpMethod({
    required BuildContext context,
    required String name,
    required String contact,
    required String password,
    required String bar,
    required String email,
    required String category,
    required String address,
    required String experience,
    required String date,
    required String practice,
    required String bio,
    required String price,
  }) async {
    ProgressDialog progressDialog = ProgressDialog(context,
        title: const Text('Signing Up'), message: const Text('Please wait'));
    progressDialog.show();
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //
      //
      String uploadImage = await uploadProfilePicture();
      final location = await getCurrentLocation();
      //
      //

      AccountModel accountModel = AccountModel(
        lawyerId: FirebaseAuth.instance.currentUser!.uid,
        name: name,
        contact: contact,
        password: password,
        bar: bar,
        email: email,
        category: category,
        address: address,
        experience: experience,
        image: uploadImage,
        date: date,
        practice: practice,
        bio: bio,
        price: price,
        longitude: location.longitude.toString(),
        latitude: location.latitude.toString(),
      );

      if (userCredential.user != null) {
        await _firestore
            .collection('lawyers')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set(accountModel.toJson());
        progressDialog.dismiss();
        Fluttertoast.showToast(msg: 'Sign Up Successfully');
        Get.off(() => const DegreeData());
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.toString());

      progressDialog.dismiss();
      if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'Email already in use');
        return;
      } else if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'Password is weak');
        return;
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Invalid Password');
      } else if (e.code == 'invalid-email') {
        Fluttertoast.showToast(msg: 'Invalid Email');
      } else if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'User not found');
      }
    } catch (e) {
      progressDialog.dismiss();
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  }
//
//
//

  Future<void> signInMethod(
      BuildContext context, String email, String password) async {
    ProgressDialog progressDialog = ProgressDialog(context,
        title: const Text('Signing In'), message: const Text('Please wait'));
    progressDialog.show();
     
   
    
  
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
          
      final location = await getCurrentLocation();
  
    
        progressDialog.show();
      await FirebaseFirestore.instance
          .collection('lawyers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
              'longitude': location.longitude.toString(),
        'latitude': location.latitude.toString(),
        
      });
      if (userCredential.user != null) {
        progressDialog.dismiss();
        Fluttertoast.showToast(msg: 'Login Successfully');

        Get.off(() => const Dashboard());
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.toString());

      progressDialog.dismiss();
      if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Invalid Password');
      } else if (e.code == 'invalid-email') {
        Fluttertoast.showToast(msg: 'Invalid Email');
      } else if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'User not found');
      }
    } catch (e) {
      progressDialog.dismiss();
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  }

  Future<void> resetmypassword(String email, BuildContext context) async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text('Please wait'), title: null);
    try {
      progressDialog.show();
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.snackbar('Success', 'Check your email for Password Reset Link');
      progressDialog.dismiss();

      Get.to(() => const SigninScreen());
    } catch (e) {
      progressDialog.dismiss();
      Get.snackbar('Error', e.toString());
    }
  }

  //

  Future<String> uploadProfilePicture() async {
    String imagePath =
        'profile_images/${FirebaseAuth.instance.currentUser!.uid}.png';
    Reference storageReference = _storage.ref().child(imagePath);
    await storageReference.putFile(File(image!.path).absolute);

    String imageUrl = await storageReference.getDownloadURL();
    return imageUrl;
  }

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

  //
  //
  Future<void> setUserAlwaysAvailable(BuildContext context) async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text('Please wait'), title: null);
    try {
      progressDialog.show();
      await _firestore
          .collection('lawyers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({'available': 'All Time Available'}, SetOptions(merge: true));
      Fluttertoast.showToast(msg: 'Schedule updated successfully!');

      progressDialog.dismiss();
    } catch (e) {
      progressDialog.dismiss();

      Get.snackbar('Error', e.toString());
    }
  }
}

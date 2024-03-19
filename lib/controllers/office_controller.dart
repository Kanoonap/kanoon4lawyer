import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kanoon4lawyers/authentication/verifying_data.dart';
import 'package:ndialog/ndialog.dart';

class OfficeController extends GetxController {
  RxString pdfUrl = "".obs;
  RxBool isPdfUploading = false.obs;

  final storage = FirebaseStorage.instance;
  final db = FirebaseFirestore.instance;

  Future<void> addOfficeAddress(
    BuildContext context,
    String role,
    String name,
    String address,
  ) async {
    ProgressDialog progressDialog =
        ProgressDialog(context, message: const Text('Please wait'), title: null);
    try {
      progressDialog.show();

      // OfficeModel officeModel = OfficeModel(
      //     role: role,
      //     id: FirebaseAuth.instance.currentUser!.uid,
      //     name: name,
      //     address: address);

      await db
          .collection('lawyers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('office')
          .add({
        'role': role,
        'id': FirebaseAuth.instance.currentUser!.uid,
        'name': name,
        'address': address
      });
      progressDialog.dismiss();

      Fluttertoast.showToast(msg: "Information Added successfully");
      Get.to(() => const Verifying());
    } catch (e) {
      progressDialog.dismiss();
      Get.snackbar(
        "Error",
        "$e",
      );
    }
  }
}

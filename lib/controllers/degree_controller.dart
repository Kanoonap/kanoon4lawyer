import 'dart:io';
import 'package:file_picker/file_picker.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kanoon4lawyers/authentication/office_address.dart';
import 'package:ndialog/ndialog.dart';

class DegreeController extends GetxController {
  RxString pdfUrl = "".obs;
  RxBool isPdfUploading = false.obs;

  final storage = FirebaseStorage.instance;
  final db = FirebaseFirestore.instance;

  Future<void> addDegreeData(
    String batch,
    BuildContext context,
    String name,
    String degree,
    String address,
  ) async {
     ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text('Please wait'), title: null);
    try {
      progressDialog.show();

      // DegreeModel degreeModel = DegreeModel(
      //     batch: batch,
      //     clgName: name,
      //     degree: degree,
      //     documents: pdfUrl.value,
      //     address: address,
      //     id: FirebaseAuth.instance.currentUser!.uid

      //     );

      await db
          .collection('lawyers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('degree')
          .add({
        'batch': batch,
        'clgName': name,
        'degree': degree,
        'documents': pdfUrl.value,
        'address': address,
        'id': FirebaseAuth.instance.currentUser!.uid
      });
      Get.to(() => const OfficeAddress());
      Fluttertoast.showToast(msg: "Information Added successfully");

      progressDialog.dismiss();
    } catch (e) {
      progressDialog.dismiss();
      Get.snackbar(
        "Error",
        "$e",
      );
    }
  }

  void pickPDF() async {
    isPdfUploading.value = true;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      File file = File(result.files.first.path!);

      if (file.existsSync()) {
        Uint8List fileBytes = await file.readAsBytes();
        String fileName = result.files.first.name;
        if (kDebugMode) {
          print("File Bytes: $fileBytes");
        }

        final response =
            await storage.ref().child("Pdf/$fileName").putData(fileBytes);

        final downloadURL = await response.ref.getDownloadURL();
        pdfUrl.value = downloadURL;
        if (kDebugMode) {
          print(downloadURL);
        }
      } else {
        Fluttertoast.showToast(msg: 'File does not exis');
        if (kDebugMode) {
          print("File does not exist");
        }
      }
    } else {
      if (kDebugMode) {
        print("No file selected");
      }
      Fluttertoast.showToast(msg: 'No file selected');
    }
    isPdfUploading.value = false;
  }
  //
  //
  //  Future<void> uploadPdfs() async {
  //   isPdfUploading.value = true;

  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf'],
  //   );

  //   if (result != null) {
  //     File file = File(result.files.single.path!);
  //       String fileName = result.files.first.name;

  //     // Upload the PDF to Firebase Storage
  //     Reference storageReference = FirebaseStorage.instance.ref().child(
  //         'user_pdfs/${FirebaseAuth.instance.currentUser!.uid}/${result.files.single.name}');
  //     UploadTask uploadTask = storageReference.putFile(file);

  //     await uploadTask.whenComplete(() async {
  //       String url = await storageReference.getDownloadURL();

  //      await FirebaseFirestore.instance.collection('documents').add({
  //         'pdfname': fileName,
  //         'pdfid': FirebaseAuth.instance.currentUser!.uid,
  //         'pdf': url,
  //         'timestamp': FieldValue.serverTimestamp(),
  //       });

  //       // Show a success message
  //     Get.snackbar('Success', 'PDF uploaded successfully');
  //   isPdfUploading.value = false;

  //     });
  //   }
  //  }
  //

  void uploadpdf() async {
    isPdfUploading.value = true;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      File file = File(result.files.first.path!);

      if (file.existsSync()) {
        Uint8List fileBytes = await file.readAsBytes();
        String fileName = result.files.first.name;
        if (kDebugMode) {
          print("File Bytes: $fileBytes");
        }

        final response =
            await storage.ref().child("Pdf/$fileName").putData(fileBytes);

        final url = await response.ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('documents')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          'pdfname': fileName,
          'pdfid': FirebaseAuth.instance.currentUser!.uid,
          'pdf': url,
          'timestamp': FieldValue.serverTimestamp(),
        });
        if (kDebugMode) {
          print(url);
        }
      } else {
        Fluttertoast.showToast(msg: 'File does not exis');
      }
    } else {
      Fluttertoast.showToast(msg: 'No file selected');
    }
    isPdfUploading.value = false;
  }

//
//
  Future<void> deletePdf(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('documents')
          .doc(id)
          .delete()
          .then((value) {});
      Get.snackbar('Success', 'Document successfully deleted!');
    } catch (e) {
      Get.snackbar('Error', 'Error deleting document: $e');
    }
  }
}

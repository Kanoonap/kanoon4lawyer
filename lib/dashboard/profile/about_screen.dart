// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kanoon4lawyers/dashboard/view_pdf_screen.dart';
// import 'package:velocity_x/velocity_x.dart';

// import '../../controllers/degree_controller.dart';

// class AboutScreen extends StatefulWidget {
//   const AboutScreen({super.key});

//   @override
//   State<AboutScreen> createState() => _AboutScreenState();
// }

// class _AboutScreenState extends State<AboutScreen> {
//   DegreeController controller = Get.put(DegreeController());

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(6),
//                 child: Row(
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       icon: Container(
//                         height: 30,
//                         width: 30,
//                         decoration: const BoxDecoration(
//                           color: Colors.black,
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Icon(
//                           Icons.arrow_back_ios_new,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: Get.width * .28),
//                     const Text(
//                       'Documents',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Color(0xFF1A1A1A),
//                         fontSize: 20,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 14),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     22.heightBox,
//                     Center(
//                       child: Image.asset(
//                         'assets/pdf.png',
//                         height: 100,
//                         width: 100,
//                       ),
//                     ),
//                     const Text(
//                       'You need to upload your',
//                       style: TextStyle(
//                         color: Colors.black87,
//                         fontSize: 15,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     const Text(
//                       'Multiple Files and Upload Legal Documents.',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     const Text(
//                       'You can attach multiple file upload legal document.',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.black87,
//                         fontSize: 13,
//                       ),
//                     ),
//                     50.heightBox,
//                     Obx(
//                       () => Container(
//                           width: Get.size.width,
//                           height: 49,
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 90, vertical: 14),
//                           clipBehavior: Clip.antiAlias,
//                           decoration: ShapeDecoration(
//                             shape: RoundedRectangleBorder(
//                               side: const BorderSide(
//                                   width: 1, color: Color(0xFFABABAB)),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           child: controller.isPdfUploading.value
//                               ? const Center(
//                                   child: CircularProgressIndicator(),
//                                 )
//                               : GestureDetector(
//                                   onTap: () async {
//                                     controller.uploadpdf();
//                                   },
//                                   child: const Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         'Upload Document',
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                           color: Color(0xFFFFC100),
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 )),
//                     ),
//                     const SizedBox(
//                       height: 55,
//                     ),
//                     StreamBuilder(
//                         stream: FirebaseFirestore.instance
//                             .collection('documents')
//                             .where('pdfid',
//                                 isEqualTo:
//                                     FirebaseAuth.instance.currentUser!.uid)
//                             // .orderBy('timestamp', descending: true)
//                             .snapshots(),
//                         builder:
//                             (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return const Padding(
//                               padding: EdgeInsets.only(top: 122),
//                               child: CircularProgressIndicator(),
//                             );
//                           } else if (!snapshot.hasData ||
//                               snapshot.data!.docs.isEmpty) {
//                             return Padding(
//                               padding: const EdgeInsets.only(top: 122),
//                               child: Text(
//                                 'You have not any document yet',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w400,
//                                     color: Colors.amber.shade700),
//                               ),
//                             );
//                           } else {
//                             return Column(
//                                 children: snapshot.data?.docs.map((e) {
//                                       return Column(
//                                         children: [
//                                           GestureDetector(
//                                             onLongPress: () async {
//                                               showDialog(
//                                                   context: context,
//                                                   builder:
//                                                       (context) => AlertDialog(
//                                                             title: const Text(
//                                                                 "Are you sure ?"),
//                                                             content: const Text(
//                                                                 "Click Confirm if you want to delete this item"),
//                                                             actions: [
//                                                               TextButton(
//                                                                   onPressed:
//                                                                       () {
//                                                                     Navigator.pop(
//                                                                         context);
//                                                                   },
//                                                                   child: const Text(
//                                                                       "Cancel")),
//                                                               TextButton(
//                                                                   onPressed:
//                                                                       () async {
//                                                                     controller
//                                                                         .deletePdf(
//                                                                             e['pdfid']);
//                                                                     Get.back();
//                                                                   },
//                                                                   child:
//                                                                       const Text(
//                                                                     "Delete",
//                                                                     style:
//                                                                         TextStyle(
//                                                                       color: Colors
//                                                                           .red,
//                                                                     ),
//                                                                   ))
//                                                             ],
//                                                           ));
//                                             },
//                                             onTap: () {
//                                               Get.to(() => PdfViewerScreen(
//                                                     documents: e['pdf'],
//                                                     id: e['pdfid'],
//                                                   ));
//                                             },
//                                             child: Container(
//                                               width: Get.size.width,
//                                               margin:
//                                                   const EdgeInsets.symmetric(
//                                                       vertical: 6),
//                                               height: 66,
//                                               clipBehavior: Clip.antiAlias,
//                                               decoration: ShapeDecoration(
//                                                 shape: RoundedRectangleBorder(
//                                                   side: const BorderSide(
//                                                       width: 1,
//                                                       color: Color(0xFFABABAB)),
//                                                   borderRadius:
//                                                       BorderRadius.circular(8),
//                                                 ),
//                                               ),
//                                               child: Row(
//                                                 children: [
//                                                   Image.asset(
//                                                       'assets/pdfs.png'),
//                                                   const SizedBox(
//                                                     width: 6,
//                                                   ),
//                                                   Flexible(
//                                                       child: Text(e['pdfname']))
//                                                 ],
//                                               ),
//                                             ),
//                                           )
//                                         ],
//                                       );
//                                     }).toList() ??
//                                     []);
//                           }
//                         }),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child:
        
        
        
        
         Column(
           children: [
            const SizedBox(
              height: 38,
            ),
             Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: Get.width * .28),
                      const Text(
                        'About',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF1A1A1A),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                const SizedBox(
                  height: 11,
                ),
             const Padding(
               padding: EdgeInsets.symmetric(horizontal: 18,vertical: 6
               ),
               child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 
                  Text(
                    'Title: Kanoon App\nYour Personal Legal Companion\n\nDescription:',
                    style: TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Welcome to Kanoon App, your ultimate solution for all legal needs right at your fingertips. With Kanoon app user-friendly interface and comprehensive features, managing your legal affairs has never been easier',
                    textAlign: TextAlign.center,
                    style: TextStyle(),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Key Features :',
                    style: TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Text(
                    'Find Your Perfect Lawyer :',
                    style: TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Browse through a diverse database of experienced lawyers specializing in various fields of law. Whether you need a criminal defense attorney, a family law expert, or a business law consultant, Kanoon App has got you covered.',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Book Appointments Instantly :',
                    style: TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'No more waiting on hold or playing phone tag. With Kanoon App, booking appointments with your preferred lawyer is just a few taps away. Choose your preferred time slot and schedule appointments hassle-free.',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Secure Communication :',
                    style: TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Communicate with your lawyer securely through the app encrypted messaging system. Discuss your case details, share documents, and receive legal advice conveniently without compromising on privacy.',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Review and Ratings :',
                    style: TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Share your experience and rate the services provided by your lawyer. Help fellow users make informed decisions by leaving honest reviews.',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    '24/7 Support :',
                    style: TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Have questions or need assistance? Our dedicated support team is available round-the-clock to address your concerns and provide timely assistance.',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Why Choose kanoon App ?',
                    style: TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Kanoon App simplifies the legal process, putting the power of legal representation in your hands. Whether you are facing a legal challenge or seeking preventive legal advice, Kanoon App ensures that you have access to top-notch legal professionals whenever and wherever you need them.',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Download Kanoon App today and experience a revolutionary approach to managing your legal affairs. Empower yourself with knowledge, expertise, and convenience—all within the palm of your hand. Kanoon App: Your Personal Legal Companion.',
                    textAlign: TextAlign.center,
                  ),
                 ],
                         ),
             ),
           ],
         ),
      ),
    );
  }
}


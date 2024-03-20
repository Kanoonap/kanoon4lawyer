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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
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
        elevation: 1,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Title: Kanoon4Lawyers\nElevate Your Legal Practice\n\nDescription:',
                    style: TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    'Welcome to Kanoon4Lawyers , the ultimate platform designed to streamline and enhance your legal practice. Whether you are a seasoned attorney or a budding legal professional, Kanoon4Lawyers empowers you with the tools and resources needed to excel in your field.' // textAlign: TextAlign.center,
                    ,
                    style: TextStyle(),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Key Features :',
                    style: TextStyle(
                      color: Colors.red.shade400,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Text(
                    'Client Management :',
                    style: TextStyle(
                      color: Colors.blue.shade400,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                      ' Seamlessly manage your client base with Kanoon4Lawyers Connect intuitive client management system. Keep track of client details, case histories, appointments, and communications all in one centralized location.' // textAlign: TextAlign.center,
                      ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Appointments Scheduling :',
                    style: TextStyle(
                      color: Colors.blue.shade400,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                      'Effortlessly schedule appointments with clients using kanoon4Lawyers Connect convenient scheduling feature. Set availability, manage calendar events, and sync appointments across devices for efficient time management.' // textAlign: TextAlign.center,
                      ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Secure Communication :',
                    style: TextStyle(
                      color: Colors.blue.shade400,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Communicate with your Client securely through the app encrypted messaging system. Discuss your case details, share documents, and receive legal advice conveniently without compromising on privacy.',
                    // textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Task Management :',
                    style: TextStyle(
                      color: Colors.blue.shade400,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                      'Stay organized and productive with LawPro Connect task management tools. Assign tasks to team members, set deadlines, and track progress to ensure timely completion of legal assignments.' // textAlign: TextAlign.center,
                      // textAlign: TextAlign.center,
                      ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Client Portal :',
                    style: TextStyle(
                      color: Colors.blue.shade400,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                      'Provide clients with access to their case information, documents, and appointment schedules through kanoon4lawyer Connect secure client portal. Enhance transparency and communication while fostering client trust and satisfaction.' // textAlign: TextAlign.center,
                      ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Why Choose kanoon4Lawyer ?',
                    style: TextStyle(
                      color: Colors.blue.shade400,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                      'kanoon4Lawyer Connect is more than just a software platform—it is your partner in legal excellence. Whether you are looking to streamline operations, improve client communication, or enhance productivity, kanoon4Lawyer Connect offers the tools and support you need to succeed in today dynamic legal landscape' // textAlign: TextAlign.center,
                      ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                      'Join the ranks of top legal professionals who trust kanoon4Lawyer Connect to elevate their practice and deliver exceptional service to clients. Experience the future of legal practice management with kanoon4Lawyer Connect today.' // textAlign: TextAlign.center,
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

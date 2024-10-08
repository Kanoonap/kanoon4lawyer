// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../widgets/datepicker.dart';
import '../cases/case_detail_screen.dart';
import 'my_schedule.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with TickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // String selectedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  // DateTime selectedDateTime = DateTime.now();

  DateTime selectedDate = DateTime.now();


  @override
  Widget build(BuildContext context) {
    User? lawyer = _auth.currentUser;
    TabController tabController = TabController(length: 5, vsync: this);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11.2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Schedule',
                          style: TextStyle(
                            color: Color(0xFF3D3D3D),
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          DateFormat.MMMd().format(DateTime.now()),
                          style: const TextStyle(
                            color: Color(0xFF474747),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => MySchedule(
                              lawyerId: FirebaseAuth.instance.currentUser!.uid,
                            ));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Center(
                          child: Text(
                            'Fix your schedule',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 26,
                ),
                DatePicker(
                  onDateChanged: (dateTime) {
                    selectedDate = dateTime;

                    setState(() {});
                  },
                  initialDate: selectedDate,
                ),

                const SizedBox(
                  height: 28,
                ),
// )           ,     const Text(
//                   '03 Appointments',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 22,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 10.heightBox,
                Container(
                  child: TabBar(
                    controller: tabController,
                    labelPadding: const EdgeInsets.only(right: 12, left: 0),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.amber,
                    tabs: const [
                      Text(
                        'All',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'Ongoing',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'Pending',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'Completed',
                        style: TextStyle(
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        'Appealed',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  height: Get.height * .65,
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: _buildAppointmentsStream(lawyer!.uid)),
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: CasesTab(
                          status: 'ongoing',
                          text: Text(
                            'Ongoing',
                            style: TextStyle(color: Colors.purple.shade400),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: CasesTab(
                          status: 'pending',
                          text: Text(
                            'Pending',
                            style: TextStyle(color: Colors.red.shade400),
                          ),
                        ),
                      ),
                      const SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: CasesTab(
                          status: 'completed',
                          text: Text(
                            'Completed',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ),
                      const SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: CasesTab(
                          status: 'appealed',
                          text: Text(
                            'Appealed',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentsStream(String lawyerId) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('appointments')
          .where('lawyerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('date', isEqualTo: formattedDate)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return    ListView.builder(
                   itemCount: 4,
                   shrinkWrap: true,
                   itemBuilder: (context, index){
                     return Shimmer.fromColors(
                       baseColor: Colors.grey.shade300,
                       highlightColor: Colors.grey.shade100,
                       enabled: true,
                       child: Column(
                         children: [
                           ListTile(
                             leading:  Container(height: 50 , width: 50, color: Colors.white,),
                             title:  Container(
                               width: 100,
                               height: 8.0,
                               color: Colors.white,
                             ),
                             subtitle:  Container(
                               width: double.infinity,
                               height: 8.0,
                               color: Colors.white,
                             ),
                           ),

                         ],
                       ),
                     );
                   },

                  );

        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: 188),
            child: Text(
              'You have not any client yet',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.amber.shade700),
            ),
          );
        } else {
          return Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length ?? 0,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final appointment = snapshot.data!.docs[index];

                  return Column(
                    children: [
                      const SizedBox(
                        height: 6,
                      ),
                      Card(
                        elevation: 12,
                        shadowColor: Colors.black,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 14),
                          width: Get.size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 28,
                                    backgroundImage: NetworkImage(
                                      appointment['image'],
                                    ),
                                  ),
                                  10.widthBox,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        appointment['name'],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        '${appointment['caseType']}',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  3.widthBox,
                                ],
                              ),
                              10.heightBox,
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(() => CaseDetailScreen(
                                          name: appointment['name'],
                                          cnic: appointment['cnic'],
                                          time: appointment['time'],
                                          date: appointment['date'],
                                          caseType: appointment['caseType'],
                                          status: appointment['status'],
                                          caseId: appointment['caseId'],
                                        ));
                                  },
                                  child: Container(
                                    height: Get.height * .05,
                                    width: Get.width * .7,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.black26,
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Date Boxes',
                                        style: TextStyle(
                                          color: Color(0xFF848484),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          );
        }
      },
    );
  }
}

class CasesTab extends StatelessWidget {
  final String status;
  final Widget text;

  const CasesTab({super.key, required this.status, required this.text});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('appointments')
          .where('status', isEqualTo: status)
          .where('lawyerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView.builder(
                   itemCount: 4,
                   shrinkWrap: true,
                   itemBuilder: (context, index){
                     return Shimmer.fromColors(
                       baseColor: Colors.grey.shade300,
                       highlightColor: Colors.grey.shade100,
                       enabled: true,
                       child: Column(
                         children: [
                           ListTile(
                             leading:  Container(height: 50 , width: 50, color: Colors.white,),
                             title:  Container(
                               width: 100,
                               height: 8.0,
                               color: Colors.white,
                             ),
                             subtitle:  Container(
                               width: double.infinity,
                               height: 8.0,
                               color: Colors.white,
                             ),
                           ),

                         ],
                       ),
                     );
                   },

                  );

        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: 188),
            child: Text(
              'You have not any $status cases yet',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.amber.shade700),
            ),
          );
        } else {
          return Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length ?? 0,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final appointment = snapshot.data!.docs[index];

                  return Column(
                    children: [
                      const SizedBox(
                        height: 6,
                      ),
                      Card(
                        elevation: 12,
                        shadowColor: Colors.black,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 14),
                          width: Get.size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 28,
                                    backgroundImage: NetworkImage(
                                      appointment['image'],
                                    ),
                                  ),
                                  10.widthBox,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        appointment['name'],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        '${appointment['caseType']}',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  3.widthBox,
                                ],
                              ),
                              10.heightBox,
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(() => CaseDetailScreen(
                                          name: appointment['name'],
                                          cnic: appointment['cnic'],
                                          time: appointment['time'],
                                          date: appointment['date'],
                                          caseType: appointment['caseType'],
                                          status: appointment['status'],
                                          caseId: appointment['caseId'],
                                        ));
                                  },
                                  child: Container(
                                    height: Get.height * .05,
                                    width: Get.width * .7,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.black26,
                                      ),
                                    ),
                                    child: Center(child: text),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          );
        }
      },
    );
  }
}

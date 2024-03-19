import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.heightBox,
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Container(
                      height: 40,
                      width: 40,
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
                  const SizedBox(width: 20),
                  Text(
                    'You have an Unread',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              10.heightBox,
              const Divider(),
              ListTile(
                leading: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.notification_add,
                    color: Colors.amber,
                  ),
                ),
                title: Text(
                  'Upcoming event',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Stay tuned for upcoming Events',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF5B5B5B),
                    fontSize: 10,
                  ),
                ),
              ),
              ListTile(
                leading: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.work,
                    color: Colors.amber,
                  ),
                ),
                title: Text(
                  'Upcoming Appointment',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Stay tuned for upcoming Events',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF5B5B5B),
                    fontSize: 10,
                  ),
                ),
              ),
              ListTile(
                leading: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.message,
                    color: Colors.amber,
                  ),
                ),
                title: Text(
                  'New Mesaage',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'You have a unread message from abdul wahab ',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF5B5B5B),
                    fontSize: 10,
                  ),
                ),
              ),
              ListTile(
                leading: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.notification_add,
                    color: Colors.amber,
                  ),
                ),
                title: Text(
                  'View Appointment Request',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Stay tuned for upcoming Events',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF5B5B5B),
                    fontSize: 10,
                  ),
                ),
              ),
              ListTile(
                leading: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.notification_add,
                    color: Colors.amber,
                  ),
                ),
                title: Text(
                  'Reschedule Appointment',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Stay tuned for upcoming Events',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF5B5B5B),
                    fontSize: 10,
                  ),
                ),
              ),
              ListTile(
                leading: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.notification_add,
                    color: Colors.amber,
                  ),
                ),
                title: Text(
                  'Cancel Appointment',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Stay tuned for upcoming Events',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF5B5B5B),
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

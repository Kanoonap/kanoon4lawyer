// ignore_for_file: unused_field, deprecated_member_use

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanoon4lawyers/dashboard/cases/cases.dart';
import 'package:kanoon4lawyers/dashboard/chat/chats.dart';
import 'package:kanoon4lawyers/dashboard/home.dart';
import 'package:kanoon4lawyers/dashboard/profile/profile.dart';
import 'package:kanoon4lawyers/dashboard/schedule/schedule.dart';

import '../controllers/data_controller.dart';
import 'chat/notification.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0; // Current selected tab index
  LocalNotificationService localNotificationService=LocalNotificationService();
 @override
  void initState() {
    super.initState();
    Get.put(DataController(), permanent: true);

    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((message) {
      LocalNotificationService.display(message);
    });
  localNotificationService.requestNotificationPermission();
    localNotificationService.forgroundMessage();
    localNotificationService.firebaseInit(context);
    localNotificationService.setupInteractMessage(context);
    localNotificationService.isTokenRefresh();
    LocalNotificationService.storeToken();
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const Chats(),

    const ScheduleScreen(),
    const Cases(),
    const Profile(),
  ];
  void bottomNavBarClick(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
              size: 30,
            ),
            label: 'Home', // Set the label for the Chats icon
            backgroundColor: Colors.white,
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_rounded,
              size: 30,
            ),
            label: 'Chats', // Set the label for the Chats icon
            backgroundColor: Colors.white,
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_month,
              size: 30,
            ),
            label: 'Schedule',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/cases.png',
              width: 30,
              height: 30,
            ),
            label: 'Cases', 
            backgroundColor: Colors.white,
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_rounded,
              size: 30,
            ),
            backgroundColor: Colors.black,
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        elevation: 15,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: bottomNavBarClick,
      ),
    );
  }
}

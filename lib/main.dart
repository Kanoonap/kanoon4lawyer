import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanoon4lawyers/splash.dart';

import 'dashboard/chat/notification.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print(message.data.toString());
  }
  if (kDebugMode) {
    print(message.notification!.toString());
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  LocalNotificationService.initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kanoon4Lawyers',
      theme: ThemeData(
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          // useMaterial3: true,
          ),
      home: const SplashScreen(),
    );
  }
}

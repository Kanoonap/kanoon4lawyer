import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kanoon4lawyers/onboard_screens/onboarding_screen.dart';
import '../dashboard/dashboard.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Dashboard();
          } else {
            return const OnboardingScreens();
          }
        },
      ),
    );
  }
}

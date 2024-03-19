import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kanoon4lawyers/dashboard/dashboard.dart';
import 'package:velocity_x/velocity_x.dart';

class Verifying extends StatefulWidget {
  const Verifying({super.key});

  @override
  State<Verifying> createState() => _VerifyingState();
}

class _VerifyingState extends State<Verifying> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const Dashboard()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              160.heightBox,
              Center(
                child: Image.asset(
                  'assets/frame.png',
                  height: 63,
                  width: 63,
                ),
              ),
              const Text(
                'We are verifying',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                'Our also we will also status is',
                style: TextStyle(
                  color: Color(0xFF828A89),
                  fontSize: 16,
                ),
              ),
              288.heightBox,
              RichText(
                text: TextSpan(
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: const Color(0xFF828A89),
                  ),
                  children: const <TextSpan>[
                    TextSpan(
                      text:
                          'if your application status still pending. contact us at ',
                    ),
                    TextSpan(
                      text: 'support@medcure.com',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

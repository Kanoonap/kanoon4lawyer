
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanoon4lawyers/dashboard/dashboard.dart';
import 'package:pinput/pinput.dart';
import 'package:velocity_x/velocity_x.dart';

class ConfirmAmount extends StatefulWidget {
  const ConfirmAmount({super.key});

  @override
  State<ConfirmAmount> createState() => _ConfirmAmountState();
}

class _ConfirmAmountState extends State<ConfirmAmount> {
  // final List<TextEditingController> _otpControllers =
  //     List.generate(6, (_) => TextEditingController());
  bool loading = false;
  String code = '';
  bool isVerifying = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                20.heightBox,
                Row(
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
                    SizedBox(width: Get.width * .26),
                    const Text(
                      'Withdraw',
                      style: TextStyle(
                        color: Color(0xFF1A1A1A),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 28,
                ),
                const Text(
                  'OTP Authentication',
                  style: TextStyle(
                    color: Color(0xFF1A1A1A),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  'An authentication code has been sent to your email',
                  style: TextStyle(
                    color: Color(0xFF1A1A1A),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                34.heightBox,
                Pinput(
                  length: 6,
                  onChanged: (value) {
                    code = value;
                  },
                  showCursor: true,
                  onCompleted: (pin) => print(pin),
                ),
                const SizedBox(
                  height: 44,
                ),
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Didn’t receive the code? ',
                        style: TextStyle(
                          color: Color(0xFF707B81),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: 'Resent',
                        style: TextStyle(
                          color: Color(0xFFFFC100),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * .4),
                GestureDetector(
                  onTap: () {
                    showModal();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (_) => const Done()),
                    // );
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 55,
                        width: Get.size.width,
                        decoration: BoxDecoration(
                          color: loading ? Colors.grey : Colors.amber,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Center(
                          child: Visibility(
                            visible: !loading,
                            child: const Text(
                              'Confirm Code',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (loading)
                        const Positioned.fill(
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
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

  void showModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: double.infinity,
            height: 300,
            // decoration: BoxDecoration(
            //     color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/gtick.png',
                  height: 100,
                  width: 100,
                ), // Replace with your image URL
                const SizedBox(height: 10),
                const Text(
                  'Withdrawal Successfully!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Your Withdrawal is successful check your Notification to know more about appointment.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const Dashboard()));
      // Navigator.of(context).pop();
    });
  }
}

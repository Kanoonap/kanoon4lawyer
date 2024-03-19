import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanoon4lawyers/dashboard/wallet/amount_otp.dart';
import 'package:velocity_x/velocity_x.dart';

class AmountScreen extends StatefulWidget {
  const AmountScreen({super.key});

  @override
  State<AmountScreen> createState() => _AmountScreenState();
}

class _AmountScreenState extends State<AmountScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
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
                  height: 22,
                ),
                const Center(
                  child: Text(
                    'Enter Amount',
                    style: TextStyle(
                      color: Color(0xFF0C253F),
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(left: 18),
                    width: Get.width * .3,
                    child: TextFormField(
                      // controller: nameController,
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "RS30000PKR",
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter amount ';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () async {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const ConfirmAmount()));
          },
          child: Container(
            height: 45,
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'Withdraw',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

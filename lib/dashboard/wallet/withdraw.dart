import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanoon4lawyers/dashboard/wallet/amount.dart';
import 'package:velocity_x/velocity_x.dart';

class Withdraw extends StatefulWidget {
  const Withdraw({super.key});

  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  bool isSelected = false;
  TextEditingController cvvController = TextEditingController();
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
                    SizedBox(width: Get.width * .28),
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
                const Text(
                  'Account Name',
                  style: TextStyle(
                    color: Color(0xFF3D3D3D),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 9,
                ),
                TextFormField(
                  // controller: nameController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 15,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.black, // Change border color
                      ),
                    ),
                    hintText: "Abdul Wahab",
                    focusColor: Colors.green,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Card holder name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Card number',
                  style: TextStyle(
                    color: Color(0xFF3D3D3D),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 9,
                ),
                TextFormField(
                  // controller: nameController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 15,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.black, // Change border color
                      ),
                    ),
                    hintText: "1234 / 1234 / 1234",
                    focusColor: Colors.green,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your card number';
                    }
                    return null;
                  },
                ),
                14.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Expiry',
                          style: TextStyle(
                            color: Color(0xFF3D3D3D),
                            fontSize: 14,                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Container(
                          height: 45,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextFormField(
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 15,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.black, // Change border color
                                ),
                              ),
                              hintText: "16/05/2023",
                              focusColor: Colors.green,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.datetime,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your date';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'CW',
                          style: TextStyle(
                            color: Color(0xFF3D3D3D),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Container(
                          height: 45,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextFormField(
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 15,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.black, // Change border color
                                ),
                              ),
                              hintText: "150",
                              focusColor: Colors.green,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.datetime,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your date';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
focusColor: Colors.amber,                      value: isSelected,
                      onChanged: (value) {
                        isSelected = value!;
                      },
                    ),
                    const Text(
                      'save this for future',
                      style: TextStyle(
                        color: Color(0xFF828A89),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () async {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const AmountScreen()));
          },
          child: Container(
            height: 45,
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(12),
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

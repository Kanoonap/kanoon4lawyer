import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanoon4lawyers/dashboard/wallet/withdraw.dart';
import 'package:velocity_x/velocity_x.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    const Color defaultButtonColor = Colors.amber;
    const Color loadingButtonColor = Colors.grey;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,),
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
                    SizedBox(width: Get.width * .3),
                    const Text(
                      'Wallet',
                      textAlign: TextAlign.center,
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
                    'PKR 30,000',
                    style: TextStyle(
                      color: Color(0xFF0C253F),
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    'Your Balance',
                    style: TextStyle(
                      color: Color(0xFF0C253F),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                50.heightBox,
                const Text(
                  'Transaction History',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF1A1A1A),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'May 16,2023',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF353535),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                10.heightBox,
                10.heightBox,
                ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 7),
                      padding: const EdgeInsets.symmetric(horizontal: 11),
                      height: 77,
                      width: Get.size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/trans.png',
                                height: 55,
                                width: 55,
                                alignment: Alignment.centerLeft,
                              ),
                               10.widthBox,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Ahsan Khan',
                                style: TextStyle(
                                  color: Color(0xFF353535),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              10.heightBox,
                              const Text(
                                'Payment Received',
                                style: TextStyle(
                                  color: Color(0xFF9D9D9D),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                            ],
                          ),
                         
                       
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                '2:15 PM',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xFF9D9D9D),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              10.heightBox,
                              const Text(
                                'PKR2000',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xFF05AE03),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                10.heightBox,
                50.heightBox,
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const Withdraw()));
                      // showModal();

                      // if (!loading) {
                      //   if (_formKey.currentState!.validate()) {
                      //     setState(() {
                      //       loading = true;
                      //       isVerifying = true;
                      //     });
                      //     try {
                      //       await uploadImage();
                      //     } catch (e) {
                      //       print(e.toString());
                      //     } finally {
                      //       setState(() {
                      //         loading = false;
                      //       });
                      //     }
                      //   }
                      // }
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: loading
                                ? loadingButtonColor
                                : defaultButtonColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Visibility(
                              visible: !loading,
                              child: const Text(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

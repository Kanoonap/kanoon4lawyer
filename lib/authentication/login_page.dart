import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:kanoon4lawyers/authentication/otp_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import 'data_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String verify = '';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var phone = '';
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  // final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController phoneController = TextEditingController();
  Country selectedCountry = Country(
    phoneCode: '92',
    countryCode: 'PK',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'Pakistan',
    example: 'Pakistan',
    displayName: 'Pakistan',
    displayNameNoCountryCode: 'PK',
    e164Key: '',
  );

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color defaultButtonColor = Colors.amber;
    const Color loadingButtonColor = Colors.grey;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.heightBox,
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              20.heightBox,
              const Divider(
                color: Colors.grey,
                height: 0.5,
                thickness: 1,
              ),
              50.heightBox,
              const Text(
                'Login/Registration',
                style: TextStyle(
                  color: Color(0xFF1A1A1A),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              3.heightBox,
              Text(
                "Enter your phone number. We'll send you a verification code.",
                style: GoogleFonts.albertSans(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              36.heightBox,
              const Row(
                children: [
                  Text(
                    'Phone Number',
                    style: TextStyle(
                      color: Color(0xFF36454F),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.25,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5,),
              Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.only(left: 8),
                  height: 55,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                  child: InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {
                      if (kDebugMode) {
                        print(number.phoneNumber);
                      }
                    },
                    onInputValidated: (bool value) {
                      if (kDebugMode) {
                        print(value);
                      }
                    },
                    selectorConfig: const SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    ),
                    autoValidateMode: AutovalidateMode.disabled,
                    selectorTextStyle: const TextStyle(color: Colors.black),
                    textFieldController: phoneController,
                    formatInput: true,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    inputBorder: InputBorder.none,
                    onSaved: (PhoneNumber number) {
                      if (kDebugMode) {
                        print('On Saved: $number');
                      }
                    },
                  ),
                ),
              ),
              40.heightBox,
              GestureDetector(
                onTap: () async {
                  if (kDebugMode) {
                    print(phoneController.text + phone);
                  }
                  Get.to(() => const DataScreen());
                  if (phoneController.text.isNotEmpty) {
                    Fluttertoast.showToast(msg: 'Processing please wait...');
                    // setState(() {
                    //   loading = true;
                    // });

                    try {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: phoneController.text + phone,
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {
                          loading = false;
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Verification Failed'),
                              content:
                                  Text(e.message ?? 'Unknown error occurred.'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        },
                        codeSent: (String verificationId, int? resendToken) {
                          LoginPage.verify = verificationId;
                          Get.to(() => VerificationScreen(
                                phoneNumber: phoneController.text,
                              ));
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                    } catch (e) {
                      Get.snackbar('Enter phone number', '');
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter phone number'),
                      ),
                    );
                  }
                },
                child: Stack(
                  children: [
                    Container(
                      height: 49,
                      width: Get.size.width,
                      decoration: BoxDecoration(
                        color:
                            loading ? loadingButtonColor : defaultButtonColor,
                        borderRadius: BorderRadius.circular(12),
                        border: const Border(
                          bottom: BorderSide(color: Colors.white),
                          top: BorderSide(color: Colors.white),
                          left: BorderSide(color: Colors.white),
                          right: BorderSide(color: Colors.white),
                        ),
                      ),
                      child: Center(
                        child: Visibility(
                          visible: !loading,
                          child: Text(
                            'Login',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
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
    );
  }
}

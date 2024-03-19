import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kanoon4lawyers/authentication/signin_screen.dart';
import 'package:kanoon4lawyers/controllers/auth_controller.dart';
import 'package:kanoon4lawyers/controllers/profile_controller.dart';
import 'package:kanoon4lawyers/widgets/primary_textfield.dart';
import 'package:velocity_x/velocity_x.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  bool loading = false;
  bool _obscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  String imageaddress = "";
  String imagetoUpload = "";
  String imageUploaded = "";
  final practices = <String>[
    'Family matters',
    'Corporate buisness',
    'Immigration case',
    'Tax case'
  ];
  final _categories = <String>[
    'Criminal',
    'Family',
    'Labour',
    'Divorce',
    'Civil',
    'Military',
  ];
  String loadingMessage = "Registring User";

  String? _category;
  String? _practice;
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController specialController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController barController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  AuthController authController = Get.put(AuthController());
  ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                30.heightBox,
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    color: Color(0xFF3D3D3D),
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                const Text(
                  'Create Account',
                  style: TextStyle(
                    color: Color(0xFF3D3D3D),
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                const Text(
                  'Let’s create account toghter',
                  style: TextStyle(
                    color: Color(0xFF828A89),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                20.heightBox,
                Center(
                  child: Obx(
                    () => authController.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : GestureDetector(
                            onTap: () async {
                              authController.pickImage(context);
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  color:
                                      const Color.fromARGB(255, 231, 231, 231),
                                  image: authController.image == null
                                      ? const DecorationImage(
                                          image:
                                              AssetImage('assets/person.png'))
                                      : DecorationImage(
                                          image: FileImage(
                                            File(authController.image!.path)
                                                .absolute,
                                          ),
                                          fit: BoxFit.cover)),
                            ),
                          ),
                  ),
                ),
                20.heightBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Full Name',
                      style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PrimaryTextField(
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        controller: nameController,
                        text: 'Enter your name'),
                    10.heightBox,
                    const Text(
                      'Email',
                      style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PrimaryTextField(
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        controller: emailController,
                        text: 'Enter your email'),
                    10.heightBox,
                    const Text(
                      'Password',
                      style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PrimaryTextField(
                        obsecure: _obscurePassword,
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: _togglePasswordVisibility,
                        ),
                        prefixIcon: const Icon(
                          Icons.password,
                          color: Colors.black,
                        ),
                        controller: passwordController,
                        text: 'Enter your password'),
                    10.heightBox,
                    const Text(
                      'Contact',
                      style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PrimaryTextField(
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: Colors.black,
                        ),
                        controller: contactController,
                        text: 'Enter your contact'),
                    10.heightBox,
                    const Text(
                      'Address',
                      style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PrimaryTextField(
                        prefixIcon: const Icon(
                          Icons.location_pin,
                          color: Colors.black,
                        ),
                        controller: addressController,
                        text: 'Enter your address'),
                    10.heightBox,
                    const Text(
                      'Specialization',
                      style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.width * 0.030,
                        ),
                        filled: true,
                        fillColor: const Color(0xffEEEEEE),
                        prefixIcon:
                            const Icon(Icons.category, color: Colors.black),
                        hintText: 'Select Specialization',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                      value: _category,
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a category';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _category = value;
                        });
                      },
                      items: _categories
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ),
                          )
                          .toList(),
                    ),
                    10.heightBox,
                    const Text(
                      'Practice Area',
                      style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.width * 0.030,
                        ),
                        filled: true,
                        fillColor: const Color(0xffEEEEEE),
                        prefixIcon:
                            const Icon(Icons.category, color: Colors.black),
                        hintText: 'Select practice area',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                      value: _practice,
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a practice area';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _practice = value;
                        });
                      },
                      items: practices
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ),
                          )
                          .toList(),
                    ),
                    10.heightBox,
                    const Text(
                      'Bar Number',
                      style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PrimaryTextField(
                        prefixIcon: const Icon(
                          Icons.numbers,
                          color: Colors.black,
                        ),
                        controller: barController,
                        text: 'Enter your Bar Number'),
                    10.heightBox,
                    const Text(
                      'Date of Birth',
                      style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: dateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.width * 0.030,
                        ),
                      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.black45, 
          ),
        ), focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.black, 
          ),
        ),
                        hintText: "Date of Birth",
                        focusColor: Colors.black,
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        prefixIcon: const Icon(
                          Icons.calendar_today_rounded,
                          color: Colors.black,
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            dateController.text =
                                DateFormat('dd-MM-yyyy').format(pickedDate);
                          });
                        }
                      },
                    ),
                    10.heightBox,
                    const Text(
                      'Experience in years',
                      style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PrimaryTextField(
                        prefixIcon: const Icon(
                          Icons.numbers,
                          color: Colors.black,
                        ),
                        controller: experienceController,
                        text: 'Enter your experience'),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'Price per day',
                      style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PrimaryTextField(
                        prefixIcon: const Icon(
                          Icons.money,
                          color: Colors.black,
                        ),
                        controller: priceController,
                        text: 'Enter your price'),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'About',
                      style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PrimaryTextField(
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        controller: bioController,
                        text: 'Enter your bio'),
                    36.heightBox,
                    Center(
                      child: InkWell(
                        onTap: () async {
                          try {
                            String name = nameController.text.trim();
                            String email = emailController.text.trim();
                            String contact = contactController.text.trim();
                            String bar = barController.text.trim();
                            String date = dateController.text.trim();
                            String address = addressController.text.trim();
                            String password = passwordController.text.trim();
                            String bio = bioController.text.trim();
                            String price = priceController.text.trim();
                            String experience =
                                experienceController.text.trim();

                            if (name.isEmpty ||
                                authController.image == null ||
                                email.isEmpty ||
                                address.isEmpty ||
                                bar.isEmpty ||
                                price.isEmpty ||
                                date.isEmpty ||
                                bio.isEmpty ||
                                _categories.isEmpty ||
                                _practice == null ||
                                contact.isEmpty ||
                                experience.isEmpty ||
                                password.isEmpty) {
                              Get.snackbar(
                                "Error",
                                "Please enter all details",
                              );
                            } else {
                              profileController
                                  .uploadProfile(email, email, imagetoUpload)
                                  .then((value) => imagetoUpload = value);

                              await authController.signUpMethod(
                                  name: name,
                                  contact: contact,
                                  password: password,
                                  bar: bar,
                                  email: email,
                                  category: _category.toString(),
                                  address: address,
                                  bio: bio,
                                  practice: _practice.toString(),
                                  experience: experience,
                                  date: date,
                                  price: price,
                                  context: context);
                            }
                          } catch (e) {
                            Get.snackbar('Error', e.toString());
                          }
                        },
                        child: Container(
                          height: 45,
                          width: Get.size.width,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              'Create Account',
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
                  ],
                ),
                const SizedBox(
                  height: 19,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const SigninScreen());
                  },
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t have an account? ',
                        style: TextStyle(
                          color: Color(0xFF828A89),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Sign in',
                        style: TextStyle(
                          color: Color(0xFFFFC100),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/tick.png',
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 10),
                Text(
                  'You have successfully created your lawyer account on Kanoon App. Now complete your KYC to start attending cases.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    // Future.delayed(const Duration(seconds: 4), () {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (_) => const DegreeData()));
    // });
  }
}

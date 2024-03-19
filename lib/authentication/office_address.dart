import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanoon4lawyers/controllers/office_controller.dart';
import 'package:kanoon4lawyers/widgets/primary_textfield.dart';
import 'package:velocity_x/velocity_x.dart';

class OfficeAddress extends StatefulWidget {
  const OfficeAddress({super.key});

  @override
  State<OfficeAddress> createState() => _OfficeAddressState();
}

class _OfficeAddressState extends State<OfficeAddress> {
  TextEditingController addressController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  OfficeController officeController = Get.put(OfficeController());
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    // const Color defaultButtonColor = Colors.amber;
    // const Color loadingButtonColor = Colors.grey;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  ],
                ),
                40.heightBox,
                const Text(
                  'Add Office Address',
                  style: TextStyle(
                    color: Color(0xFF3D3D3D),
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                20.heightBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'First Name',
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
                        prefixIcon: const Icon(Icons.person),
                        controller: nameController,
                        text: 'Enter your name'),
                    10.heightBox,
                    const Text(
                      'Your Role',
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
                        prefixIcon: const Icon(Icons.category),
                        controller: roleController,
                        text: 'Enter your role'),
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
                        prefixIcon: const Icon(Icons.location_pin),
                        controller: addressController,
                        text: 'Enter your office address'),
                    50.heightBox,
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          if (nameController.text.isEmpty ||
                              roleController.text.isEmpty ||
                              addressController.text.isEmpty) {
                            Get.snackbar('Error', 'Please enter all details');
                          } else {
                            officeController.addOfficeAddress(
                              context,
                                roleController.text,
                                nameController.text,
                                addressController.text);
                          }
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: 50,
                              width: Get.size.width,
                              decoration: BoxDecoration(
                                color: loading ? Colors.grey : Colors.amber,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.white),
                              ),
                              child: Center(
                                child: Visibility(
                                  visible: !loading,
                                  child: const Text(
                                    'Submit',
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

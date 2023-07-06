import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/mycolor/mycolor.dart';

import '../../helper/CustomView/CustomView.dart';
import '../../medica_center/center_controller/CenterAuthController.dart';
import '../../signin_screen/SignInScreen.dart';

class MedicalCenterOtp extends StatefulWidget {
  // String name, email, phone, password, otp, code,healthcard;
  const MedicalCenterOtp({
    Key? key,
  }) : super(key: key);

  @override
  State<MedicalCenterOtp> createState() => _MedicalCenterOtpState();
}

class _MedicalCenterOtpState extends State<MedicalCenterOtp> {
  TextEditingController optctr = TextEditingController();
  CustomView custom = CustomView();
  CenterAuthCtr centerAuthCtr = CenterAuthCtr();
  var name = "";
  var email = "";
  var password = "";
  var apiotp = "";
  var address = "";
  var lat = "";
  var long = "";

  @override
  void initState() {
    super.initState();
    apiotp = Get.arguments;
    log("api otp$apiotp");
    print(email);
    print(password);
    name = Get.parameters['name']!;
    email = Get.parameters['email']!;
    password = Get.parameters['password']!;
    address = Get.parameters['address']!;
    lat = Get.parameters['lat']!;
    long = Get.parameters['long']!;

  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: height * 0.09),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Align(
                    alignment: Alignment.topLeft,
                    child: Icon(Icons.arrow_back_ios),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                custom.text("Verification", 23, FontWeight.w700, MyColor.black),
                SizedBox(height: height * 0.02),
                custom.text(
                    "We need to verificate your email to create your account. Please enter OTP number, we sent it on your email account.",
                    12,
                    FontWeight.normal,
                    MyColor.primary1),
                SizedBox(height: height * 0.07),
                Align(
                  alignment: Alignment.topLeft,
                  child: custom.text("Enter OTP number", 13, FontWeight.w600,
                      MyColor.primary1),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                custom.myField(context, optctr, "Enter 4 characters",
                    TextInputType.emailAddress),
                SizedBox(
                  height: height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    custom.text("Not received??", 11, FontWeight.w500,
                        MyColor.primary1),
                    GestureDetector(
                      onTap: () {
                        centerAuthCtr.CenterSignupOtp(context, email);
                      },
                      child: const Text(
                        "Send a new OTP number",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: MyColor.primary1,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.33,
                ),
                Obx(() {
                  if (centerAuthCtr.loading.value) {
                    return custom.MyIndicator();
                  }
                  return custom.MyButton(context, "Verificate", () {
                    if (validationotp()) {
                      centerAuthCtr.centerSignup(
                          context,
                          name,
                          email,
                          password,
                          address,
                          lat,
                          long,
                          () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInScreen()));
                      });
                      /*   patientSignUpCtr.patientSignup(context, name,surname,username, email, code, phone, password, healthCode,age,weight,birthPlace,heightp, () {

                      });*/
                    }

                  },
                      MyColor.primary,
                      const TextStyle(
                          fontSize: 16,
                          color: MyColor.white,
                          fontFamily: "Poppins"));
                }),
                SizedBox(
                  height: height * 0.03,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validationotp() {
    print("api otp${apiotp.toString()}");
    print("my otp${optctr.text.toString()}");
    if (optctr.text.isEmpty || optctr.text.length != 4) {
      custom.massenger(context, "Please enter OTP");
    } else if (apiotp == optctr.text) {
      print("Correct OTP");
      // custom.massenger(context, "SignUp Successfully");
      return true;
    } else {
      custom.massenger(context, "invalid otp");
      return false;
    }
    return false;
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/mycolor/mycolor.dart';

import '../../helper/CustomView/CustomView.dart';
import '../../patient_screens/controller/auth_controllers/PatientSignUpController.dart';
import '../../signin_screen/SignInScreen.dart';

class PatientSignUpOtp extends StatefulWidget {
  // String name, email, phone, password, otp, code,healthcard;
  const PatientSignUpOtp({
    Key? key,
  }) : super(key: key);

  @override
  State<PatientSignUpOtp> createState() => _PatientSignUpOtpState();
}

class _PatientSignUpOtpState extends State<PatientSignUpOtp> {
  TextEditingController optctr = TextEditingController();
  CustomView custom = CustomView();
  PatientSignUpCtr patientSignUpCtr = PatientSignUpCtr();
  var name = "";
  var surname = "";
  var username = "";
  var email = "";
  var healthCode = "";
  var phone = "";
  var password = "";
  var code = "";
  var apiotp = "";
  var taxCode = "";
  var heightp = "";
  var weight = "";
  var birthPlace = "";
  var age = "";
  var gender = "";
var flag ="";
  @override
  void initState() {
    super.initState();
    apiotp = Get.arguments;
    log(apiotp);
    print(username);
    print(email);
    print(password);
    print(code);
    print(healthCode);
    gender = Get.parameters["gender"].toString();
    name = Get.parameters['name']!;
    surname = Get.parameters['surname']!;
    username = Get.parameters['username']!;
    email = Get.parameters['email']!;
    phone = Get.parameters['phone']!;
    healthCode = Get.parameters['healthcard']!;
    password = Get.parameters['password']!;
    code = Get.parameters['code']!;
    heightp = Get.parameters['height']!;
    weight = Get.parameters['weight']!;
    taxCode = Get.parameters['tax']!;
    age = Get.parameters['age']!;
    flag = Get.parameters['flag']!;

    birthPlace = Get.parameters['birthPlace']!;
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
                 Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(onTap: () {
                    Get.back();
                  },child: const Icon(Icons.arrow_back_ios)),
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
                        patientSignUpCtr.PatientSignupOtp(context, email);
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
                  if (patientSignUpCtr.loading.value) {
                    return custom.MyIndicator();
                  }
                  return custom.MyButton(context, "Verificate", () {
                    if (validationotp()) {
                      patientSignUpCtr.patientSignup(
                          context,
                          name,
                          surname,
                          username,
                          email,
                          code,
                          phone,
                          flag,
                          password,
                          healthCode,
                          age,
                          weight,
                          birthPlace,
                          heightp,
                          taxCode,
                          gender, () {
                        custom.massenger(context, "SignUp Successfully");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInScreen()));
                      });
                      /*   patientSignUpCtr.patientSignup(context, name,surname,username, email, code, phone, password, healthCode,age,weight,birthPlace,heightp, () {
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => const SignInScreen()));
                      });*/
                    }
                    // Get.toNamed(RouteHelper.getSetPassword());
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
      return true;
    } else {
      custom.massenger(context, "invalid otp");
      return false;
    }
    return false;
  }
}

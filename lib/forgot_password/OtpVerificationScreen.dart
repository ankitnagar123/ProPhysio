import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/Helper/RoutHelper/RoutHelper.dart';
import 'package:medica/forgot_password/forgot_pass_controller/ForgotPassController.dart';
import 'package:medica/helper/mycolor/mycolor.dart';

import '../helper/CustomView/CustomView.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  TextEditingController optctr = TextEditingController();
  ForgotPassCtr forgotPassCtr = ForgotPassCtr();
  var apiotp = "";
  var iD = '';
  var email = "";

  @override
  void initState() {
    iD = Get.parameters["id"]!;
    email = Get.parameters["email"]!;
    log("my email$email");
    apiotp = Get.arguments;
    print(" otp is here$apiotp");
    // TODO: implement initState
    super.initState();
  }

  CustomView custom = CustomView();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: custom.MyButton(context, "Submit", () {
          if (validationotp()) {
            var id = {
              "id": iD,
            };
            Get.toNamed(RouteHelper.getSetPassword(), parameters: id);
          } else {}
        },
            MyColor.primary,
            const TextStyle(
                fontSize: 18, color: MyColor.white, fontFamily: "Poppins")),
        body: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: height * 0.09),
                 Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },child: const Icon(Icons.arrow_back_ios)),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                custom.text(
                    "Forgot password", 23, FontWeight.w700, MyColor.black),
                SizedBox(height: height * 0.02),
                custom.text(
                    "Forgot your password? Please enter OTP number, we sent it on your email account.  Then you can set a new one.",
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
                custom.myField(
                    context, optctr, "Enter OTP", TextInputType.emailAddress),
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
                          forgotPassCtr
                              .forgotPassword(
                            context,
                            email,
                          )
                              .then((value) {
                            if (value != "") {
                              print("object$value");
                              apiotp = value;
                              // var id = {"id": forgotPassCtr.id.value,"email":emailCtr.text};
                              // Get.toNamed(RouteHelper.getVerification(),
                              //     arguments: value, parameters: id);
                            }
                          });
                        },
                        child: const Text(
                          "Send a new OTP number",
                          style: TextStyle(
                            color: MyColor.primary1,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        )),
                    SizedBox(
                      height: height * 0.01,
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.33,
                ),
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
      custom.massenger(context, "Set a new password");
      return true;
    } else {
      custom.massenger(context, "invalid otp");
      return false;
    }
    return false;
  }
}

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Helper/RoutHelper/RoutHelper.dart';
import '../helper/CustomView/CustomView.dart';
import '../helper/mycolor/mycolor.dart';
import '../language_translator/LanguageTranslate.dart';
import 'forgot_pass_controller/ForgotPassController.dart';

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
  var countryCode = "";
  var phoneNo = "";
  var userType = "";
  LocalString text = LocalString();


  Timer? _timer; // Initialize with null
  int _resendOtpTimer = 60; // Initial timer value in seconds
  bool _canResendOtp = true;

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  void _startResendOtpTimer() {
    setState(() {
      _canResendOtp = false; // Disable the button
      _resendOtpTimer = 60; // Reset timer
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendOtpTimer > 0) {
          _resendOtpTimer--; // Decrease timer value
        } else {
          _canResendOtp = true; // Enable the button when timer reaches 0
          _timer?.cancel(); // Cancel the timer
        }
      });
    });
  }


  @override
  void initState() {
    super.initState();
    userType = forgotPassCtr.userTyp.value.toString();
    apiotp = forgotPassCtr.otp.value.toString();
    log("API OTP$apiotp");
log(userType);
    // apiotp = Get.arguments;
    // print(" otp is here$apiotp");
    countryCode = Get.parameters["code"].toString();
    log(countryCode);
    phoneNo = Get.parameters["phone"].toString();
    log(phoneNo);
    iD = Get.parameters["id"].toString();
    userType = Get.parameters["userType"].toString();

    // email = Get.parameters["email"].toString();
    // log("my email$email");
    forgotPassCtr.forgotPassOtp(context, countryCode, phoneNo, "", userType);
  }

  CustomView custom = CustomView();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(11),
        child: custom.MyButton(context, text.Submit.tr, () {
          if (validationotp()) {
            var id = {
              "id": iD,
              "userType":userType,
            };
            Get.toNamed(RouteHelper.getSetPassword(), parameters: id);
          } else {}
        },
            MyColor.red,
            const TextStyle(
                fontSize: 18, color: MyColor.white, fontFamily: "Poppins")),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: height * 0.02),
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
                    text.forgot_Password.tr, 22, FontWeight.w500, MyColor.black),
                SizedBox(height: height * 0.02),
                custom.text(
                    text.forgot_line_otp.tr,
                    12,
                    FontWeight.normal,
                    MyColor.primary1),
                SizedBox(height: height * 0.07),
                Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(text.Enter_otp.tr, 13, FontWeight.w600,
                      MyColor.primary1),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                custom.myField(
                    context, optctr, text.Enter_otp.tr, TextInputType.number),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    custom.text(text.Not_recived.tr, 11, FontWeight.w500,
                        MyColor.primary1),
                    GestureDetector(
                        onTap: _canResendOtp
                            ? () {
                          // Call your function to send OTP
                          forgotPassCtr.forgotPassOtp(context, countryCode, phoneNo, "", userType);
                          // Start the resend OTP timer
                          _startResendOtpTimer();
                        }
                            : null, // Disable button if timer is active
                        child: _canResendOtp?  Text(
                          '${text.SendNewOtp.tr}',
                          style: TextStyle(
                            color: MyColor.primary1,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ): Text(
                          ' Resend OTP in $_resendOtpTimer',
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
    if (optctr.text.isEmpty) {
      custom.massenger(context, text.Enter_otp.tr);
    } else if (forgotPassCtr.otp.value == optctr.text) {
      print("Correct OTP");
      custom.massenger(context, text.SetPassword.tr);
      return true;
    } else {
      custom.massenger(context, text.invalid_otp.tr);
      return false;
    }
    return false;
  }
}

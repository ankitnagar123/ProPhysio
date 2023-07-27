import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/doctor_screens/controller/DoctorSignUpController.dart';
import 'package:medica/helper/mycolor/mycolor.dart';

import '../../Helper/RoutHelper/RoutHelper.dart';
import '../../helper/CustomView/CustomView.dart';
import '../../language_translator/LanguageTranslate.dart';

class DoctorSignUpOtp extends StatefulWidget {
  const DoctorSignUpOtp({Key? key}) : super(key: key);

  @override
  State<DoctorSignUpOtp> createState() => _DoctorSignUpOtpState();
}

class _DoctorSignUpOtpState extends State<DoctorSignUpOtp> {
  DoctorSignUpCtr doctorSignUpCtr = DoctorSignUpCtr();
LocalString text = LocalString();

  late Timer _timer;
  int _countdownSeconds = 60;
  bool _timerRunning = false;

  void _startTimer() {
    if (!_timerRunning) {
      _timerRunning = true;
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (_countdownSeconds > 0) {
            _countdownSeconds--;
          } else {
            _stopTimer();
          }
        });
      });
    }
  }

  void _stopTimer() {
    if (_timerRunning) {
      _timerRunning = false;
      _timer.cancel();
    }
  }

  void _handleResendOtp() {
    doctorSignUpCtr.doctorSignupOtp(context, code,phoneno,email);
    // Replace this with your logic to resend OTP
    // For demonstration, we'll just print a message here
    print('Resending OTP...');
    _startTimer();
  }

  void _handleButtonPress() {
    if (!_timerRunning) {
      _handleResendOtp();
    }
  }

  @override
  void dispose() {
    _stopTimer(); // Cancel the timer when the widget is disposed
    super.dispose();
  }



  var name = "";
  var surname = "";
  var username = "";
  var email = "";
  var phoneno = "";
  var password = "";
  var category = "";
  var imagename = "";
  var imagebase = "";
  var address = "";
  var code = "";
  var lat = "";
  var long = "";
  var subcat = "";
  var birthDate = "";
  var birthPlace = "";
  var universityAttended = "";
  var dateOfEnrol = "";
  var registerOfBelonging = "";
  var gender = "";
  var graduationDate = "";
  var qualificationDate = "";
  var flag = "";

  @override
  void initState() {
    super.initState();

    gender = Get.parameters["gender"].toString();
    subcat = Get.parameters["subcat"].toString();
    category = Get.parameters["category"].toString();
    print("doctor selcet category$category");
    name = Get.parameters["name"].toString();
    surname = Get.parameters["surmane"].toString();
    username = Get.parameters["username"].toString();
    email = Get.parameters["email"].toString();
    phoneno = Get.parameters["phone"].toString();
    password = Get.parameters["password"].toString();
    // category = Get.parameters["category"]!;
    imagename = Get.parameters["imagename"].toString();
    imagebase = Get.parameters["imagebase"].toString();
    address = Get.parameters["address"].toString();
    code = Get.parameters["code"].toString();
    lat = Get.parameters["lat"].toString();
    long = Get.parameters["longitude"].toString();

    birthDate = Get.parameters["birthDate"].toString();
    birthPlace = Get.parameters["birthPlace"].toString();
    universityAttended = Get.parameters["universityAttended"].toString();
    dateOfEnrol = Get.parameters["dateOfEnrol"].toString();
    registerOfBelonging = Get.parameters["registerOfBelonging"].toString();

    graduationDate = Get.parameters["graduationDate"].toString();
    qualificationDate = Get.parameters["qualificationDate"].toString();
    flag = Get.parameters["flag"].toString();

    /*OTP  API*/
    doctorSignUpCtr.doctorSignupOtp(context, code,phoneno,email);

  }

  TextEditingController optctr = TextEditingController();

  CustomView custom = CustomView();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Obx(() {
            if (doctorSignUpCtr.loading.value) {
              return custom.MyIndicator();
            }
            return custom.MyButton(context, text.Verification.tr, () {
              if (validationotp()) {
                doctorSignUpCtr.doctorSignup(
                    context,
                    name,
                    surname,
                    username,
                    email,
                    code,
                    phoneno,
                    flag,
                    password,
                    category,
                    imagename,
                    imagebase,
                    address,
                    lat,
                    long,
                    subcat,
                    birthDate,
                    birthPlace,
                    universityAttended,
                    dateOfEnrol,
                    registerOfBelonging,
                    gender,
                    graduationDate,
                    qualificationDate, () {
                  Get.offAllNamed(RouteHelper.getLoginScreen());
                });
              }
            },
                MyColor.primary,
                const TextStyle(
                    fontSize: 16, color: MyColor.white, fontFamily: "Poppins"));
          }),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: height * 0.09),
                 Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.arrow_back_ios)),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                custom.text(text.Verification.tr, 23, FontWeight.w700, MyColor.black),
                SizedBox(height: height * 0.02),
                custom.text(
                    text.SignupOtpVerifiy.tr,
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
                custom.myField(context, optctr, text.Enter_6_characters.tr,
                    TextInputType.emailAddress),
                SizedBox(
                  height: height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    custom.text(text.Not_recived.tr, 11, FontWeight.w500,
                        MyColor.primary1),
                    GestureDetector(
                      onTap: () {
                        _timerRunning ? null :_handleButtonPress();
                      },
                      child:  Text(
                        _countdownSeconds > 0 ? '${text.Resend_OTP_in.tr} $_countdownSeconds ${text.seconds.tr}' : text.SendNewOtp.tr,
                        style: const TextStyle(
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
    print("my otp${optctr.text.toString()}");
    if (optctr.text.isEmpty) {
      custom.massenger(context, text.Please_enter_OTP.tr);
    } else if (doctorSignUpCtr.otp.value == optctr.text) {
      print("Correct OTP");
      return true;
    } else {
      custom.massenger(context,  text.Invalid.tr);
      return false;
    }
    return false;
  }
}

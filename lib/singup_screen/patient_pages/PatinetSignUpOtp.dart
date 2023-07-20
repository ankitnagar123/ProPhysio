import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/mycolor/mycolor.dart';
import '../../Helper/RoutHelper/RoutHelper.dart';
import '../../helper/CustomView/CustomView.dart';
import '../../language_translator/LanguageTranslate.dart';
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
  late Timer _timer;
  int _countdownSeconds = 60;
  bool _timerRunning = false;
LocalString text = LocalString();
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
    patientSignUpCtr.PatientSignupOtp(context, code,phone,email);
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

    gender = Get.parameters["gender"].toString();
    log(gender);
    name = Get.parameters['name'].toString();
    surname = Get.parameters['surname'].toString();
    username = Get.parameters['username'].toString();
    email = Get.parameters['email'].toString();
    phone = Get.parameters['phone'].toString();
    healthCode = Get.parameters['healthcard'].toString();
    password = Get.parameters['password'].toString();
    code = Get.parameters['code'].toString();
    heightp = Get.parameters['height'].toString();
    weight = Get.parameters['weight'].toString();
    taxCode = Get.parameters['tax'].toString();
    age = Get.parameters['age'].toString();
    flag = Get.parameters['flag'].toString();
    birthPlace = Get.parameters['birthPlace'].toString();
    print(username);
    print(email);
    print(password);
    print(code);
    print(healthCode);
    patientSignUpCtr.PatientSignupOtp(context,code,phone,email,);

  }
  @override
  void dispose() {
    _stopTimer(); // Cancel the timer when the widget is disposed
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
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
                custom.myField(context, optctr,text.Enter_6_characters.tr,
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
                Obx(() {
                  if (patientSignUpCtr.loading.value) {
                    return custom.MyIndicator();
                  }
                  return custom.MyButton(context, text.Verification.tr, () {
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
                        custom.massenger(context, text.SignUPSuccess.tr);
                        Get.offAllNamed(RouteHelper.getLoginScreen());
                       /* Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInScreen()));*/
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

    print("api otp${patientSignUpCtr.otp.value.toString()}");
    print("my otp${optctr.text.toString()}");
    if (optctr.text.isEmpty || optctr.text.length != 6) {
      custom.massenger(context, text.Please_enter_OTP.tr);
    } else if (patientSignUpCtr.otp.value == optctr.text) {
      print("Correct OTP");
      return true;
    } else {
      custom.massenger(context, text.Invalid.tr);
      return false;
    }
    return false;
  }
}

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Helper/RoutHelper/RoutHelper.dart';
import '../../helper/CustomView/CustomView.dart';
import '../../helper/mycolor/mycolor.dart';
import '../../language_translator/LanguageTranslate.dart';
import '../../patient_screens/controller/auth_controllers/PatientSignUpController.dart';

class PatientSignUpOtp extends StatefulWidget {
  const PatientSignUpOtp({
    super.key,
  });

  @override
  State<PatientSignUpOtp> createState() => _PatientSignUpOtpState();
}

class _PatientSignUpOtpState extends State<PatientSignUpOtp> {
  LocalString text = LocalString();

  late Timer _timer;
  int _countdownSeconds = 60;
  bool _timerRunning = false;

  TextEditingController optctr = TextEditingController();
  CustomView custom = CustomView();
  PatientSignUpCtr patientSignUpCtr = PatientSignUpCtr();
  var title = "";
  var name = "";
  var surname = "";
  var email = "";
  var phone = "";
  var password = "";
  var code = "";
  var taxCode = "";
  var heightp = "";
  var weight = "";
  var birthPlace = "";
  var age = "";
  var gender = "";
  var flag = "";
  var dob = "";
  var branchId = "";
  var heights = "";

  /*---------------NEW Variable--------------*/
  /*-----Identification Document-------*/
  var idType = "";
  var idNumber = "";

  /*-----kin-------*/
  var kinName = "";
  var kinContact = "";

  /*-----Home Address-------*/
  var homeTitle1 = "";
  var homeTitle2 = "";
  var homeAddress = "";
  var homeState = "";
  var homePostalCode = "";
  var homeCountry = "";
  var homePhone = "";

  /*-----Office Address-------*/
  var officeTitle1 = "";
  var officeTitle2 = "";
  var employmentStatus = "";
  var occupation = "";
  var employer = "";
  var officeAddress = "";
  var officeState = "";
  var officePostalCode = "";
  var officeCountry = "";
  var officePhone = "";

  /*-----Medical Doctor INfo-------*/

  var medicalTitle1 = "";
  var medicalTitle2 = "";
  var medicalName = "";
  var medicalPracticeName = "";
  var medicalAddress = "";
  var medicalState = "";
  var medicalPostalCode = "";
  var medicalCountry = "";
  var medicalPhone = "";

  var aboutUs = "";

  @override
  void initState() {
    super.initState();
    gender = Get.parameters["gender"].toString();
    log(gender);
    name = Get.parameters['name'].toString();
    surname = Get.parameters['surname'].toString();
    email = Get.parameters['email'].toString();
    phone = Get.parameters['phone'].toString();
    code = Get.parameters['code'].toString();
    password = Get.parameters['password'].toString();
    heightp = Get.parameters['height'].toString();
    weight = Get.parameters['weight'].toString();
    taxCode = Get.parameters['tax'].toString();
    age = Get.parameters['age'].toString();
    flag = Get.parameters['flag'].toString();
    dob = Get.parameters['dob'].toString();
    birthPlace = Get.parameters['birthPlace'].toString();
    heights = Get.parameters['height'].toString();
    branchId = Get.parameters['branchId'].toString();
    log(email);
    log(password);
    log(code);

    /*--------------------NEW FILED--------------*/
    /*-----Identification Document-------*/

    idType = Get.parameters['idType'].toString();
    idNumber = Get.parameters['idNumber'].toString();
    /*-----kin-------*/
    kinName = Get.parameters['kinName'].toString();
    kinContact = Get.parameters['kinContact'].toString();
    /*-----Home Address-------*/
    homeTitle1 = Get.parameters['homeTitle1'].toString();
    homeTitle2 = Get.parameters['homeTitle2'].toString();
    homeAddress = Get.parameters['homeAddress'].toString();
    homeState = Get.parameters['homeState'].toString();
    homePostalCode = Get.parameters['homePostalCode'].toString();
    homeCountry = Get.parameters['homeCountry'].toString();
    homePhone = Get.parameters['homePhone'].toString();
    /*-----Office Address-------*/
    officeTitle1 = Get.parameters['officeTitle1'].toString();
    officeTitle2 = Get.parameters['officeTitle2'].toString();
    employmentStatus = Get.parameters['employmentStatus'].toString();
    occupation = Get.parameters['occupation'].toString();
    employer = Get.parameters['employer'].toString();
    officeAddress = Get.parameters['officeAddress'].toString();
    officeState = Get.parameters['officeState'].toString();
    officePostalCode = Get.parameters['officePostalCode'].toString();
    officeCountry = Get.parameters['officeCountry'].toString();
    officePhone = Get.parameters['officePhone'].toString();
    /*-----Medical Doctor INfo-------*/
    medicalTitle1 = Get.parameters['medicalTitle1'].toString();
    medicalTitle2 = Get.parameters['medicalTitle2'].toString();
    medicalName = Get.parameters['medicalName'].toString();
    medicalPracticeName = Get.parameters['medicalPracticeName'].toString();
    medicalAddress = Get.parameters['medicalAddress'].toString();
    medicalState = Get.parameters['medicalState'].toString();
    medicalPostalCode = Get.parameters['medicalPostalCode'].toString();
    medicalCountry = Get.parameters['medicalCountry'].toString();
    medicalPhone = Get.parameters['medicalPhone'].toString();
    title = Get.parameters['title'].toString();

    aboutUs = Get.parameters['aboutUs'].toString();

    /*otp api call------*/
    patientSignUpCtr.PatientSignupOtp(
      context,
      code,
      phone,
      email,
    );
  }

  void _startTimer() {
    if (!_timerRunning) {
      _timerRunning = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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
    patientSignUpCtr.PatientSignupOtp(context, code, phone, email);
    // Replace this with your logic to resend OTP
    // For demonstration, we'll just print a message here
    log('Resending OTP...');
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
                  child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(Icons.arrow_back_ios)),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                custom.text(
                    text.Verification.tr, 23, FontWeight.w700, MyColor.black),
                SizedBox(height: height * 0.02),
                custom.text(text.SignupOtpVerifiy.tr, 12, FontWeight.normal,
                    MyColor.primary1),
                SizedBox(height: height * 0.07),
                Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(
                      text.Enter_otp.tr, 13, FontWeight.w600, MyColor.primary1),
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
                        _timerRunning ? null : _handleButtonPress();
                      },
                      child: Text(
                        _countdownSeconds > 0
                            ? '${text.Resend_OTP_in.tr} $_countdownSeconds ${text.seconds.tr}'
                            : text.SendNewOtp.tr,
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
                          title,
                          name,
                          surname,
                          email,
                          code,
                          phone,
                          flag,
                          password,
                          age,
                          weight,
                          birthPlace,
                          heights,
                          taxCode,
                          gender,
                          dob,
                          branchId,
                          idType,
                          idNumber,
                          kinName,
                          kinContact,
                          homeTitle1,
                          homeTitle2,
                          homeAddress,
                          homeState,
                          homePostalCode,
                          homeCountry,
                          homePhone,
                          officeTitle1,
                          officeTitle2,
                          employmentStatus,
                          occupation,
                          employer,
                          officeAddress,
                          officeState,
                          officePostalCode,
                          officeCountry,
                          officePhone,
                          medicalTitle1,
                          medicalTitle2,
                          medicalName,
                          medicalPracticeName,
                          medicalAddress,
                          medicalState,
                          medicalPostalCode,
                          medicalCountry,
                          medicalPhone,
                          aboutUs,
                          () {
                            custom.massenger(context, text.SignUPSuccess.tr);
                            Get.offAllNamed(RouteHelper.getLoginScreen());
                          });
                    }
                    // Get.toNamed(RouteHelper.getSetPassword());
                  },
                      MyColor.red,
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

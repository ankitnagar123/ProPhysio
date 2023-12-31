import 'dart:developer';

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
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: custom.MyButton(context, text.Submit.tr, () {
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
                    text.forgot_Password.tr, 23, FontWeight.w700, MyColor.black),
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
                    context, optctr, text.Enter_otp.tr, TextInputType.emailAddress),
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
           /*               forgotPassCtr
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
                          });*/
                        },
                        child:  Text(
                          text.SendNewOtp.tr,
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

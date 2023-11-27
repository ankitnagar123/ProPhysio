
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Helper/RoutHelper/RoutHelper.dart';
import '../../helper/CustomView/CustomView.dart';
import '../../helper/mycolor/mycolor.dart';
import '../../language_translator/LanguageTranslate.dart';
import '../../medica_center/center_controller/CenterAuthController.dart';

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
  LocalString text = LocalString();
  CenterAuthCtr centerAuthCtr = CenterAuthCtr();
  var name = "";
  var email = "";
  var password = "";
  var address = "";
  var lat = "";
  var long = "";
  var code = "";
  var phone = "";
  var flag = "";

  @override
  void initState() {
    super.initState();
    print(email);
    print(password);
    name = Get.parameters['name'].toString();
    email = Get.parameters['email'].toString();
    password = Get.parameters['password'].toString();
    address = Get.parameters['address'].toString();
    lat = Get.parameters['lat'].toString();
    long = Get.parameters['long'].toString();
    print("otp side lat long${lat+long}");
    code = Get.parameters["code"].toString();
    flag = Get.parameters['flag'].toString();
    phone = Get.parameters['phone'].toString();
    print(code);
    print(phone);
    print(email);
    /*OTP API CALL*/
    centerAuthCtr.CenterSignupOtp(
        context, code, phone, email);
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
                        centerAuthCtr.CenterSignupOtp(
                            context, code, phone, email);
                      },
                      child: Text(
                        text.SendNewOtp.tr,
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
                  if (centerAuthCtr.loading.value) {
                    return custom.MyIndicator();
                  }
                  return custom.MyButton(context, text.Verification.tr, () {
                    if (validationotp()) {
                      centerAuthCtr.centerSignup(context, flag, code, phone,
                          name, email, password, address, lat, long, () {
                        Get.offAllNamed(RouteHelper.getLoginScreen());
                      });
                      /*   patientSignUpCtr.pa tientSignup(context, name,surname,username, email, code, phone, password, healthCode,age,weight,birthPlace,heightp, () {

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
    print("my otp${optctr.text.toString()}");
    if (optctr.text.isEmpty || optctr.text.length != 6) {
      custom.massenger(context, text.Please_enter_OTP.tr);
    } else if (centerAuthCtr.otp.value == optctr.text) {
      print("Correct OTP");
      // custom.massenger(context, "SignUp Successfully");
      return true;
    } else {
      custom.massenger(context, text.Invalid.tr);
      return false;
    }
    return false;
  }
}

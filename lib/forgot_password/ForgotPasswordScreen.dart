import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/Helper/RoutHelper/RoutHelper.dart';
import 'package:medica/forgot_password/forgot_pass_controller/ForgotPassController.dart';
import 'package:medica/helper/mycolor/mycolor.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../helper/CustomView/CustomView.dart';
import '../language_translator/LanguageTranslate.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailCtr = TextEditingController();
  TextEditingController phoneCtr = TextEditingController();

  ForgotPassCtr forgotPassCtr = ForgotPassCtr();

  CustomView custom = CustomView();
  LocalString text = LocalString();
  String code = '';
  String flag = '';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery
        .of(context)
        .size
        .width;
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
                      },child: const Icon(Icons.close_outlined)),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                custom.text(
                    text.forgot_Password.tr, 23, FontWeight.w700, MyColor.black),
                const Divider(),
                SizedBox(height: height * 0.02),
                custom.text(
                    text.forgot_line.tr,
                    12,
                    FontWeight.normal,
                    MyColor.primary1),
                SizedBox(height: height * 0.06),
                Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(text.Phone_Number.tr, 13, FontWeight.w500,
                      MyColor.primary1),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                SizedBox(
                  height: 50,
                  width: widht * 1,
                  child: IntlPhoneField(
                    controller: phoneCtr,
                    decoration:  InputDecoration(
                      // focusedErrorBorder: InputBorder.none,
                      counterText: '',
                      filled: true,
                      fillColor: Colors.white,
                      constraints: BoxConstraints.expand(),
                      labelText: text.Phone_Number.tr,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                    initialCountryCode: flag,
                    onChanged: (phone) {
                      // var flag = phone.countryISOCode;
                      flag = phone.countryISOCode;
                      print(flag);
                      code = phone.countryCode;
                      print(phone.completeNumber);
                    },
                    onCountryChanged: (cod) {
                      flag = cod.code;
                      print(flag);
                      code = cod.code;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                SizedBox(
                  height: height * 0.30,
                ),
                Obx(() {
                  if (forgotPassCtr.loadingotp.value) {
                    return custom.MyIndicator();
                  }
                  return custom.MyButton(context, text.Submit.tr, () {
                    if (validation()) {
                      forgotPassCtr.forgotPasswordVerification(context, code,phoneCtr.text,() {
                        var id = {"id": forgotPassCtr.id.value,"code":code,"phone":phoneCtr.text};
                        Get.toNamed(RouteHelper.getVerification(),parameters: id);
                      },);
                    }

                    /*   if (validation()) {

                      forgotPassCtr.forgotPassword(context, emailCtr.text,)
                          .then((value) {
                        if (value != "") {
                          var id = {"id": forgotPassCtr.id.value,"email":emailCtr.text};
                          Get.toNamed(RouteHelper.getVerification(),
                              arguments: value, parameters: id);
                        }
                      });
                    }*/
                  },
                      MyColor.primary,
                      const TextStyle(
                          fontSize: 18,
                          color: MyColor.white,
                          fontFamily: "Poppins"));
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validation() {
    if (phoneCtr.text.toString().isEmpty) {
      // values = forgotPassCtr.otp.value;
      custom.MySnackBar(context, text.Phone_Number.tr);
    } else {
      return true;
    }
    return false;
  }
}

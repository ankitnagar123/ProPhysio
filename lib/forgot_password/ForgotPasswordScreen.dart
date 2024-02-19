import 'package:flutter/material.dart';

import 'package:intl_phone_field/intl_phone_field.dart';

import '../helper/CustomView/CustomView.dart';
import '../helper/mycolor/mycolor.dart';
import '../language_translator/LanguageTranslate.dart';
import 'forgot_pass_controller/ForgotPassController.dart';
import 'package:get/get.dart';
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
  String code = '+1876';
  String flag = 'JM';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery
        .of(context)
        .size
        .width;
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton:    Padding(
          padding: const EdgeInsets.all(11.0),
          child: Obx(() {
            if (forgotPassCtr.loadingotp.value) {
              return custom.MyIndicator();
            }
            return custom.MyButton(context, text.Submit.tr, () {
              if (validation()) {
                forgotPassCtr.forgotPasswordVerification(context, code,phoneCtr.text,"",() {},);
              }
            },
                MyColor.red,
                const TextStyle(
                    fontSize: 18,
                    color: MyColor.white,
                    fontFamily: "Poppins"));
          }),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: height * 0.02),
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
                 const Divider(color: Colors.grey),
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
                      constraints: const BoxConstraints.expand(),
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

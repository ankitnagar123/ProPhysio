import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/Helper/RoutHelper/RoutHelper.dart';
import 'package:medica/forgot_password/forgot_pass_controller/ForgotPassController.dart';
import 'package:medica/helper/mycolor/mycolor.dart';

import '../helper/CustomView/CustomView.dart';
import '../language_translator/LanguageTranslate.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailCtr = TextEditingController();
  ForgotPassCtr forgotPassCtr = ForgotPassCtr();
  CustomView custom = CustomView();
  LocalString text = LocalString();


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
                  child: custom.text(text.Enter_Email.tr, 13, FontWeight.w500,
                      MyColor.primary1),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                custom.myField(context, emailCtr, text.Enter_Email.tr,
                    TextInputType.emailAddress),
                SizedBox(
                  height: height * 0.35,
                ),
                Obx(() {
                  if (forgotPassCtr.loadingotp.value) {
                    return custom.MyIndicator();
                  }
                  return custom.MyButton(context, "Submit", () {
                    if (validation()) {
                      forgotPassCtr.forgotPassword(context, emailCtr.text,)
                          .then((value) {
                        if (value != "") {
                          var id = {"id": forgotPassCtr.id.value,"email":emailCtr.text};
                          Get.toNamed(RouteHelper.getVerification(),
                              arguments: value, parameters: id);
                        }
                      });
                    }
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
    if (emailCtr.text.toString().isEmpty) {
      // values = forgotPassCtr.otp.value;
      custom.MySnackBar(context, "Enter Email ID");
    } else {
      return true;
    }
    return false;
  }
}

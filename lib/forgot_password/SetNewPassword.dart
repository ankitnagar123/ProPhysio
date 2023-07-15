import 'package:flutter/material.dart';
import 'package:medica/Helper/RoutHelper/RoutHelper.dart';
import 'package:medica/forgot_password/forgot_pass_controller/ForgotPassController.dart';

import 'package:medica/helper/mycolor/mycolor.dart';

import '../helper/CustomView/CustomView.dart';
import 'package:get/get.dart';

import '../language_translator/LanguageTranslate.dart';

class SetNewPassword extends StatefulWidget {
  const SetNewPassword({Key? key}) : super(key: key);

  @override
  State<SetNewPassword> createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends State<SetNewPassword> {
  TextEditingController newpasswordctr = TextEditingController();
  TextEditingController confirmpasswordctr = TextEditingController();
  LocalString text = LocalString();

  ForgotPassCtr forgotPassCtr = ForgotPassCtr();
  CustomView custom = CustomView();
  bool _isHidden = true;
  bool _isHidden1 = true;

  var id = "";

  @override
  void initState() {
    id = Get.parameters["id"]!;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final widht = MediaQuery
        .of(context)
        .size
        .width;
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Obx(() {
              if(forgotPassCtr.loadingset.value){
                return custom.MyIndicator();
              }
            return custom.MyButton(context, text.Submit, () {
              forgotPassCtr.setPassword(context, id, newpasswordctr.text, confirmpasswordctr.text, () {
                Get.offAndToNamed(RouteHelper.getSetPassSuccess());

              });
            }, MyColor.primary, const TextStyle(
                fontSize: 18, color: MyColor.white, fontFamily: "Poppins"));
        }),
        body: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                    height: height * 0.09
                ),
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
                custom.text(text.Create_New_One.tr, 23, FontWeight.w700,
                    MyColor.black),
                const Divider(),
                SizedBox(
                    height: height * 0.02
                ),
                custom.text(
                    text.CreatePassLine.tr,
                    12, FontWeight.normal, MyColor.primary1),

                SizedBox(
                    height: height * 0.06
                ),

                Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(
                      text.SetPassword.tr, 12, FontWeight.w600,
                      MyColor.primary1),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                custom.PasswordField(
                    context, newpasswordctr, text.H_Create_Passsword.tr,
                    TextInputType.text, GestureDetector(
                    onTap: () {
                      setState(() {
                        _isHidden = !_isHidden;
                      });
                    },
                    child: _isHidden
                        ? const Icon(
                      Icons.visibility_off,
                      color: MyColor.primary1,
                      size: 18.0,
                    )
                        : const Icon(
                      Icons.visibility,
                      color: MyColor.primary1,
                      size: 18.0,

                    )),
                    _isHidden),
                SizedBox(
                  height: height * 0.03,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(
                      text.confirmPassword.tr, 12, FontWeight.w600, MyColor.primary1),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                custom.PasswordField(
                    context, confirmpasswordctr, text.H_Create_Passsword.tr,
                    TextInputType.text, GestureDetector(
                    onTap: () {
                      setState(() {
                        _isHidden1 = !_isHidden1;
                      });
                    },
                    child: _isHidden1
                        ? const Icon(
                      Icons.visibility_off,
                      color: MyColor.primary1,
                      size: 18.0,
                    )
                        : const Icon(
                      Icons.visibility,
                      color: MyColor.primary1,
                      size: 18.0,

                    )),
                    _isHidden1),
                SizedBox(
                  height: height * 0.25,
                ),

                SizedBox(height: height * 0.03,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool Validation() {
    if (newpasswordctr.text
        .toString()
        .isEmpty) {
      custom.MySnackBar(context, text.SetPassword.tr);
    } else if (newpasswordctr.text
        .toString()
        .length < 8) {
      custom.MySnackBar(context, text.newPasswordAtList6digit.tr);
    } else if (confirmpasswordctr.text
        .toString()
        .isEmpty) {
      custom.MySnackBar(context, text.confirmPassword.tr);
    } else if (confirmpasswordctr.text
        .toString()
        .length < 8) {
      custom.MySnackBar(context, text.confirmPasswordAtList6digit.tr);
    } else
    if (newpasswordctr.text.toString() != confirmpasswordctr.text.toString()) {
      custom.MySnackBar(context, text.passwordNotMatch.tr);
    } else {
      return true;
    }
    return false;
  }
}

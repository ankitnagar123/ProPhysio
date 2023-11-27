import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../helper/mycolor/mycolor.dart';
import '../../../helper/CustomView/CustomView.dart';
import '../../../language_translator/LanguageTranslate.dart';
import '../../center_controller/CenterAuthController.dart';

class CenterChangePasswordScreen extends StatefulWidget {
  const CenterChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<CenterChangePasswordScreen> createState() =>
      _CenterChangePasswordScreenState();
}

class _CenterChangePasswordScreenState
    extends State<CenterChangePasswordScreen> {
  CustomView customView = CustomView();
  bool _isHidden = true;
  bool _isHidden1 = true;
  bool _isHidden2 = true;

  LocalString text = LocalString();
  CenterAuthCtr centerAuthCtr = CenterAuthCtr();
  TextEditingController oldPasswordCtrl = TextEditingController();
  TextEditingController newPasswordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          margin: const EdgeInsets.symmetric(horizontal: 14,vertical: 10),
          child: Obx(() {
            if (centerAuthCtr.loadingPass.value) {
              return customView.MyIndicator();
            }
            return customView.MyButton(
              context,
              text.savePassword.tr,
                  () {
                if (validation()) {
                  centerAuthCtr.centerPasswordChange(
                      context,
                      oldPasswordCtrl.text,
                      newPasswordCtrl.text,
                      confirmPasswordCtrl.text, () {
                    Get.back();
                  });
                }
              },
              MyColor.primary,
              const TextStyle(fontFamily: "Poppins", color: Colors.white),
            );
          }),
        ),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: customView.text(
              text.ChangePassword.tr, 15.0, FontWeight.w500, Colors.black),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: width * 0.10,
              ),
              customView.text(text.enterYourOldPassword.tr, 12.0, FontWeight.w500,
                  MyColor.black),
              SizedBox(
                height: width * 0.02,
              ),
              customView.PasswordField(
                  context,
                  oldPasswordCtrl,
                  text.oldPassword.tr,
                  TextInputType.text,
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          _isHidden = !_isHidden;
                        });
                      },
                      child: _isHidden
                          ? const Icon(
                        Icons.visibility_off,
                        color: MyColor.primary,
                        size: 20.0,
                      )
                          : const Icon(
                        Icons.visibility,
                        color: MyColor.primary,
                        size: 20.0,
                      )),
                  _isHidden),
              SizedBox(
                height: width * 0.1,
              ),
              customView.text(text.enterYourNewPassword.tr, 12.0, FontWeight.w500,
                  MyColor.black),
              SizedBox(
                height: width * 0.02,
              ),
              customView.PasswordField(
                  context,
                  newPasswordCtrl,
                  text.newPassword.tr,
                  TextInputType.text,
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          _isHidden1 = !_isHidden1;
                        });
                      },
                      child: _isHidden1
                          ? const Icon(
                        Icons.visibility_off,
                        color: MyColor.primary,
                        size: 20.0,
                      )
                          : const Icon(
                        Icons.visibility,
                        color: MyColor.primary,
                        size: 20.0,
                      )),
                  _isHidden1),
              SizedBox(
                height: width * 0.1,
              ),
              customView.text(
                  text.confirmPassword.tr, 12.0, FontWeight.w500, MyColor.black),
              SizedBox(
                height: width * 0.02,
              ),
              customView.PasswordField(
                  context,
                  confirmPasswordCtrl,
                  text.newPassword.tr,
                  TextInputType.text,
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          _isHidden2 = !_isHidden2;
                        });
                      },
                      child: _isHidden2
                          ? const Icon(
                        Icons.visibility_off,
                        color: MyColor.primary,
                        size: 20.0,
                      )
                          : const Icon(
                        Icons.visibility,
                        color: MyColor.primary,
                        size: 20.0,
                      )),
                  _isHidden2),
              SizedBox(
                height: height*0.5,
              ),

            ],
          ),
        ),
      ),
    );
  }

  // ******************Change Password VALIDATION (IF/ELSE CONDITIONS.)*****************//
  bool validation() {
    if (oldPasswordCtrl.text.toString().isEmpty) {
      customView.MySnackBar(context, text.enterYourOldPassword.tr);
    } else if (newPasswordCtrl.text.toString().isEmpty) {
      customView.MySnackBar(context, text.enterYourNewPassword.tr);
    } else if (newPasswordCtrl.text.toString().length < 6) {
      customView.MySnackBar(context, text.newPasswordAtList6digit.tr);
    } else if (confirmPasswordCtrl.text.toString().isEmpty) {
      customView.MySnackBar(context,  text.confirmPassword.tr);
    } else if (confirmPasswordCtrl.text.toString().length < 6) {
      customView.MySnackBar(context, text.confirmPasswordAtList6digit.tr);
    } else if (newPasswordCtrl.text.toString() !=
        confirmPasswordCtrl.text.toString()) {
      customView.MySnackBar(context, text.passwordNotMatch.tr);
    } else {
      return true;
    }
    return false;
  }
}

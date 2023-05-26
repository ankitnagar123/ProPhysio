import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:medica/medica_center/center_controller/CenterAuthController.dart';

import '../../../../../../helper/mycolor/mycolor.dart';

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
  CenterAuthCtr centerAuthCtr = CenterAuthCtr();
  TextEditingController oldPasswordCtrl = TextEditingController();
  TextEditingController newPasswordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();

  // PatientChangePassCtr changePassCtr = PatientChangePassCtr();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
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
              "Change password", 15.0, FontWeight.w500, Colors.black),
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
              customView.text("Enter your old password", 12.0, FontWeight.w500,
                  MyColor.black),
              SizedBox(
                height: width * 0.02,
              ),
              customView.PasswordField(
                  context,
                  oldPasswordCtrl,
                  "Old password",
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
              customView.text("Enter your new password", 12.0, FontWeight.w500,
                  MyColor.black),
              SizedBox(
                height: width * 0.02,
              ),
              customView.PasswordField(
                  context,
                  newPasswordCtrl,
                  "New password",
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
              customView.text(
                  "Confirm password", 12.0, FontWeight.w500, MyColor.black),
              SizedBox(
                height: width * 0.02,
              ),
              customView.PasswordField(
                  context,
                  confirmPasswordCtrl,
                  "New password",
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
                height: height*0.5,
              ),
              Align(
                alignment: Alignment.center,
                child: Obx(() {
                  if (centerAuthCtr.loadingPass.value) {
                    return customView.MyIndicator();
                  }
                  return customView.MyButton(
                    context,
                    "Save Password",
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
              )
            ],
          ),
        ),
      ),
    );
  }

  // ******************Change Password VALIDATION (IF/ELSE CONDITIONS.)*****************//
  bool validation() {
    if (oldPasswordCtrl.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter old password");
    } else if (newPasswordCtrl.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter new password");
    } else if (newPasswordCtrl.text.toString().length < 6) {
      customView.MySnackBar(context, "New Password is must be of 6 digit");
    } else if (confirmPasswordCtrl.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter confirm password");
    } else if (confirmPasswordCtrl.text.toString().length < 6) {
      customView.MySnackBar(context, "confirm is must be of 6 digit");
    } else if (newPasswordCtrl.text.toString() !=
        confirmPasswordCtrl.text.toString()) {
      customView.MySnackBar(context, "Password is doesn't match");
    } else {
      return true;
    }
    return false;
  }
}

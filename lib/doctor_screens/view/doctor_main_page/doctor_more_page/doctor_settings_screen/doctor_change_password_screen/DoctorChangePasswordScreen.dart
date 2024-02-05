import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:awesome_dialog/awesome_dialog.dart';

import '../../../../../../helper/CustomView/CustomView.dart';
import '../../../../../../helper/mycolor/mycolor.dart';
import '../../../../../../language_translator/LanguageTranslate.dart';
import '../../../../../controller/DoctorChangePasswordCtr.dart';

class DoctorChangePasswordScreen extends StatefulWidget {
  const DoctorChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<DoctorChangePasswordScreen> createState() =>
      _DoctorChangePasswordScreenState();
}

class _DoctorChangePasswordScreenState
    extends State<DoctorChangePasswordScreen> {
  CustomView customView = CustomView();
  LocalString text = LocalString();
  bool _isHidden = true;

  TextEditingController oldPasswordCtrl = TextEditingController();
  TextEditingController newPasswordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();

  DoctorChangePassCtr changePassCtr = DoctorChangePassCtr();
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

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
                 text.confirmPassword.tr, 12.0, FontWeight.w500, MyColor.black),
              SizedBox(
                height: width * 0.02,
              ),
              customView.PasswordField(
                  context,
                  confirmPasswordCtrl,
                  text.confirmPassword.tr,
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
                height: height*0.2,
              ),
              Obx(
                () => Align(
                  alignment: Alignment.center,
                  child: changePassCtr.loadingset.value?customView.MyIndicator():  AnimatedButton(
                    width: MediaQuery.of(context).size.width * 0.9,
                    text: text.savePassword.tr,
                    color: MyColor.primary,
                    pressEvent: () {
                      if (validation()) {
                        changePassCtr.changePasswordApi(
                            context,
                            oldPasswordCtrl.text,
                            newPasswordCtrl.text,
                            confirmPasswordCtrl.text, () {
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.leftSlide,
                            headerAnimationLoop: false,
                            dialogType: DialogType.success,
                            showCloseIcon: true,
                            title: text.success.tr,
                            desc: text.Changed_Pass_Successfully.tr,
                            btnOkOnPress: () {
                              Get.back();
                              debugPrint('OnClcik');
                            },
                            btnOkIcon: Icons.check_circle,
                            onDismissCallback: (type) {
                              debugPrint('Dialog Dismiss from callback $type');
                            },
                          ).show();
                        });
                      }
                    },
                  ),
                ),
              ),

          /*    Align(
                alignment: Alignment.center,
                child: Obx(() {
                  if (changePassCtr.loadingset.value) {
                    return customView.MyIndicator();
                  }
                  return customView.MyButton(
                    context,
                    "Save Password",
                        () {
                      if (validation()) {
                        changePassCtr.changePasswordApi(
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
              )*/
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
      customView.MySnackBar(context,text.confirmPassword.tr);
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

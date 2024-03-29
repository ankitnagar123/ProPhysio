import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../../language_translator/LanguageTranslate.dart';
import '../../../../controller/auth_controllers/PatientChangePasswordCtr.dart';
import '../about_page/PatinetAboutPage.dart';
import '../term_condition_page/PatientTermCondition.dart';

class PatientSettingsScreen extends StatefulWidget {
  const PatientSettingsScreen({Key? key}) : super(key: key);

  @override
  State<PatientSettingsScreen> createState() => _PatientSettingsScreenState();
}

class _PatientSettingsScreenState extends State<PatientSettingsScreen> {
  CustomView customView = CustomView();
  TextEditingController passwordCtr = TextEditingController();
  LocalString text = LocalString();
  PatientChangePassCtr changePassCtr = PatientChangePassCtr();
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
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
              text.Settings.tr, 15.0, FontWeight.w500, Colors.black),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  Get.toNamed(
                    RouteHelper.getPatientChangePasswordScreen(),
                  );
                },
                leading: const Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
                title: customView.text(text.ChangePassword.tr, 14.0,
                    FontWeight.w500, Colors.black),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 20.0,
                ),
              ),
              ListTile(
                onTap: () {
                  Get.toNamed(
                    RouteHelper.getPFAQ(),
                  );
                },
                leading: const Icon(
                  Icons.info_outline,
                  color: Colors.black,
                ),
                title: customView.text("FAQ", 14.0,
                    FontWeight.w500, Colors.black),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 20.0,
                ),
              ),
              ListTile(
                visualDensity: VisualDensity.compact,
                onTap: () {
                  Get.toNamed(RouteHelper.getPTandC(),);
                },
                leading: const Icon(
                  Icons.note_alt,
                  color: Colors.black,
                ),
                title: customView.text(
                    text.TermCondition.tr, 14.0, FontWeight.w500, Colors.black),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 20.0,
                ),
              ),
              ListTile(
                visualDensity: VisualDensity.compact,
                onTap: () {
                  Get.toNamed(RouteHelper.getPPandP(),);
                },
                leading: const Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
                title: customView.text(
                    "Privacy Policy", 14.0, FontWeight.w500, Colors.black),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 20.0,
                ),
              ),
              ListTile(
                visualDensity: VisualDensity.compact,
                onTap: () {
                  Get.toNamed(RouteHelper.DAboutScreen(),);

                },
                leading: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                title: customView.text(
                    text.About.tr, 14.0, FontWeight.w500, Colors.black),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 20.0,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
          child: TextButton(
            onPressed: () {
              deletePopUp(context);
            },
            child: customView.text(
                text.Deleteaccount.tr, 15.0, FontWeight.w500, Colors.red),
          ),
        ),
      ),
    );
  }

  void deletePopUp(BuildContext context) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black54,
        pageBuilder: (context, anim1, anim2) {
          return Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1,
              child: StatefulBuilder(
                builder: (context, StateSetter setState) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: customView.text("Delete account", 17,
                                FontWeight.w500, Colors.black),
                          ),
                          const SizedBox(
                            height: 13.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: customView.text(
                                text.AreyouSureDeleteAccount.tr,
                                12,
                                FontWeight.w400,
                                Colors.black),
                          ),
                          const SizedBox(
                            height: 13.0,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: customView.text(text.EnterYourPassword.tr,
                                13, FontWeight.w600, MyColor.black),
                          ),
                          const SizedBox(height: 5.0),
                          customView.PasswordField(
                              context,
                              passwordCtr,
                              text.Enter_Password.tr,
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
                                          size: 20,
                                        )
                                      : const Icon(
                                          Icons.visibility,
                                          color: MyColor.primary,
                                          size: 20,
                                        )),
                              _isHidden),
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: customView.text(text.Dismiss.tr, 14.0,
                                    FontWeight.w500, MyColor.grey),
                              ),
                              Obx(() {
                                if (changePassCtr.loadingd.value) {
                                  return customView.MyIndicator();
                                }
                                return customView.mysButton(
                                  context,
                                  text.Deleteaccount.tr,
                                  () {
                                    changePassCtr.deleteAccount(
                                        context, passwordCtr.text, () {
                                      Get.offAllNamed(
                                          RouteHelper.getLoginScreen());
                                    });
                                  },
                                  Colors.red,
                                  const TextStyle(
                                    color: MyColor.white,
                                  ),
                                );
                              }),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        });
  }

// ******************Delete Account (IF/ELSE CONDITIONS.)*****************//
  bool validation() {
    if (passwordCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, text.Enter_Password.tr);
    } else {
      return true;
    }
    return false;
  }
}

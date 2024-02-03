import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../../language_translator/LanguageTranslate.dart';
import '../../../../controller/DoctorSignUpController.dart';
import '../../../../controller/DoctorSupportController.dart';

class DoctorSupportScreen extends StatefulWidget {
  const DoctorSupportScreen({Key? key}) : super(key: key);

  @override
  State<DoctorSupportScreen> createState() => _DoctorSupportScreenState();
}

class _DoctorSupportScreenState extends State<DoctorSupportScreen> {
  CustomView customView = CustomView();
  DoctorSupportCtr supportCtr = Get.put(DoctorSupportCtr());
  DoctorSignUpCtr doctorSignUpCtr = Get.put(DoctorSignUpCtr());

  LocalString text= LocalString();

  TextEditingController subjectCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController msgCtrl = TextEditingController();
  String? selectedBranch;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          bottomNavigationBar:   Container(
            height: 57.0,
            margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 14),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Obx(() {
                if (supportCtr.loading.value) {
                  return Center(child: customView.MyIndicator());
                }
                return customView.MyButton(
                  context,
                  text.Sendmessage.tr,
                      () {
                    if (validation()) {
                      supportCtr.supportApi(context, subjectCtrl.text,
                          emailCtrl.text, msgCtrl.text,selectedBranch, () {
                        subjectCtrl.clear();
                        emailCtrl.clear();
                        msgCtrl.clear();
                          });
                    }
                  },
                  MyColor.red,
                  const TextStyle(fontFamily: "Poppins", color: Colors.white),
                );
              }),
            ),
          ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const Divider(color: Colors.grey),
            customView.text(text.ContactSupport.tr, 14.0,
                FontWeight.w500, Colors.black),
            SizedBox(
              height: width * 0.09,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: customView.text(text.Select_Branch.tr, 13.0,
                  FontWeight.w500, MyColor.black),
            ),
            Obx(() => doctorSignUpCtr.branchLoading.value?customView.MyIndicator():  branch(),),            SizedBox(
              height: width * 0.05,
            ),
            customView.text(text.Subject.tr, 12.0, FontWeight.w500, MyColor.black),
            SizedBox(
              height: width * 0.02,
            ),
            customView.myField(
                context, subjectCtrl, text.Subject.tr, TextInputType.text),
            SizedBox(
              height: width * 0.05,
            ),
            customView.text(text.Enter_Email.tr, 12.0, FontWeight.w500, MyColor.black),
            SizedBox(
              height: width * 0.02,
            ),
            customView.myField(
                context, emailCtrl, text.H_Enter_Email.tr, TextInputType.text),
            SizedBox(
              height: width * 0.05,
            ),
            customView.text(text.Message.tr, 12.0, FontWeight.w500, MyColor.black),
            SizedBox(
              height: width * 0.02,
            ),
            customView.myField(
                context, msgCtrl, text.Message.tr, TextInputType.text),
            SizedBox(
              height: width * 0.6,
            ),
          ],
        ),
      ),
    ));
  }


  /*---------SELECT BRANCH-----*/
  Widget branch() {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return StatefulBuilder(
      builder: (context, StateSetter stateSetter) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Center(
          child: Container(
            height: height * 0.06,
            width: widht * 0.9,
            padding: const EdgeInsets.only(left: 4),
            margin: const EdgeInsets.fromLTRB(0, 5, 5.0, 0.0),
            decoration: BoxDecoration(
                color: MyColor.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: MyColor.grey)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                menuMaxHeight: MediaQuery.of(context).size.height / 3,
                // Initial Value
                value: selectedBranch,
                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down,
                    color: MyColor.primary),
                // Array list of items
                items: doctorSignUpCtr.branchList.map((items) {
                  return DropdownMenuItem(
                    value: items.branchId,
                    child: Text(items.branchName),
                  );
                }).toList(),
                hint: Text(
                  text.Select_Branch.tr,
                  style: TextStyle(fontSize: 13),
                ),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (newValue) {
                  stateSetter(() {
                    selectedBranch = newValue;
                    log('MY CATEGORY>>>$selectedBranch');
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ******************Support Input filed VALIDATION (IF/ELSE CONDITIONS.)*****************//
  bool validation() {
    if (subjectCtrl.text.toString().isEmpty) {
      customView.MySnackBar(context, text.Subject.tr);
    } else if (emailCtrl.text.toString().isEmpty) {
      customView.MySnackBar(context,  text.enteAddress.tr);
    } else if (msgCtrl.text.toString().isEmpty) {
      customView.MySnackBar(context, text.Message.tr);
    } else {
      return true;
    }
    return false;
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../doctor_screens/controller/DoctorSignUpController.dart';
import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../../language_translator/LanguageTranslate.dart';
import '../../../../controller/auth_controllers/PatientSupportController.dart';

class PatientSupportScreen extends StatefulWidget {
  const PatientSupportScreen({Key? key}) : super(key: key);

  @override
  State<PatientSupportScreen> createState() => _PatientSupportScreenState();
}

class _PatientSupportScreenState extends State<PatientSupportScreen> {
  CustomView customView = CustomView();

  PatientSupportCtr patientSupportCtr = Get.put(PatientSupportCtr());
  DoctorSignUpCtr doctorSignUpCtr = Get.put(DoctorSignUpCtr());



  TextEditingController subjectCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController msgCtrl = TextEditingController();
  String? selectedBranch;

  LocalString text = LocalString();

  @override
  void initState() {
    super.initState();
    doctorSignUpCtr.branchListApi();
  }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          bottomNavigationBar:  Container(
            margin: const EdgeInsets.symmetric(vertical: 10,horizontal:  10),
            height: 58,
            child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Obx(
                      () {
                    if (patientSupportCtr.loading.value) {
                      return Center(child: customView.MyIndicator());
                    }
                    return customView.MyButton(
                      context,
                      text.Sendmessage.tr,
                          () {
                        if(validation()){

                          patientSupportCtr.supportApi(context, subjectCtrl.text,
                              emailCtrl.text, msgCtrl.text,selectedBranch ,() {
                                subjectCtrl.clear();
                                emailCtrl.clear();
                                msgCtrl.clear();
                                selectedBranch == '';
                              });
                        }

                      },
                      MyColor.red,
                      const TextStyle(
                          fontFamily: "Poppins", color: Colors.white),
                    );
                  },
                )),
          ) ,
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 5),
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
                        FontWeight.w500, MyColor.primary1),
                  ),
                  branch(),
                  SizedBox(
                    height: width * 0.02,
                  ),
                  customView.text(
                      text.Subject.tr, 12.0, FontWeight.w500, MyColor.black),
                  SizedBox(
                    height: width * 0.02,
                  ),
                  customView.myField(
                      context, subjectCtrl, text.yourSubject.tr, TextInputType.text),
                  SizedBox(
                    height: width * 0.05,
                  ),
                  customView.text(
                      text.enterEmail.tr, 12.0, FontWeight.w500, MyColor.black),
                  SizedBox(
                    height: width * 0.02,
                  ),
                  customView.myField(
                      context, emailCtrl, text.yourEmail.tr, TextInputType.text),
                  SizedBox(
                    height: width * 0.05,
                  ),
                  customView.text(
                      text.Message.tr, 12.0, FontWeight.w500, MyColor.black),
                  SizedBox(
                    height: width * 0.02,
                  ),
                  customView.myFieldExpand(
                      context, msgCtrl, text.yourMessage.tr, TextInputType.text),
                  SizedBox(
                    height: width * 0.6,
                  ),
                ],
              ),
            )));
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

  bool validation() {
    if (subjectCtrl.text.isEmpty) {
      customView.MySnackBar(context, text.enterSubject.tr);
    } else if (emailCtrl.text.isEmpty) {
      customView.MySnackBar(context, text.enterEmail.tr);
    }  else if (msgCtrl.text.isEmpty) {
      customView.MySnackBar(context,text.enterMassage.tr);
    }else {
      return true;
    }
    return false;
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';

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

  PatientSupportCtr patientSupportCtr = PatientSupportCtr();
  TextEditingController subjectCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController msgCtrl = TextEditingController();
  LocalString text = LocalString();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          bottomNavigationBar:  Container(
            margin: const EdgeInsets.symmetric(vertical: 10,horizontal:  15),
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
                              emailCtrl.text, msgCtrl.text, () {
                                subjectCtrl.clear();
                                emailCtrl.clear();
                                msgCtrl.clear();
                              });
                        }

                      },
                      MyColor.primary,
                      const TextStyle(
                          fontFamily: "Poppins", color: Colors.white),
                    );
                  },
                )),
          ) ,
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
                  text.Support.tr, 15.0, FontWeight.w500, Colors.black),
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: Colors.white24,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  customView.text(text.ContactSupport.tr, 14.0,
                      FontWeight.w500, Colors.black),
                  SizedBox(
                    height: width * 0.09,
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
                  customView.myField(
                      context, msgCtrl, text.yourMessage.tr, TextInputType.text),
                  SizedBox(
                    height: width * 0.6,
                  ),
                ],
              ),
            )));
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

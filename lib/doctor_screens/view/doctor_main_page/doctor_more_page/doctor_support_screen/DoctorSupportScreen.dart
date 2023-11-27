import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../../language_translator/LanguageTranslate.dart';
import '../../../../controller/DoctorSupportController.dart';

class DoctorSupportScreen extends StatefulWidget {
  const DoctorSupportScreen({Key? key}) : super(key: key);

  @override
  State<DoctorSupportScreen> createState() => _DoctorSupportScreenState();
}

class _DoctorSupportScreenState extends State<DoctorSupportScreen> {
  CustomView customView = CustomView();
  DoctorSupportCtr supportCtr = DoctorSupportCtr();
  LocalString text= LocalString();

  TextEditingController subjectCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController msgCtrl = TextEditingController();

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
                          emailCtrl.text, msgCtrl.text, () {
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
        title: customView.text(text.Support.tr, 15.0, FontWeight.w500, Colors.black),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white24,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            customView.text(text.ContactSupport.tr, 14.0,
                FontWeight.w500, Colors.black),
            SizedBox(
              height: width * 0.09,
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

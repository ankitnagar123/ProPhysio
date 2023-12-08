import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../helper/mycolor/mycolor.dart';
import '../../../helper/CustomView/CustomView.dart';
import '../../../language_translator/LanguageTranslate.dart';
import '../../center_controller/CenterAuthController.dart';

class CenterSupportScreen extends StatefulWidget {
  const CenterSupportScreen({Key? key}) : super(key: key);

  @override
  State<CenterSupportScreen> createState() => _CenterSupportScreenState();
}

class _CenterSupportScreenState extends State<CenterSupportScreen> {
  CustomView customView = CustomView();

  TextEditingController subjectCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController msgCtrl = TextEditingController();
  CenterAuthCtr centerAuthCtr = CenterAuthCtr();
  LocalString text= LocalString();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      floatingActionButton:  Container(
        margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 14),
        child: Obx(() {
          if (centerAuthCtr.loadingSupport.value) {
            return customView.MyIndicator();
          }
          return customView.MyButton(
            context,
            text.Sendmessage.tr,
                () {
              if (validation()) {
                centerAuthCtr.centerSupport(context, subjectCtrl.text,
                    emailCtrl.text, msgCtrl.text, () {
                      Get.back();
                    });
              }
            },
            MyColor.primary,
            const TextStyle(fontFamily: "Poppins", color: Colors.white),
          );
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
             const Divider(color: Colors.grey),
            customView.text( text.ContactSupport.tr, 14.0,
                FontWeight.w500, Colors.black),
            SizedBox(
              height: width * 0.09,
            ),
            customView.text(text.Subject.tr, 12.0, FontWeight.w500, MyColor.black),
            SizedBox(
              height: width * 0.02,
            ),
            customView.myField(
                context, subjectCtrl,text.Subject.tr, TextInputType.text),
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

    );
  }

  // ******************Support Input filed VALIDATION (IF/ELSE CONDITIONS.)*****************//
  bool validation() {
    if (subjectCtrl.text
        .toString()
        .isEmpty) {
      customView.MySnackBar(context, text.Subject.tr);
    } else if (emailCtrl.text
        .toString()
        .isEmpty) {
      customView.MySnackBar(context, text.enteAddress.tr);
    } else if (msgCtrl.text
        .toString()
        .isEmpty) {
      customView.MySnackBar(context, text.Message.tr);
    } else {
      return true;
    }
    return false;
  }
}
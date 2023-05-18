import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:medica/medica_center/center_controller/AuthController.dart';

import '../../../../../helper/mycolor/mycolor.dart';

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
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
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
        title: customView.text("Support", 15.0, FontWeight.w500, Colors.black),
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
            customView.text("Contact us if you need support.", 14.0,
                FontWeight.w500, Colors.black),
            SizedBox(
              height: width * 0.09,
            ),
            customView.text("Subject", 12.0, FontWeight.w500, MyColor.black),
            SizedBox(
              height: width * 0.02,
            ),
            customView.myField(
                context, subjectCtrl, "Your subject", TextInputType.text),
            SizedBox(
              height: width * 0.05,
            ),
            customView.text("Email", 12.0, FontWeight.w500, MyColor.black),
            SizedBox(
              height: width * 0.02,
            ),
            customView.myField(
                context, emailCtrl, "Your Email", TextInputType.text),
            SizedBox(
              height: width * 0.05,
            ),
            customView.text("Message", 12.0, FontWeight.w500, MyColor.black),
            SizedBox(
              height: width * 0.02,
            ),
            customView.myField(
                context, msgCtrl, "Your Message", TextInputType.text),
            SizedBox(
              height: width * 0.6,
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Obx(() {
                  if (centerAuthCtr.loadingSupport.value) {
                    return customView.MyIndicator();
                  }
                  return customView.MyButton(
                    context,
                    "Send message",
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
            )
          ],
        ),
      ),
      // bottomNavigatonBar: Container(
      //   margin:
      //       const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      //   child: Obx(() {
      //     if (supportCtr.loading.value) {
      //       return customView.MyIndicator();
      //     }
      //     return customView.MyButton(
      //       context,
      //       "Send message",
      //       () {
      //         if(validation()){
      //           supportCtr.supportApi(context, subjectCtrl.text,
      //               emailCtrl.text, msgCtrl.text, () {
      //
      //               });
      //         }
      //
      //       },
      //       MyColor.primary,
      //       const TextStyle(fontFamily: "Poppins", color: Colors.white),
      //     );
      //   }),
      // )),
    );
  }

  // ******************Support Input filed VALIDATION (IF/ELSE CONDITIONS.)*****************//
  bool validation() {
    if (subjectCtrl.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter subject");
    } else if (emailCtrl.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter email id");
    } else if (msgCtrl.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter massage");
    } else {
      return true;
    }
    return false;
  }
}

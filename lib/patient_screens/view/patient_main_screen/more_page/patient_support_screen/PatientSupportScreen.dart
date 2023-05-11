import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';

import '../../../../../helper/mycolor/mycolor.dart';
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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            // floatingActionButtonLocation:
            //     FloatingActionButtonLocation.centerDocked,
            // floatingActionButton: Padding(
            //     padding: const EdgeInsets.only(bottom: 12),
            //     child: Obx(
            //       () {
            //         if (patientSupportCtr.loading.value) {
            //           return customView.MyIndicator();
            //         }
            //         return customView.MyButton(
            //           context,
            //           "Send message",
            //           () {
            //             patientSupportCtr.supportApi(context, subjectCtrl.text,
            //                 emailCtrl.text, msgCtrl.text, () {});
            //           },
            //           MyColor.primary,
            //           const TextStyle(
            //               fontFamily: "Poppins", color: Colors.white),
            //         );
            //       },
            //     )),
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
                  "Support", 15.0, FontWeight.w500, Colors.black),
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
                  customView.text("Contact us if you need support.", 14.0,
                      FontWeight.w500, Colors.black),
                  SizedBox(
                    height: width * 0.09,
                  ),
                  customView.text(
                      "Subject", 12.0, FontWeight.w500, MyColor.black),
                  SizedBox(
                    height: width * 0.02,
                  ),
                  customView.myField(
                      context, subjectCtrl, "Your subject", TextInputType.text),
                  SizedBox(
                    height: width * 0.05,
                  ),
                  customView.text(
                      "Email", 12.0, FontWeight.w500, MyColor.black),
                  SizedBox(
                    height: width * 0.02,
                  ),
                  customView.myField(
                      context, emailCtrl, "Your Email", TextInputType.text),
                  SizedBox(
                    height: width * 0.05,
                  ),
                  customView.text(
                      "Message", 12.0, FontWeight.w500, MyColor.black),
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
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Obx(
                              () {
                            if (patientSupportCtr.loading.value) {
                              return customView.MyIndicator();
                            }
                            return customView.MyButton(
                              context,
                              "Send message",
                                  () {
                                patientSupportCtr.supportApi(context, subjectCtrl.text,
                                    emailCtrl.text, msgCtrl.text, () {});
                              },
                              MyColor.primary,
                              const TextStyle(
                                  fontFamily: "Poppins", color: Colors.white),
                            );
                          },
                        )),
                  ),
                ],
              ),
            )));
  }
}

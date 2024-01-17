import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:prophysio/helper/CustomView/CustomView.dart';
import 'package:prophysio/singup_screen/patient_pages/PatientPage.dart';
import '../helper/mycolor/mycolor.dart';
import '../language_translator/LanguageTranslate.dart';
import 'doctor_signup_page/DoctorSignUpScreen.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({Key? key}) : super(key: key);

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen>with SingleTickerProviderStateMixin {
  LocalString text = LocalString();
  CustomView view = CustomView();
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(children: [
             Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 8.0,bottom: 10),
              child: Container(
                height: kToolbarHeight - 8.0,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: TabBar(
                  controller: tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: MyColor.red.withOpacity(0.8)),
                  labelStyle: const TextStyle(
                      fontFamily:  "Poppins",
                      color: MyColor.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                  ),
                  unselectedLabelStyle: const TextStyle(
                      fontFamily:  "Poppins",
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.normal
                  ),
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Text(
                      text.I_Patinet.tr,
                    ),
                    Text(
                      text.I_Doctor.tr,
                    ),
                    /* Text(
                  text.I_Center.tr,
                  style: TextStyle(color:  MyColor.primary),
                ),*/
                  ],
                ),
              ),
            ),



            Expanded(
              child: TabBarView(
                             physics:  const NeverScrollableScrollPhysics(),
                  controller: tabController, children: const [
                PatientSignUp(),
                DoctorSignUpScreen(),
                // SellHomeScreen(),
              ]),
            ),
          ])),
    );
  }
}


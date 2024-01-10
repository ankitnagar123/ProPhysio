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

class _SingUpScreenState extends State<SingUpScreen> {
  LocalString text = LocalString();
  CustomView view = CustomView();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // toolbarHeight: 80,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          bottom:  TabBar(
            indicatorSize:  TabBarIndicatorSize.tab,
            padding: EdgeInsets.only(left: 3,right: 3),
            labelPadding: const EdgeInsets.all(7.0),
            indicatorColor: MyColor.red,
            indicator:  BoxDecoration(color: Colors.grey.shade200,borderRadius: BorderRadius.circular(25),),
            tabs: [
              Text(
                text.I_Patinet.tr,
                style: TextStyle(color: MyColor.red,fontSize: 17),
              ),
              Text(
                text.I_Doctor.tr,
                style: TextStyle(color:  MyColor.red,fontSize: 17),
              ),
             /* Text(
                text.I_Center.tr,
                style: TextStyle(color:  MyColor.primary),
              ),*/
            ],
          ),
          title:               view.text(text.Create_An_Account.tr, 15, FontWeight.w500, Colors.black,),
          /*Column(
            children: [
              SizedBox(height: 3,),
              const Image(
                image: AssetImage("assets/images/runlogo.png"),
                height: 40,
                width: 40,
              ),

            ],
          ),*/
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body:     const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            PatientSignUp(),
            DoctorSignUpScreen(),
            // MedicalCenterSignUp(),
          ],
        ),
      ),
    );
  }
}

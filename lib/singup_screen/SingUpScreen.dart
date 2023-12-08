import 'package:flutter/material.dart';

import 'package:get/get.dart';
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 88,
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
            padding: EdgeInsets.only(left: 3,right: 3,bottom: 5),
            labelPadding: const EdgeInsets.all(7.0),
            indicatorColor: MyColor.red,
            indicator:  BoxDecoration(color: MyColor.red.withOpacity(0.3),borderRadius: BorderRadius.circular(25),),
            tabs: [
              Text(
                text.I_Patinet.tr,
                style: TextStyle(color: MyColor.red,fontSize: 18),
              ),
              Text(
                text.I_Doctor.tr,
                style: TextStyle(color:  MyColor.red,fontSize: 18),
              ),
             /* Text(
                text.I_Center.tr,
                style: TextStyle(color:  MyColor.primary),
              ),*/
            ],
          ),
          title:  Column(
            children: [
              SizedBox(height: 3,),
              const Image(
                image: AssetImage("assets/images/runlogo.png"),
                height: 45,
                width: 45,
              ),
              Text(
                text.Create_An_Account.tr,
                style:
                    const TextStyle(color: Colors.black, fontWeight: FontWeight.w600  ),
              ),
            ],
          ),
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

import 'package:flutter/material.dart';
import 'package:medica/helper/mycolor/mycolor.dart';
import 'package:medica/singup_screen/patient_pages/PatientPage.dart';
import 'package:get/get.dart';
import '../language_translator/LanguageTranslate.dart';
import 'doctor_signup_page/DoctorSignUpScreen.dart';
import 'medical_center_signup/MedicalCenterSignUp.dart';

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
      length: 3,
      
      child: SafeArea(
        child: Scaffold(
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
            bottom:  TabBar(
              labelPadding: EdgeInsets.all(7.0),
              indicatorColor: MyColor.primary,
              tabs: [
                Text(
                  text.I_Patinet.tr,
                  style: TextStyle(color: MyColor.primary),
                ),
                Text(
                  text.I_Doctor.tr,
                  style: TextStyle(color:  MyColor.primary),
                ),
                Text(
                  text.I_Center.tr,
                  style: TextStyle(color:  MyColor.primary),
                ),
              ],
            ),
            title:  Text(
              text.Create_An_Account.tr,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          body:    const TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              PatientSignUp(),
              DoctorSignUpScreen(),
              MedicalCenterSignUp(),
            ],
          ),
        ),
      ),
    );
  }
}

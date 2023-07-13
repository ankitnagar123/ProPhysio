import 'package:flutter/material.dart';
import 'package:medica/patient_screens/view/patient_main_screen/PatientMainScreen.dart';
import 'package:get/get.dart';
import '../../../../helper/CustomView/CustomView.dart';
import '../../../../helper/mycolor/mycolor.dart';
import '../../../../language_translator/LanguageTranslate.dart';

class PatientBookingCancelSuccess extends StatefulWidget {
  const PatientBookingCancelSuccess({Key? key}) : super(key: key);

  @override
  State<PatientBookingCancelSuccess> createState() =>
      _PatientBookingCancelSuccessState();
}

class _PatientBookingCancelSuccessState
    extends State<PatientBookingCancelSuccess> {
  CustomView custom = CustomView();
  LocalString text = LocalString();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: custom.MyButton(context, "Ok", () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PatientMainScreen()));
          // Get.offAllNamed(RouteHelper.getLoginScreen());
        },
            MyColor.white,
            const TextStyle(
                color: MyColor.primary,
                fontSize: 16,
                fontFamily: "Poppins",
                letterSpacing: 0.8)),
      ),
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [MyColor.primary, MyColor.secondary]),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: const AssetImage('assets/images/medicalogo2.png'),
                height: height * 0.2,
                width: widht * 0.4,
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: custom.text(
                        text.Appointment_cancelled_successfully.tr,
                        22,
                        FontWeight.w600,
                        MyColor.white)),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Align(
                  alignment: Alignment.center,
                  child: custom.text(
                      text.youCanContactTheDoctor.tr,
                      14,
                      FontWeight.normal,
                      MyColor.white)),
            ],
          ),
        ),
      ),
    );
  }
}

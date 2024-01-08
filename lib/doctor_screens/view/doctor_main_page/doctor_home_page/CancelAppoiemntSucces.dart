import 'package:flutter/material.dart';

import '../../../../helper/CustomView/CustomView.dart';
import '../../../../helper/mycolor/mycolor.dart';
import '../doctor_more_page/DoctorMainPage.dart';

class CancelAppointmentSuccess extends StatefulWidget {
  const CancelAppointmentSuccess({Key? key}) : super(key: key);

  @override
  State<CancelAppointmentSuccess> createState() => _CancelAppointmentSuccessState();
}

class _CancelAppointmentSuccessState extends State<CancelAppointmentSuccess> {
  CustomView custom = CustomView();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: custom.MyButton(context, "OK", () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const DoctorMainScreen()));
          // Get.offAllNamed(RouteHelper.getLoginScreen());
        }, MyColor.white,
            const TextStyle(color: MyColor.primary,fontSize: 16,fontFamily: "Poppins",letterSpacing: 0.8)),
      ),
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        decoration:  const BoxDecoration(
          gradient: LinearGradient(
              begin:  Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                MyColor.primary,
                MyColor.primary1
              ]
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("assets/images/prologo.png"),
                 height: 100,
                // width: 130,
              ),
              SizedBox(height: height*0.08,),
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: custom.text("Appointment \ncancelled \nsuccessfully!", 22, FontWeight.w600, MyColor.white)),
              ),
              SizedBox(height: height*0.02,),
              Align(
                  alignment: Alignment.center,
                  child: custom.text("You can contact the patient if you want to.", 14, FontWeight.normal, MyColor.white)),
            ],
          ),
        ),
      ),
    );
  }
}

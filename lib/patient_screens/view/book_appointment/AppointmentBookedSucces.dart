import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../helper/CustomView/CustomView.dart';
import '../../../helper/mycolor/mycolor.dart';
class AppointmentBookedSucces extends StatefulWidget {
  const AppointmentBookedSucces({Key? key}) : super(key: key);

  @override
  State<AppointmentBookedSucces> createState() => _AppointmentBookedSuccesState();
}

class _AppointmentBookedSuccesState extends State<AppointmentBookedSucces> {
  CustomView custom = CustomView();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async{
        return await Get.toNamed(RouteHelper.getBottomNavigation());
      },
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          decoration:  const BoxDecoration(
            gradient: LinearGradient(
                begin:  Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  MyColor.primary,
                  MyColor.secondary
                ]
            ),
          ),
          child: Center(
            child: Column(

              children: [
                SizedBox(
                  height: height*0.2,
                ),
                Image(
                  image: const AssetImage('assets/images/MEDICAlogo.png'),
                  height: height*0.2,
                  width: widht*0.4,
                ),
                SizedBox(height: height*0.04,),
                Align(
                    alignment: Alignment.center,
                    child: custom.text("Appointment correctly saved!", 20, FontWeight.w500, MyColor.white)),
                SizedBox(height: height*0.01,),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Align(
                      alignment: Alignment.center,
                      child: custom.text("You can find your booking in the pending section. Attention! This is a booking request. Wait for the doctor to confirm your booking. You will receive a notification and a confirmation email.", 12, FontWeight.normal, MyColor.white)),
                ),
                 SizedBox(
                  height: height*0.25,
                ),
                custom.MyButton(context, "Let’s go", () {
                  Get.offAllNamed(RouteHelper.getBottomNavigation());
                }, MyColor.white,
                    const TextStyle(color: MyColor.primary,fontSize: 16,fontFamily: "Poppins",letterSpacing: 0.8))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

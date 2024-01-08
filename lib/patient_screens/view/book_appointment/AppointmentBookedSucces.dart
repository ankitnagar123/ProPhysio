import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../doctor_screens/controller/RoutCtr.dart';
import '../../../helper/CustomView/CustomView.dart';
import '../../../helper/mycolor/mycolor.dart';
import '../../../language_translator/LanguageTranslate.dart';
import '../patient_main_screen/PatientMainScreen.dart';
import '../patient_main_screen/booking_history_page/PBookingPageHistory.dart';
class AppointmentBookedSucces extends StatefulWidget {
  const AppointmentBookedSucces({Key? key}) : super(key: key);

  @override
  State<AppointmentBookedSucces> createState() => _AppointmentBookedSuccesState();
}

class _AppointmentBookedSuccesState extends State<AppointmentBookedSucces> {
  CustomView custom = CustomView();
LocalString text = LocalString();
  MyRoute myRoute = Get.put(MyRoute());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async{
        setState(() {
          myRoute.pageIndex.value = 1;
        });
        return await Get.toNamed(RouteHelper.getBottomNavigation());
      },
      child: Scaffold(
        body: Column(
          children: [
            Center(
              child: Container(
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

                    children: [
                      SizedBox(
                        height: height*0.2,
                      ),
                      Image(
                        image: AssetImage("assets/images/prologo.png"),
                        height: 100,

                      ),
                      SizedBox(height: height*0.04,),
                      Align(
                          alignment: Alignment.center,
                          child: custom.text(text.appointmentCorrectlySaved.tr, 18, FontWeight.w500, MyColor.white)),
                      SizedBox(height: height*0.01,),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Align(
                            alignment: Alignment.center,
                            child: custom.text(text.youCanFindYourBooking.tr, 12, FontWeight.normal, MyColor.white)),
                      ),
                       SizedBox(
                        height: height*0.25,
                      ),
                      custom.MyButton(context, text.letGo.tr, () {
                        setState(() {
                          myRoute.pageIndex.value = 1;
                        });
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PatientMainScreen()));                      }, MyColor.white,
                          const TextStyle(color: MyColor.primary1,fontSize: 16,fontFamily: "Poppins",letterSpacing: 0.8))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

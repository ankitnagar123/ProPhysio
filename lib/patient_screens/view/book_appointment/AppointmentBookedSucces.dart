import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../doctor_screens/controller/RoutCtr.dart';
import '../../../helper/CustomView/CustomView.dart';
import '../../../helper/mycolor/mycolor.dart';
import '../../../language_translator/LanguageTranslate.dart';
import '../IntakeForm/intake_form_screen.dart';
import '../patient_main_screen/PatientMainScreen.dart';
import '../patient_main_screen/booking_history_page/PBookingPageHistory.dart';

class AppointmentBookedSucces extends StatefulWidget {
  const AppointmentBookedSucces({Key? key}) : super(key: key);

  @override
  State<AppointmentBookedSucces> createState() =>
      _AppointmentBookedSuccesState();
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
      onWillPop: () async {
        setState(() {
          myRoute.pageIndex.value = 1;
        });
        return await Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const PatientMainScreen()));
      },
      child: Scaffold(
        body: Column(
          children: [
            Center(
              child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [MyColor.primary, MyColor.primary1]),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  myRoute.pageIndex.value = 1;
                                });
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PatientMainScreen()));
                              },
                              child: Container(
                                height: 27,
                                width: 40,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: Colors.white,
                                ),
                                child: Center(
                                    child: custom.text("SKIP", 16,
                                        FontWeight.w500, MyColor.primary1)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.2,
                        ),
                        Image(
                          image: AssetImage("assets/images/prologo.png"),
                          height: 100,
                        ),
                        SizedBox(
                          height: height * 0.04,
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: custom.text(
                                text.appointmentCorrectlySaved.tr,
                                18,
                                FontWeight.w500,
                                MyColor.white)),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Align(
                              alignment: Alignment.center,
                              child: custom.text(text.youCanFindYourBooking.tr,
                                  12, FontWeight.normal, MyColor.white)),
                        ),
                        SizedBox(
                          height: height * 0.25,
                        ),
                        custom.MyButton(context, "Fill Intake form", () {
                          // setState(() {
                          //   myRoute.pageIndex.value = 1;
                          // });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const IntakeFormScreen()));
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             const PatientMainScreen()));
                        },
                            MyColor.white,
                            const TextStyle(
                                color: MyColor.primary1,
                                fontSize: 16,
                                fontFamily: "Poppins",
                                letterSpacing: 0.8))
                      ],
                    ),
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/patient_screens/view/patient_payment_screen/PatientCheckOutCard.dart';

import '../../../helper/CustomView/CustomView.dart';
import '../../../helper/mycolor/mycolor.dart';
import '../../../language_translator/LanguageTranslate.dart';
import '../../controller/auth_controllers/PatientProfileController.dart';
import "../../controller/auth_controllers/card_controller's/PatientCardController.dart";

class HealthCardScreen extends StatefulWidget {
  String timeid, price, date, centerId;

  HealthCardScreen(
      {Key? key,
      required this.timeid,
      required this.price,
      required this.date,
      required this.centerId})
      : super(key: key);

  @override
  State<HealthCardScreen> createState() => _HealthCardScreenState();
}

class _HealthCardScreenState extends State<HealthCardScreen> {
  TextEditingController healthcodeCtr = TextEditingController();
  PatientProfileCtr profileCtr = Get.put(PatientProfileCtr());
  CardCtr cardCtr = Get.put(CardCtr());
  LocalString text = LocalString();
  String? price;
  String? time;
  String? date;
  String centerId = "";
  CustomView custom = CustomView();

  @override
  void initState() {
    super.initState();
    cardCtr.cardFetch();
    profileCtr.patientProfile(context);
    price = widget.price;
    time = widget.timeid;
    date = widget.date;
    centerId = widget.centerId;

    print("center id $centerId");
    print("date$date");
    print("price$price");
    print("time slot$time");
    healthcodeCtr.text = profileCtr.healthCard.value;
    print("my health Card${healthcodeCtr.text.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: custom.MyButton(context, text.confirmAppointment.tr, () {
          if (healthcodeCtr.text.isEmpty) {
            custom.MySnackBar(context, text.Heath_Card_Code.tr);
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PatientCheckOutCard(
                  price: price.toString(),
                  time: time.toString(),
                  healthCard: healthcodeCtr.text.toString(),
                  date: date.toString(),
                  centerId: centerId,
                ),
              ),
            );
          }

          // Get.back();
        }, MyColor.primary,
            const TextStyle(color: MyColor.white, fontFamily: "Poppins")),
      ),
      appBar: AppBar(
      backgroundColor: Colors.white24,
      leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back_ios, color: MyColor.black)),
      elevation: 0,
      centerTitle: true,
      title: custom.text(
          text.appointment.tr, 17, FontWeight.w500, MyColor.black),
    ),
      body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
            children: [
            const Divider(),
            SizedBox(
            height: height * 0.02,
            ),
            custom.text(text.weNeedYourHealthCardCode.tr, 12, FontWeight.normal,
            MyColor.black),
            SizedBox(
            height: height * 0.04,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: custom.text(
                  text.Heath_Card_Code.tr, 13, FontWeight.w500, MyColor.black),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            custom.myField(context, healthcodeCtr, "ex. BRCTMS01T67B333K",
                TextInputType.emailAddress),
          ],
        ),
      ),
    );
  }
}

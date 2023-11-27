import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../../language_translator/LanguageTranslate.dart';
import '../../../../controller/CaculateEarningCtr.dart';

class CalculateEarning extends StatefulWidget {
  const CalculateEarning({Key? key}) : super(key: key);

  @override
  State<CalculateEarning> createState() => _CalculateEarningState();
}

class _CalculateEarningState extends State<CalculateEarning> {
  CustomView custom = CustomView();
  LocalString text = LocalString();

  TextEditingController endDateController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  DoctorEarningCtr doctorEarningCtr = Get.put(DoctorEarningCtr());

  void clearText() {
    endDateController.clear();
    startDateController.clear();
  }

  String _displayText(DateTime? date) {
    if (date != null) {
      return date.toString().split(' ')[0];
    } else {
      return '';
    }
  }

  DateTime? startDate, endData;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white24,
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: MyColor.black,
              )),
          elevation: 0,
          centerTitle: true,
          title: custom.text(
              text.calculateEarnings.tr, 17, FontWeight.w500, MyColor.black),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
          ),
          child: Column(
            children: [
              const Divider(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  custom.text(
                      text.totalEarning.tr, 14, FontWeight.w500, MyColor.black),
                  const SizedBox(width: 3,),
                  custom.text("€ ${doctorEarningCtr.earning.value.totalAmount}",
                      14, FontWeight.w500, MyColor.lightblue),
                ],
              ),
              const Divider(height: 25.0),
              SizedBox(
                height: height * 0.02,
              ),
              custom.text(text.calculateYourEarningSelectedPeriod.tr, 14,
                  FontWeight.normal, MyColor.black),
              SizedBox(height: height * 0.04),
              Align(
                alignment: Alignment.topLeft,
                child:
                custom.text(text.startDate.tr, 14, FontWeight.w500, MyColor.black),
              ),
              const SizedBox(
                height: 2.0,
              ),
              Container(
                  height: 45.0,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 0.9,
                  padding: const EdgeInsets.only(left: 10.0, bottom: 5),
                  margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(7)),
                  child: TextFormField(
                    onTap: () async {
                      startDate = await pickDate();
                      startDateController.text = _displayText(startDate);
                      setState(() {});
                    },
                    readOnly: true,
                    controller: startDateController,
                    decoration:  InputDecoration(
                      hintText: text.Select_Date.tr,
                      hintStyle: const TextStyle(fontSize: 15),
                      suffixIcon:
                      const Icon(Icons.calendar_month, color: MyColor.primary),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  )),
              SizedBox(height: height * 0.04),
              Align(
                alignment: Alignment.topLeft,
                child:
                custom.text(text.endDate.tr, 14, FontWeight.w500, MyColor.black),
              ),
              const SizedBox(
                height: 2.0,
              ),
              Container(
                  height: 45.0,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 0.9,
                  padding: const EdgeInsets.only(left: 10.0, bottom: 3.0),
                  margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(7)),
                  child: TextFormField(
                    onTap: () async {
                      endData = await pickDate();
                      endDateController.text = _displayText(endData);
                      print(endDateController.text);
                      setState(() {});
                    },
                    readOnly: true,
                    controller: endDateController,
                    decoration:  InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: text.Select_Date.tr,
                        suffixIcon: const Icon(
                          Icons.calendar_month,
                          color: MyColor.primary,
                        )),
                  )),
              SizedBox(
                height: height * 0.1,
              ),
              doctorEarningCtr.loading.value
                  ? Center(
                child: custom.MyIndicator(),
              )
                  : custom.MyButton(context, text.calculate.tr, () {
                if (validation()) {
                  doctorEarningCtr.fetchEarning(
                      startDateController.text, endDateController.text, () {
                    Get.toNamed(RouteHelper.DEarningListScreen());
                  });
                }
              },
                  MyColor.red,
                  const TextStyle(
                      color: MyColor.white,
                      fontSize: 15,
                      fontFamily: "Poppins",
                      letterSpacing: 0.8)),
              SizedBox(
                height: height * 0.027,
              ),
              TextButton(
                onPressed: () {
                  clearText();
                },
                child:  Text(
                  text.resetRangeDate.tr,
                  style: const TextStyle(
                      color: Colors.red,
                      fontFamily: "Poppins",
                      decoration: TextDecoration.underline,
                      fontSize: 13.0),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  //*******date strt end************//
  Future<DateTime?> pickDate() async {
    return await showDatePicker(

      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1999),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: MyColor.primary, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.brown, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: MyColor.primary, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }

  bool validation() {
    if (startDateController.text.isEmpty) {
      custom.MySnackBar(context, text.startDate.tr);
    } else if (endDateController.text.isEmpty) {
      custom.MySnackBar(context,text.endDate.tr);
    } else {
      return true;
    }
    return false;
  }
}

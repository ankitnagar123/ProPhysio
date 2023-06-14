import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/Helper/RoutHelper/RoutHelper.dart';

import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/mycolor/mycolor.dart';

class CenterEarningCalculate extends StatefulWidget {
  const CenterEarningCalculate({Key? key}) : super(key: key);

  @override
  State<CenterEarningCalculate> createState() => _CenterEarningCalculateState();
}

class _CenterEarningCalculateState extends State<CenterEarningCalculate> {
  CustomView custom = CustomView();
  TextEditingController endDateController = TextEditingController();
  TextEditingController startDateController = TextEditingController();

  void clearText() {
    endDateController.clear();
    startDateController.clear();
  }

  String _displayText(DateTime? date) {
    if (date != null) {
      return date.toString().split(' ')[0];
    } else {
      return 'Choose The Date';
    }
  }

  DateTime? startDate, endData;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final widht = MediaQuery
        .of(context)
        .size
        .width;
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
            "Calculate earnings", 17, FontWeight.w500, MyColor.black),
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
                    "Total earning", 14, FontWeight.w500, MyColor.black),
                /*custom.text(
                      "${doctorEarningCtr.earning.value.startDate.month}/"
                          "${doctorEarningCtr.earning.value.startDate.day}/"
                          "${doctorEarningCtr.earning.value.startDate.year}-"
                          "${doctorEarningCtr.earning.value.endDate.month}/"
                          "${doctorEarningCtr.earning.value.endDate.day}/"
                          "${doctorEarningCtr.earning.value.endDate.year}",
                      13,
                      FontWeight.normal,
                      MyColor.black),*/
                const SizedBox(width: 3,),
                custom.text("€",
                    14, FontWeight.w500, MyColor.lightblue),
              ],
            ),
            const Divider(height: 25.0),
            SizedBox(
              height: height * 0.02,
            ),
            custom.text("Calculate your earning in a selected period.", 14,
                FontWeight.normal, MyColor.black),
            SizedBox(height: height * 0.04),
            Align(
              alignment: Alignment.topLeft,
              child:
              custom.text("Start date", 14, FontWeight.w500, MyColor.black),
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
                  decoration: const InputDecoration(
                    hintText: "Select Date",
                    hintStyle: TextStyle(fontSize: 15),
                    suffixIcon:
                    Icon(Icons.calendar_month, color: MyColor.primary),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                )),
            SizedBox(height: height * 0.04),
            Align(
              alignment: Alignment.topLeft,
              child:
              custom.text("End date", 14, FontWeight.w500, MyColor.black),
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
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      // labelText: 'Passward',
                      hintText: "select date",
                      suffixIcon: Icon(
                        Icons.calendar_month,
                        color: MyColor.primary,
                      )),
                )),
            SizedBox(
              height: height * 0.1,
            ),
            custom.MyButton(context, "Calculate", () {
              Get.toNamed(RouteHelper.cEarningLists());
             /* if (validation()) {
                doctorEarningCtr.fetchEarning(
                    startDateController.text, endDateController.text, () {
                  Get.toNamed(RouteHelper.DEarningListScreen());
                });*/
              // }
            },
                MyColor.primary,
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
              child: const Text(
                "Reset range date",
                style: TextStyle(
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

  }

  //*******date strt end************//
  Future<DateTime?> pickDate() async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1999),
      lastDate: DateTime(2999),
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
      custom.MySnackBar(context, "Select start date");
    } else if (endDateController.text.isEmpty) {
      custom.MySnackBar(context, "Select end date");
    } else {
      return true;
    }
    return false;
  }
}

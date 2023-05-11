import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../helper/AppConst.dart';
import '../../../helper/CustomView/CustomView.dart';
import '../../../helper/mycolor/mycolor.dart';
class PatientPriceRangeFilter extends StatefulWidget {
  const PatientPriceRangeFilter({Key? key}) : super(key: key);

  @override
  State<PatientPriceRangeFilter> createState() => _PatientPriceRangeFilterState();
}

class _PatientPriceRangeFilterState extends State<PatientPriceRangeFilter> {
  RangeValues _currentRangeValues = const RangeValues(0, 0);

  CustomView custom = CustomView();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white24,
        title: custom.text("Price range", 17, FontWeight.bold, MyColor.black),
        leading: IconButton(
          onPressed: () {
            Get.offNamed(RouteHelper.getFilterScreen());
          },
          icon: const Icon(Icons.close_outlined, color: MyColor.black),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: custom.MyButton(context, "Set price", () {
          Get.offNamed(RouteHelper.getFilterScreen());
        }, MyColor.primary,
            const TextStyle(color: MyColor.white, fontFamily: "Poppins")),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            const Divider(),
            SizedBox(
              height: height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                custom.text("Select price range", 15, FontWeight.w500, MyColor.black),
                custom.text("${_currentRangeValues.start.round().toString()}€ - ${_currentRangeValues.end.round().toString()}€", 15, FontWeight.w600, MyColor.lightblue),
              ],
            ),
            RangeSlider(
              activeColor: MyColor.lightblue,
              values: _currentRangeValues,
              max: 2000,
              divisions: 20,
              labels: RangeLabels(
                _currentRangeValues.start.round().toString(),
                _currentRangeValues.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentRangeValues = values;
                  log(_currentRangeValues.start.round().toString());
                  log(_currentRangeValues.end.round().toString());
                  /*=================*/
                  AppConst.priceRangeStart = _currentRangeValues.start.round().toString();
                  AppConst.priceRangeEnd = _currentRangeValues.end.round().toString();
                  print(" app const =${AppConst.priceRangeEnd}");
                  print(" app const =${AppConst.priceRangeStart}");

                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

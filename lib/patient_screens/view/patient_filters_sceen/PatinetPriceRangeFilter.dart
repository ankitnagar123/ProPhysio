import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../helper/AppConst.dart';
import '../../../helper/CustomView/CustomView.dart';
import '../../../helper/mycolor/mycolor.dart';
import '../../../language_translator/LanguageTranslate.dart';
import '../../controller/doctor_list_ctr/DoctorListController.dart';
import '../patient_main_screen/patient_home_page/category_sub-category/DoctorListwithCategoy.dart';

class PatientPriceRangeFilter extends StatefulWidget {
  const PatientPriceRangeFilter({Key? key}) : super(key: key);

  @override
  State<PatientPriceRangeFilter> createState() =>
      _PatientPriceRangeFilterState();
}

class _PatientPriceRangeFilterState extends State<PatientPriceRangeFilter> {

  DoctorListCtr doctorListCtr = Get.put(DoctorListCtr());
  RangeValues _currentRangeValues = const RangeValues(0, 0);
  LocalString text = LocalString();

  CustomView custom = CustomView();
  var cat = "";

  var subCat = "";
  String startRange = "";
String endRange = "";
  @override
  void initState() {
    super.initState();
    cat = Get.parameters['cat'].toString();
    subCat = Get.parameters['subCat'].toString();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white24,
        title: custom.text(
            text.price_Range.tr, 17, FontWeight.bold, MyColor.black),
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
        child: custom.MyButton(context, text.setPrice.tr, () {
        /*  doctorListCtr.doctorlistfetch(
              context,
              cat,
              subCat,
              _currentRangeValues.start.round().toString(),
              _currentRangeValues.end.round().toString(),
              "",
              "",
              "",
              "");*/
          /*Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => DoctorListWithCategory(
                    catId: cat,
                    subCatId: subCat,
                    startPrice: startRange,
                    EndPrice:  endRange, rating: '',
                  )));*/
          // Get.offNamed(RouteHelper.getFilterScreen());
        }, MyColor.red,
            const TextStyle(color: MyColor.white, fontFamily: "Poppins")),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
             const Divider(color: Colors.grey),
            SizedBox(
              height: height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                custom.text(text.selectPriceRange.tr, 15, FontWeight.w500,
                    MyColor.black),
                custom.text("${_currentRangeValues.start.round()
                    .toString()}€ - ${_currentRangeValues.end.round()
                    .toString()}€", 15, FontWeight.w600, MyColor.lightblue),
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
                 startRange = _currentRangeValues.start.round()
                      .toString();
                endRange = _currentRangeValues.end.round()
                      .toString();
                  /*AppConst.priceRangeStart = _currentRangeValues.start.round()
                      .toString();
                  AppConst.priceRangeEnd = _currentRangeValues.end.round()
                      .toString();*/
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

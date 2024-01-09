import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:prophysio/helper/sharedpreference/SharedPrefrenc.dart';

import '../../../../../../../helper/CustomView/CustomView.dart';
import '../../../../../../../helper/mycolor/mycolor.dart';
import '../../../../../../language_translator/LanguageTranslate.dart';
import '../../../../../../patient_screens/controller/patinet_center_controller/PCenterController.dart';
import '../doctorViewAvailability/DoctorViewCalenderSlot.dart';

class AddAvailabilityTab extends StatefulWidget {
  const AddAvailabilityTab({
    super.key,
  });

  @override
  State<AddAvailabilityTab> createState() => _AddAvailabilityTabState();
}

class _AddAvailabilityTabState extends State<AddAvailabilityTab>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  PCenterCtr pCenterCtr = PCenterCtr();
  SharedPreferenceProvider sp =SharedPreferenceProvider();
  LocalString text = LocalString();
String? branchId;
  @override
  void initState() {
    super.initState();
    getBranch();
    log("message$branchId");
    tabController = TabController(length: 1, vsync: this, initialIndex: 0);
  }

  CustomView custom = CustomView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: MyColor.white,
         toolbarHeight: 10,
        bottom: TabBar(
          controller: tabController,
          indicatorColor: MyColor.primary,
          indicatorWeight: 2,
          tabs: [
            Tab(
              child: custom.text("Add Availability", 14, FontWeight.w500, MyColor.black),
            ),
            // Tab(
            //   child: Tab(
            //     child: custom.text(
            //         text.medicalCenter.tr, 14, FontWeight.w500, MyColor.black),
            //   ),
            // ),
          ],
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 17),
          child: Stack(children: [
            TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: tabController, children: const [
              DoctorViewCalender(centerId: ""),
              // MyAvailability(),
              // DoctorCenterAddAvailability(),
            ]),
          ])),
    );
  }
  getBranch()async{
    branchId = await sp.getStringValue(sp.DOCTOR_BRANCH_ID_KEY);
  }
}

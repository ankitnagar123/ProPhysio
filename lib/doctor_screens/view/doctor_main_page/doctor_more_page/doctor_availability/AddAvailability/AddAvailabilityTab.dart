import 'package:flutter/material.dart';

import '../../../../../../../helper/CustomView/CustomView.dart';
import '../../../../../../../helper/mycolor/mycolor.dart';
import '../../../../../../language_translator/LanguageTranslate.dart';
import '../../../../../../patient_screens/controller/patinet_center_controller/PCenterController.dart';
import 'DoctorCenterAddAvailability.dart';
import 'DoctorSelfAddAvailability.dart';
import 'package:get/get.dart';
class AddAvailabilityTab extends StatefulWidget {
  const AddAvailabilityTab({
    Key? key,
  }) : super(key: key);

  @override
  State<AddAvailabilityTab> createState() => _AddAvailabilityTabState();
}

class _AddAvailabilityTabState extends State<AddAvailabilityTab>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  PCenterCtr pCenterCtr = PCenterCtr();
  LocalString text = LocalString();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
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
              child: custom.text(text.self.tr, 14, FontWeight.w500, MyColor.black),
            ),
            Tab(
              child: Tab(
                child: custom.text(
                    text.medicalCenter.tr, 14, FontWeight.w500, MyColor.black),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 17),
          child: Stack(children: [
            TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: tabController, children: const [
              MyAvailability(),
              DoctorCenterAddAvailability(),
            ]),
          ])),
    );
  }
}

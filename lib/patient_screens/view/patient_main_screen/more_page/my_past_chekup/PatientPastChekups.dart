import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../../helper/CustomView/CustomView.dart';
import '../../../../../../helper/mycolor/mycolor.dart';
import '../../../../../doctor_screens/controller/prescriptionAddFetchCtr/DoctorPrescriptionCtr.dart';
import 'MediclaReport.dart';
import 'Prescription.dart';

class PPrescriptionMedicalTab extends StatefulWidget {
  const PPrescriptionMedicalTab({
    Key? key,
  }) : super(key: key);

  @override
  State<PPrescriptionMedicalTab> createState() =>
      _PPrescriptionMedicalTabState();
}

class _PPrescriptionMedicalTabState extends State<PPrescriptionMedicalTab>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  DoctorPrescriptionCtr doctorPrescriptionCtr =
      Get.put(DoctorPrescriptionCtr());

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }
  TextEditingController searchCtr = TextEditingController();
  CustomView custom = CustomView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white24,
        flexibleSpace: Container(),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: MyColor.primary.withOpacity(0.60)),
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Get.back();
            },child: const Icon(Icons.arrow_back_ios_new_outlined,color: Colors.black,size: 18)),
        toolbarHeight: 40,
actions: [
  Icon(Icons.qr_code_2)
],        bottom: TabBar(
          controller: tabController,
          indicatorColor: MyColor.primary,
          indicatorWeight: 2,
          tabs: [
            Tab(
              child: custom.text(
                  "Prescription", 14, FontWeight.w500, MyColor.black),
            ),
            Tab(
              child: custom.text(
                  "Medical Test", 14, FontWeight.w500, MyColor.black),
            ),
          ],
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 17),
          child: Stack(children: [
            TabBarView(controller: tabController, children: const [
              PatientPrescription(),
              PatientMedicalReport(),
            ]),
          ])),
    );
  }
}

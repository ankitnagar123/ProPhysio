import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../helper/CustomView/CustomView.dart';
import '../../../../../../helper/mycolor/mycolor.dart';
import '../../../../../language_translator/LanguageTranslate.dart';
import 'MediclaReport.dart';
import 'PatientViewMedicines.dart';
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

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  TextEditingController searchCtr = TextEditingController();
  CustomView custom = CustomView();
  LocalString text = LocalString();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: custom.text(text.yourReport.tr, 15.0, FontWeight.w500, Colors.black),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Container(
              color: Colors.grey.shade100,
              child: TabBar(
                labelPadding: const EdgeInsets.all(8),
                indicator: const BoxDecoration(
                  color: MyColor.primary,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                controller: tabController,
                indicatorWeight: 0,
                tabs:  [
                  Tab(
                      child: Text(text.prescription.tr,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "Poppins"),)
                  ),
                  Tab(
                    child: Text(text.medicalTest.tr,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "Poppins"),),
                  ),
                  Tab(
                    child: Text(text.medicines.tr,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "Poppins"),),
                  ),
                ],
              ),
            ),
            Expanded(child:  Padding(
              padding: const EdgeInsets.all(12.0),
              child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: const [
                    PatientPrescription(),
                    PatientMedicalReport(),
                    PatientViewMedicines(),
                  ]),
            ),),

          ],
        ),
      ),
    );
  }
}

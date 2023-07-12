import 'package:flutter/material.dart';

import '../../../../../../helper/CustomView/CustomView.dart';
import '../../../../../../helper/mycolor/mycolor.dart';
import '../../../../../../language_translator/LanguageTranslate.dart';
import 'AddMedicines/AddMedicinesTab.dart';
import 'MedicalTestAddList.dart';
import 'PrescriptionAddandList.dart';
import 'package:get/get.dart';
class PrescriptionMedicalTab extends StatefulWidget {
  String patientId,patientName;

  PrescriptionMedicalTab({
    Key? key,
    required this.patientId,
    required this.patientName,

  }) : super(key: key);

  @override
  State<PrescriptionMedicalTab> createState() => _PrescriptionMedicalTabState();
}

class _PrescriptionMedicalTabState extends State<PrescriptionMedicalTab>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  String pId = "";
LocalString text = LocalString();
  @override
  void initState() {
    pId = widget.patientId;
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  TextEditingController searchCtr = TextEditingController();
  CustomView custom = CustomView();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
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
        title: custom.text("${widget.patientName} ${text.reports.tr}", 15.0, FontWeight.w500, Colors.black),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey.shade100,
            child:  TabBar(
              labelPadding: const EdgeInsets.all(8),
              indicator: const BoxDecoration(
                color: MyColor.primary,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              controller: tabController,
              indicatorWeight: 0,
                  tabs: const [
                    Tab(
                      child: Text("Prescription",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "Poppins"),)
                    ),
                    Tab(
                      child: Text("Medical Test",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "Poppins"),),
                    ),
                    Tab(
                      child: Text("Medicines",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "Poppins"),),
                    ),
                  ],
                ),
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Stack(children: [
                  TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: tabController, children: [
                    PrescriptionAddAndList(patientId: pId),
                    MedicalAddAndList(patientId: pId),
                    AddMedicinesTab(patientId: pId,),
                  ]),
                ])),
          ),
        ],
      ),
    );
  }
}

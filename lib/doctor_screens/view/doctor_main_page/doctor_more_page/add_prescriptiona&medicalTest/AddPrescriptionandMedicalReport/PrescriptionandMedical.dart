import 'package:flutter/material.dart';

import '../../../../../../helper/CustomView/CustomView.dart';
import '../../../../../../helper/mycolor/mycolor.dart';
import '../../../../../../language_translator/LanguageTranslate.dart';
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
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  TextEditingController searchCtr = TextEditingController();
  CustomView custom = CustomView();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            child: Divider(
              color: Colors.grey,
            ),
            preferredSize: Size.fromHeight(0)),
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
          SizedBox(
            height: 47,
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              padding: EdgeInsets.only(left: 3,right: 3,bottom: 5),
              labelPadding: const EdgeInsets.all(7.0),
              indicatorColor: MyColor.red,
              labelColor: Colors.white,
              indicator:  BoxDecoration(color: MyColor.red.withOpacity(0.5),borderRadius: BorderRadius.circular(25),),
              unselectedLabelColor: Colors.black,

              controller: tabController,
                  tabs:  [
                    Tab(
                      child: Text(text.prescription.tr,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "Poppins"),)
                    ),
                    Tab(
                      child: Text(text.medicalTest.tr,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "Poppins"),),
                    ),
                    /*Tab(
                      child: Text(text.medicines.tr,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "Poppins"),),
                    ),*/
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
                    // AddMedicinesTab(patientId: pId,),
                  ]),
                ])),
          ),
        ],
      ),
    );
  }
}

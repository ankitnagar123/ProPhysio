import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/doctor_screens/controller/prescriptionAddFetchCtr/DoctorPrescriptionCtr.dart';

import '../../../../../../../helper/CustomView/CustomView.dart';
import '../../../../../../../helper/mycolor/mycolor.dart';

class DrViewMedicines extends StatefulWidget {
  String patientId;

  DrViewMedicines({
    Key? key,
    required this.patientId,
  }) : super(key: key);

  @override
  State<DrViewMedicines> createState() => _DrViewMedicinesState();
}

class _DrViewMedicinesState extends State<DrViewMedicines> {
  TextEditingController titleCtr = TextEditingController();
  TextEditingController discCtr = TextEditingController();
  CustomView custom = CustomView();
  DoctorPrescriptionCtr doctorPrescriptionCtr =
      Get.put(DoctorPrescriptionCtr());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Card(
                color: MyColor.midgray,
                child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    title: Row(
                      children: [
                        custom.text(
                            "Medicines", 16, FontWeight.w400, MyColor.primary1),
                        SizedBox(
                          width: 3,
                        ),
                        custom.text(
                            "100 mg", 13, FontWeight.normal, MyColor.primary1),
                      ],
                    ),
                    subtitle: const Text(
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Poppins",
                      ),
                      "list.description hi how are you on the, sutbrt, t iuog giviuerg ",
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Text("data")),
              );
            },
          )
        ],
      )),
    );
  }


}

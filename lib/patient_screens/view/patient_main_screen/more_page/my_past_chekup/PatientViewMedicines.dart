import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/doctor_screens/controller/prescriptionAddFetchCtr/DoctorPrescriptionCtr.dart';

import '../../../../../../../helper/CustomView/CustomView.dart';
import '../../../../../../../helper/mycolor/mycolor.dart';

class PatientViewMedicines extends StatefulWidget {
  const PatientViewMedicines({
    Key? key,
  }) : super(key: key);

  @override
  State<PatientViewMedicines> createState() => _PatientViewMedicinesState();
}

class _PatientViewMedicinesState extends State<PatientViewMedicines> {
  CustomView custom = CustomView();
  DoctorPrescriptionCtr doctorPrescriptionCtr =
      Get.put(DoctorPrescriptionCtr());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      doctorPrescriptionCtr.patientFetchmedicineList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
          child: Column(
        children: [
          doctorPrescriptionCtr.pLoadingMedicineFetch.value
              ? Center(heightFactor: 13, child: custom.MyIndicator())
              : doctorPrescriptionCtr.patientFetchMedicineList.isEmpty?const Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(heightFactor: 15,child: Text("No Medicines right know")),
          ): ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      doctorPrescriptionCtr.patientFetchMedicineList.length,
                  itemBuilder: (context, index) {
                    var list = doctorPrescriptionCtr.patientFetchMedicineList[index];
                    return Card(
                      color: MyColor.midgray,
                      child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          title: custom.text(list.medicineName, 16,
                              FontWeight.w400, MyColor.primary1),
                          subtitle: Text(
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: "Poppins",
                            ),
                            list.description,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Column(
                            children: [
                              custom.text(
                                  "Submitted by",
                                  14,
                                  FontWeight.normal,
                                  MyColor.black),
                              custom.text(
                                  "${list.doctorName} ${list.doctorSurname}",
                                  13,
                                  FontWeight.normal,
                                  MyColor.primary1)
                            ],
                          )),
                    );
                  },
                )
        ],
      ));
    });
  }
}

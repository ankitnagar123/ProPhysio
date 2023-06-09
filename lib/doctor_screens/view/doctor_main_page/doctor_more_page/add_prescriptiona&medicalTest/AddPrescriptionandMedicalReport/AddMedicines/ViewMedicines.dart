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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      doctorPrescriptionCtr.AddFetchmedicineListAll(widget.patientId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: SingleChildScrollView(
            child: Column(
          children: [
            doctorPrescriptionCtr.loadingMedicineFetch.value
                ? Center(heightFactor: 13, child: custom.MyIndicator())
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: doctorPrescriptionCtr.fetchMedicineList.length,
                    itemBuilder: (context, index) {
                      var list = doctorPrescriptionCtr.fetchMedicineList[index];
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
                            trailing: Text(list.medicineSlot)),
                      );
                    },
                  )
          ],
        )),
      );
    });
  }
}

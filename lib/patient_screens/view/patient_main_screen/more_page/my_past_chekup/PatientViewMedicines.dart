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
                    var medicineName = list.medicineName;
                    var medicineTime = list.medicineTiming;
                    var medicineSlot = list.medicineSlot;
                    var medicineDisc = list.description;
                    var medicineDrName = list.doctorName;
                    var medicineDrSurname = list.doctorSurname;
                    print(medicineSlot);
                    return InkWell(
                     onTap: () => showBottomSheet(medicineName.toString(),medicineSlot.toString(),medicineTime.toString(),medicineDrName.toString(),medicineDrSurname.toString(),medicineDisc.toString()),
                      child: Card(
                        color: MyColor.midgray,
                        child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            title: custom.text(list.medicineName.toString(), 16,
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
                      ),
                    );
                  },
                )
        ],
      ));
    });
  }
  showBottomSheet(String medicneName,String slot,String time,String drName,String drSurname,String dic ) {
    showModalBottomSheet(
        isDismissible: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(7.0))),
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 15.0,
                ),
                custom.text("Details", 17.0, FontWeight.w500, Colors.black),
                const SizedBox(
                  height: 7.0,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Medicines information",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11.0,
                                fontFamily: "Poppins"),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(
                              medicneName,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: "Poppins")),
                        ],
                      ),
                    ),
                     Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Slot",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11.0,
                                fontFamily: "Poppins"),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(
                            slot,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontFamily: "Poppins"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 30.0,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Timing to take",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11.0,
                                fontFamily: "Poppins"),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(time,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: "Poppins")),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 30.0,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Submitted by",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11.0,
                                fontFamily: "Poppins"),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(
                              drName+drSurname,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: "Poppins")),
                        ],
                      ),
                    ),

                  ],
                ),
                const Divider(
                  height: 30.0,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Description",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11.0,
                                fontFamily: "Poppins"),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(
                              dic,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: "Poppins")),
                        ],
                      ),
                    ),

                  ],
                ),
                const Divider(
                  height: 30.0,
                ),
              ],
            ),
          );
        });
  }
}

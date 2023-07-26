import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/doctor_screens/controller/prescriptionAddFetchCtr/DoctorPrescriptionCtr.dart';

import '../../../../../../../helper/CustomView/CustomView.dart';
import '../../../../../../../helper/mycolor/mycolor.dart';
import '../../../../../language_translator/LanguageTranslate.dart';
import 'PatinetViewPdfMedcines.dart';

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
  LocalString text = LocalString();

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
          doctorPrescriptionCtr.patientFetchMedicineList.isEmpty
              ? Text('')
              : Align(
                  alignment: Alignment.topLeft,
                  child: Card(
                    semanticContainer: true,
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: custom.text(text.Select_doctor.tr, 14,
                          FontWeight.w500, MyColor.black),
                    ),
                  ),
                ),
          SizedBox(
            height: 10.0,
          ),
          doctorPrescriptionCtr.pLoadingMedicineFetch.value
              ? Center(heightFactor: 13, child: custom.MyIndicator())
              : doctorPrescriptionCtr.patientFetchMedicineList.isEmpty
                  ? Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Center(
                          heightFactor: 15,
                          child: Text(text.noMedicinesRightKnow.tr)),
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          doctorPrescriptionCtr.patientFetchMedicineList.length,
                      itemBuilder: (context, index) {
                        var list = doctorPrescriptionCtr
                            .patientFetchMedicineList[index];
                        /*  var medicineName = list.medicineName;
                    var medicineTime = list.medicineTiming;
                    var medicineSlot = list.medicineSlot;
                    var medicineDisc = list.description;*/
                        var medicineDrName = list.doctorName;
                        var drId = list.doctorId;
                        var medicineDrSurname = list.doctorSurname;
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PatientViewMedicinesPdf(
                                          drId: drId,
                                        )));
                          },
                          // onTap: () => showBottomSheet(medicineName.toString(),medicineSlot.toString(),medicineTime.toString(),medicineDrName.toString(),medicineDrSurname.toString(),medicineDisc.toString()),
                          child: Card(
                            color: MyColor.midgray,
                            child: ListTile(
                              trailing: const Icon(Icons.arrow_forward_ios,
                                  color: MyColor.primary1, size: 20),
                              leading: const Icon(
                                  Icons.medical_services_outlined,
                                  color: MyColor.primary1),
                              contentPadding:
                                  const EdgeInsets.only(left: 10, right: 8),
                              title: custom.text(
                                  "${list.doctorName.toString()} ${list.doctorSurname.toString()}",
                                  16.5,
                                  FontWeight.w500,
                                  MyColor.primary1),
                            ),
                          ),
                        );
                      },
                    )
        ],
      ));
    });
  }

  showBottomSheet(String medicneName, String slot, String time, String drName,
      String drSurname, String dic) {
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
                custom.text(
                    text.details.tr, 17.0, FontWeight.w500, Colors.black),
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
                          Text(
                            text.medicinesInformation.tr,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11.0,
                                fontFamily: "Poppins"),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(medicneName,
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
                          Text(
                            text.slot.tr,
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
                          Text(
                            text.timingTake.tr,
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
                          Text(
                            text.submittedBy.tr,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11.0,
                                fontFamily: "Poppins"),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(drName + drSurname,
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
                          Text(
                            text.description.tr,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11.0,
                                fontFamily: "Poppins"),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(dic,
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

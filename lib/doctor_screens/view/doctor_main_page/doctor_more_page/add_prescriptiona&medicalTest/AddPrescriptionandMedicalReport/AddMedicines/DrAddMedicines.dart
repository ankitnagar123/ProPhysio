import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/doctor_screens/controller/prescriptionAddFetchCtr/DoctorPrescriptionCtr.dart';

import '../../../../../../../helper/CustomView/CustomView.dart';
import '../../../../../../../helper/mycolor/mycolor.dart';

class DrAddMedicines extends StatefulWidget {
  String patientId;

  DrAddMedicines({
    Key? key,
    required this.patientId,
  }) : super(key: key);

  @override
  State<DrAddMedicines> createState() => _DrAddMedicinesState();
}

class _DrAddMedicinesState extends State<DrAddMedicines> {
  TextEditingController medicineIdCtr = TextEditingController();
  TextEditingController discCtr = TextEditingController();
  CustomView custom = CustomView();
  DoctorPrescriptionCtr doctorPrescriptionCtr =
      Get.put(DoctorPrescriptionCtr());
  bool isAppleChecked = false;
  bool isBananaChecked = false;
  bool isCherryChecked = false;
  String selectedMedicine = "";
  String MedicineID = "";
  var selectedTime;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      doctorPrescriptionCtr.medicineListAllApi();
    });
    medicineIdCtr.text = MedicineID;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        child: Obx(() {
          if (doctorPrescriptionCtr.loadingAddMedicne.value) {
            return Center(child: custom.MyIndicator());
          }
          return custom.MyButton(context, "Save", () {
            doctorPrescriptionCtr.medicinesAdd(context, widget.patientId,
                selectedMedicine, medicineIdCtr.text, discCtr.text, "", "", () {
              Get.back();
            });
          }, MyColor.primary, TextStyle(fontSize: 17, color: MyColor.white));
        }),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Align(
            alignment: Alignment.topLeft,
            child: custom.text(
                "Medicine Name", 13, FontWeight.w500, MyColor.primary1),
          ),
          SizedBox(
            height: height * 0.005,
          ),
          centerList(),
          /*  Align(
            alignment: Alignment.topLeft,
            child: custom.text(
                "Medicine MG", 13.0, FontWeight.w500, MyColor.primary1),
          ),
          SizedBox(
            height: height * 0.005,
          ),
          custom.myField(
              context, titleCtr, "Medicine mg", TextInputType.emailAddress),*/
          SizedBox(
            height: height * 0.02,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: custom.text(
                "Medicine Id", 13.0, FontWeight.w500, MyColor.primary1),
          ),
          SizedBox(
            height: height * 0.005,
          ),
          custom.myField(context, medicineIdCtr, "Medicine id",
              TextInputType.emailAddress),
          SizedBox(
            height: height * 0.02,
          ),
          const Divider(
            height: 10,
            thickness: 1,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: custom.text(
                "Medicine Timing", 13.0, FontWeight.w500, MyColor.primary1),
          ),
          Card(
            color: MyColor.midgray,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: ListTileTheme(
                    contentPadding: EdgeInsets.all(0),
                    horizontalTitleGap: 0,
                    child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title:
                          const Text('Morning', style: TextStyle(fontSize: 13)),
                      value: isAppleChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isAppleChecked = value!;
                          print(value);
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListTileTheme(
                    contentPadding: EdgeInsets.all(0),
                    horizontalTitleGap: 0.0,
                    child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text('Afternoon',
                          style: TextStyle(fontSize: 13)),
                      value: isBananaChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isBananaChecked = value!;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListTileTheme(
                    contentPadding: EdgeInsets.all(0),
                    horizontalTitleGap: 0.0,
                    child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title:
                          const Text('Evening', style: TextStyle(fontSize: 13)),
                      value: isCherryChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isCherryChecked = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.011,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: custom.text(
                "Medicine Slot", 13.0, FontWeight.w500, MyColor.primary1),
          ),
          Card(
            color: MyColor.midgray,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: ListTileTheme(
                    contentPadding: EdgeInsets.all(0),
                    horizontalTitleGap: 0.0,
                    child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text('Before Meal',
                          style: TextStyle(fontSize: 13)),
                      value: isBananaChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isBananaChecked = value!;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListTileTheme(
                    contentPadding: EdgeInsets.all(0),
                    horizontalTitleGap: 0.0,
                    child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text('After Meal',
                          style: TextStyle(fontSize: 13)),
                      value: isCherryChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isCherryChecked = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: custom.text(
                "Description", 13.0, FontWeight.w500, MyColor.primary1),
          ),
          SizedBox(
            height: height * 0.005,
          ),
          custom.HField(
            context,
            discCtr,
            "Enter description",
            TextInputType.text,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          const Divider(
            height: 10,
            thickness: 1,
          ),
        ]),
      ),
    );
  }

  /*---------SELECT MULTIPLE CATEGORY-----*/
  Widget centerList() {
    final widht = MediaQuery.of(context).size.width;
    return StatefulBuilder(
      builder: (context, StateSetter stateSetter) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Center(
          child: Container(
            height: 40,
            width: widht * 0.90,
            padding: const EdgeInsets.only(left: 7.0, bottom: 2.5),
            margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
            decoration: BoxDecoration(boxShadow: const [
              BoxShadow(
                  color: Colors.black26, blurRadius: 1.0, spreadRadius: 1.0),
            ], color: MyColor.white, borderRadius: BorderRadius.circular(10)),
            child: DropdownButtonHideUnderline(
              child: Obx(() {
                if (doctorPrescriptionCtr.loadingMedicine.value) {
                  return Center(child: custom.MyIndicator());
                }
                return DropdownButton(
                  menuMaxHeight: MediaQuery.of(context).size.height / 3,
                  // Initial Value
                  value: selectedMedicine.isNotEmpty ? selectedMedicine : null,
                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down,
                      color: MyColor.primary),
                  // Array list of items
                  items: doctorPrescriptionCtr.allMedicineList.map((items) {
                    return DropdownMenuItem(
                      onTap: () {
                        /* setState(() {

                        });*/
                        medicineIdCtr.text = items.madcine;
                        // doctorPrescriptionCtr.allMedicineList[items].m
                      },
                      value: items.medicineId,
                      child: Text(items.medicineName),
                    );
                  }).toList(),
                  hint: const Text("Select Medicine"),
                  onChanged: (newValue) {
                    stateSetter(() {
                      selectedMedicine = newValue.toString();
                      log('MY Medicine Select>>>$selectedMedicine');
                    });
                  },
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

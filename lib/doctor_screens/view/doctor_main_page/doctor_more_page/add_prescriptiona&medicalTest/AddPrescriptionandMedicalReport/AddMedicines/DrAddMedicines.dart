import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/doctor_screens/controller/prescriptionAddFetchCtr/DoctorPrescriptionCtr.dart';

import '../../../../../../../helper/CustomView/CustomView.dart';
import '../../../../../../../helper/mycolor/mycolor.dart';
import '../../../../../../model/MedicineModel/MedicineAllListModel.dart';

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
  TextEditingController searchCtr = TextEditingController();
  DoctorPrescriptionCtr doctorPrescriptionCtr =
      Get.put(DoctorPrescriptionCtr());
  bool isAppleChecked = false;
  bool isBananaChecked = false;
  bool isCherryChecked = false;
  String selectedMedicine = "";
  String MedicineID = "";
  String _selectedGender = '';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      doctorPrescriptionCtr.medicineListAllApi();
    });
    medicineIdCtr.text = MedicineID;
    super.initState();
  }

  String _keyword = '';

  /* ----------For SEARCH Functionality*/
  List<MedicineAllListModel> _getFilteredList() {
    if (_keyword.isEmpty) {
      return doctorPrescriptionCtr.allMedicineList;
    }
    return doctorPrescriptionCtr.allMedicineList
        .where((user) =>
            user.medicineName!.toLowerCase().contains(_keyword.toLowerCase()) ||
            user.medicineId!.toLowerCase().contains(_keyword.toLowerCase()))
        .toList();
  }

  Map<String, bool> values = {
    'Morning': false,
    'Afternoon': false,
    'Evening': false,
  };
  var tmpArray = [];

  getCheckboxItems() {
    values.forEach((key, value) {
      if (value == true) {
        tmpArray.add(key);
      }
      print(tmpArray);

      tmpArray.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Obx(() {
          if (doctorPrescriptionCtr.loadingAddMedicne.value) {
            return Center(child: custom.MyIndicator());
          }
          return custom.MyButton(context, "Save", () {
            doctorPrescriptionCtr.medicinesAdd(
                context,
                widget.patientId,
                selectedMedicine,
                medicineIdCtr.text,
                discCtr.text,
                "",
                _selectedGender, () {
              selectedMedicine = "";
              medicineIdCtr.clear();
              medicineIdCtr.clear();
              discCtr.clear();
              _selectedGender = "";
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
          InkWell(
            onTap: () {
              medicinesPopUp(context);
            },
            child: Align(
              alignment: Alignment.topLeft,
              child: custom.text(
                  "Medicine Timing", 13.0, FontWeight.w500, MyColor.primary1),
            ),
          ),
          Card(
            color: MyColor.midgray,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child :
                  ListView(
                    children: values.keys.map((String key) {
                      return CheckboxListTile(
                        title: Text(key),
                        value: values[key],
                        activeColor: Colors.pink,
                        checkColor: Colors.white,
                        onChanged: ( value) {
                          setState(() {
                            values[key] = value!;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),]),
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
              children: [
                Expanded(
                  flex: 1,
                  child: ListTile(
                    horizontalTitleGap: 5,
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    leading: Radio<String>(
                      value: 'Before Meal',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                          print(_selectedGender);
                        });
                      },
                    ),
                    title: const Text('Before Meal',
                        style: TextStyle(fontSize: 14)),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListTile(
                    horizontalTitleGap: 5,
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    leading: Radio<String>(
                      value: 'After Meal',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                          print(_selectedGender);
                        });
                      },
                    ),
                    title: const Text('After Meal',
                        style: TextStyle(fontSize: 14)),
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

  /*------------Booking UPCOMING CANCEL POPUP List--------------*/
  void medicinesPopUp(
    BuildContext context,
  ) {
    final widht = MediaQuery.of(context).size.width;
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black54,
        pageBuilder: (context, anim1, anim2) {
          return Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.width / 1,
              width: MediaQuery.of(context).size.width / 1,
              child: StatefulBuilder(
                builder: (context, StateSetter stateSetter) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10.0,
                            ),
                            SizedBox(
                              width: widht,
                              child: TextFormField(
                                onChanged: (value) {
                                  stateSetter(() {
                                    _keyword = value;
                                  });
                                  print(value);
                                },
                                cursorWidth: 0.0,
                                cursorHeight: 0.0,
                                onTap: () {},
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                cursorColor: Colors.black,
                                controller: searchCtr,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.search),
                                  prefixIconColor: MyColor.primary1,
                                  contentPadding:
                                      EdgeInsets.only(top: 3, left: 20),
                                  hintText: "search medicines",
                                  hintStyle: TextStyle(
                                      fontSize: 12, color: MyColor.primary1),
                                  fillColor: MyColor.lightcolor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 13.0,
                            ),
                            medicne(),
                            /*    SingleChildScrollView(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    list.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    visualDensity: const VisualDensity(
                                        horizontal: 0, vertical: -2),
                                    leading: Text(list[index].medicineName),
                                  );
                                },
                              ),
                            ),*/
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        });
  }

  Widget medicne() {
    var list = _getFilteredList();
    return SingleChildScrollView(
        child: Obx(
      () => ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ListTile(
            visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
            leading: Text(list[index].medicineName),
          );
        },
      ),
    ));
  }
}

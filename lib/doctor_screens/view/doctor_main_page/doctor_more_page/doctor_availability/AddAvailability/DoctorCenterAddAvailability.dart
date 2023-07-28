import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../../../../../../helper/mycolor/mycolor.dart';
import '../../../../../../language_translator/LanguageTranslate.dart';
import '../../../../../../patient_screens/controller/appointment_controller/AppointmentController.dart';
import '../../../../../controller/AddAvailablityCtr.dart';
import '../doctorViewAvailability/DoctorViewCalenderSlot.dart';

class DoctorCenterAddAvailability extends StatefulWidget {
  const DoctorCenterAddAvailability({Key? key}) : super(key: key);

  @override
  State<DoctorCenterAddAvailability> createState() =>
      _DoctorCenterAddAvailabilityState();
}

class _DoctorCenterAddAvailabilityState
    extends State<DoctorCenterAddAvailability> {
  AddAvailabilityCtr addAvailabilityCtr = Get.put(AddAvailabilityCtr());
  LocalString text = LocalString();
  AppointmentController appointmentController =
  Get.put(AppointmentController());
  CustomView custom = CustomView();

  //select date's
  var selectedIndexes = [];
  var timeIdArray = [];

  String? selectedCenter;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      addAvailabilityCtr.centerSelectedList();
      addAvailabilityCtr.doctorTimeList.clear();
    });
  }

  DateTime? startDate, endDate;
  TextEditingController endDateController = TextEditingController();
  TextEditingController startDateController = TextEditingController();

  String _displayText(DateTime? date) {
    if (date != null) {
      return date.toString().split(' ')[0];
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery
        .of(context)
        .size
        .width;
    return Obx(() {
      return Scaffold(
        body: Center(
          child: Column(children: [

            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  SelectCenter(context);
                  // SelectCenter(context);

                },
                child: Card(
                  color: MyColor.midgray,
                  child: Center(child: custom.text(
                      text.viewAvailability.tr, 13, FontWeight.w500,
                      MyColor.primary1)),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(
                      text.selectMedicalCenter.tr, 14, FontWeight.w500,
                      MyColor.black)),
            ),
            centerList(),
            const SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(
                      text.startDate.tr, 14, FontWeight.w500, MyColor.black)),
            ),
            Container(
                height: 40,
                width: widht * 0.90,
                padding: const EdgeInsets.only(left: 7.0, bottom: 2.5),
                margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                decoration: BoxDecoration(boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 1.0,
                      spreadRadius: 1.0),
                ],
                    color: MyColor.white,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  onTap: () async {
                    startDate = await pickDate();
                    startDateController.text = _displayText(startDate);
                    print(startDateController.text.toString());
                  },
                  readOnly: true,
                  controller: startDateController,
                  decoration: InputDecoration(
                    hintText: text.selectSDate.tr,
                    hintStyle: TextStyle(fontSize: 15),
                    suffixIcon:
                    Icon(Icons.date_range_outlined, color: MyColor.primary),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                )),
            const SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child:
                  custom.text(
                      text.endDate.tr, 14, FontWeight.w500, MyColor.black)),
            ),
            Container(
                height: 40,
                width: widht * 0.90,
                padding: const EdgeInsets.only(left: 7.0, bottom: 2.5),
                margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                decoration: BoxDecoration(boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 1.0,
                      spreadRadius: 1.0),
                ],
                    color: MyColor.white,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  onTap: () async {
                    endDate = await pickDate();
                    endDateController.text = _displayText(endDate);
                    print(endDateController.text.toString());
                  },
                  readOnly: true,
                  controller: endDateController,
                  decoration: InputDecoration(
                    hintText: text.selectEDate.tr,
                    hintStyle: TextStyle(fontSize: 15),
                    suffixIcon:
                    Icon(Icons.date_range_outlined, color: MyColor.primary),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                )),
            const SizedBox(
              height: 20.0,
            ),
            addAvailabilityCtr.doctorTimeList.isEmpty ? Obx(
                  () =>
              addAvailabilityCtr.loadingC.value
                  ? custom.MyIndicator()
                  : custom.MyButton(context, text.Submit.tr, () {
                if (startDateController.text.isEmpty ||
                    endDateController.text.isEmpty ||
                    selectedCenter == null) {
                  custom.MySnackBar(context, text.fillAllData.tr);
                } else {
                  addAvailabilityCtr.addCenterAvailability(
                      context,
                      startDateController.text,
                      endDateController.text,
                      selectedCenter.toString(),
                          () {});
                }

                // Get.offNamed(RouteHelper.DLoginScreen());
              },
                  MyColor.primary,
                  const TextStyle(
                      color: MyColor.white,
                      fontSize: 16,
                      fontFamily: 'Heebo',
                      letterSpacing: 0.8)),
            ) : Text(""),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 10.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: addAvailabilityCtr.doctorTimeList.isEmpty
                      ? Text("")
                      : custom.text(
                      text.yourTimeSlotAccordingSelectDate.tr, 13,
                      FontWeight.w500, MyColor.black)),
            ),
            addAvailabilityCtr.loadingf.value == true
                ? custom.MyIndicator()
                : Expanded(
              child: Obx(() {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: addAvailabilityCtr.doctorTimeList.length,
                  itemBuilder: (context, index) {
                    var list = addAvailabilityCtr.doctorTimeList[index];
                    // print(id);
                    return SizedBox(
                      width: 120,
                      height: 50,
                      child: StatefulBuilder(
                        builder: (context, StateSetter setState) {
                          return Card(
                            elevation: 0.8,
                            child: CheckboxListTile(
                              activeColor: MyColor.primary,
                              dense: true,
                              title: Text(
                                  "${list.from} ${text.To.tr} ${list.to}"),
                              value: selectedIndexes.contains(index),
                              onChanged: (vale) {
                                setState(() {
                                  if (selectedIndexes.contains(index)) {
                                    selectedIndexes.remove(index);
                                    timeIdArray.remove(list.timeId);
                                    // unselect
                                  } else {
                                    selectedIndexes.add(index); // select
                                    timeIdArray.add(list.timeId);
                                  }
                                });
                                print(selectedIndexes);
                                print(timeIdArray);
                              },
                              controlAffinity:
                              ListTileControlAffinity.trailing,
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              }),
            ),
            // Obx(() {
            //   if (addAvailabilityCtr.loadingd.value) {
            //     return custom.MyIndicator();
            //   } else {
            //     return custom.acceptRejectButton(context, "Select time", () {
            //       if (timeIdArray.isNotEmpty) {
            //         addAvailabilityCtr.addTime(context, timeIdArray.join(","),
            //             addAvailabilityCtr.dateId.value, () {
            //               Get.back();
            //             });
            //       } else {
            //         log("empty");
            //       }
            //     }, MyColor.primary, const TextStyle(color: MyColor.white));
            //   }
            // }),
            const SizedBox(
              height: 15,
            ),
          ]),
        ),
        bottomNavigationBar: Obx(() =>
        addAvailabilityCtr.doctorTimeList.isEmpty
            ? const Text("")
            : Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20.0, vertical: 10),
          child: AnimatedButton(
            // width: MediaQuery.of(context).size.width * 0.8,
            text: text.Submit.tr,
            color: MyColor.primary,
            pressEvent: () {
              if (timeIdArray.isNotEmpty) {
                addAvailabilityCtr.addTime(
                    context,
                    timeIdArray.join(","),
                    addAvailabilityCtr.dateId.value, () {
                  AwesomeDialog(
                    context: context,
                    animType: AnimType.leftSlide,
                    headerAnimationLoop: false,
                    dialogType: DialogType.success,
                    showCloseIcon: true,
                    title: text.Submit.tr,
                    desc: text.centerAvailabilityAddSuccessfully.tr,
                    btnOkOnPress: () {
                      debugPrint('OnClick');
                    },
                    btnOkIcon: Icons.check_circle,
                    onDismissCallback: (type) {
                      Get.back();
                      debugPrint(
                          'Dialog Dismiss from callback $type');
                    },
                  ).show();
                });
              } else {
                custom.MySnackBar(context, text.selectSlot.tr);
                log("empty");
              }
            },
          ),

        ),
        ),
      );
    });
  }

  //*******date strt end************//
  Future<DateTime?> pickDate() async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2999),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: MyColor.primary, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.brown, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: MyColor.primary, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }

  Widget centerList() {
    final widht = MediaQuery
        .of(context)
        .size
        .width;
    return StatefulBuilder(
      builder: (context, StateSetter stateSetter) =>
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Center(
              child: Container(
                height: 40,
                width: widht * 0.90,
                padding: const EdgeInsets.only(left: 7.0, bottom: 2.5),
                margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                decoration: BoxDecoration(boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 1.0,
                      spreadRadius: 1.0),
                ],
                    color: MyColor.white,
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButtonHideUnderline(
                  child: Obx(() {
                    if (addAvailabilityCtr.loadingCenter.value) {
                      return Center(child: custom.MyIndicator());
                    }
                    return DropdownButton(
                      menuMaxHeight: MediaQuery
                          .of(context)
                          .size
                          .height / 3,
                      // Initial Value
                      value: selectedCenter,
                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down,
                          color: MyColor.primary),
                      // Array list of items
                      items: addAvailabilityCtr.selectedCenterList.map((items) {
                        return DropdownMenuItem(
                          value: items.centerId,
                          child: Text(items.name),
                        );
                      }).toList(),
                      hint: Text(text.selectMedicalCenter.tr),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (newValue) {
                        stateSetter(() {
                          selectedCenter = newValue;

                          log('MY CENTER Select>>>$selectedCenter');
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

  Widget selectCenterList() {
    final widht = MediaQuery
        .of(context)
        .size
        .width;
    return StatefulBuilder(
      builder: (context, StateSetter stateSetter) =>
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Center(
              child: Container(
                height: 40,
                width: widht * 0.90,
                padding: const EdgeInsets.only(left: 7.0, bottom: 2.5),
                margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                decoration: BoxDecoration(boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 1.0,
                      spreadRadius: 1.0),
                ],
                    color: MyColor.white,
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButtonHideUnderline(
                  child: Obx(() {
                    if (addAvailabilityCtr.loadingCenter.value) {
                      return Center(child: custom.MyIndicator());
                    }
                    return DropdownButton(
                      onTap: () {

                      },
                      menuMaxHeight: MediaQuery
                          .of(context)
                          .size
                          .height / 3,
                      // Initial Value
                      value: selectedCenter,
                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down,
                          color: MyColor.primary),
                      // Array list of items
                      items: addAvailabilityCtr.selectedCenterList.map((items) {
                        return DropdownMenuItem(
                          value: items.centerId,
                          child: Text(items.name),
                        );
                      }).toList(),
                      hint: Text(text.selectMedicalCenter.tr),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (newValue) {
                        stateSetter(() {
                          selectedCenter = newValue;
                          appointmentController.doctorViewDateCalender(
                              selectedCenter.toString());

                          log('MY CENTER Select>>>$selectedCenter');
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  DoctorViewCalender(
                                    centerId: selectedCenter.toString(),)));
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

  void SelectCenter(BuildContext context) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
        MaterialLocalizations
            .of(context)
            .modalBarrierDismissLabel,
        barrierColor: Colors.black54,
        pageBuilder: (context, anim1, anim2) {
          return Center(
            child: SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 1,
              child: StatefulBuilder(
                builder: (context, StateSetter setState) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5.0),
                            child: custom.text(text.selectMedicalCenter.tr, 17,
                                FontWeight.w500, Colors.black),
                          ),
                          const SizedBox(
                            height: 13.0,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: custom.text(
                                text.selectCenter.tr, 13, FontWeight.w600,
                                MyColor.black),
                          ),
                          const SizedBox(
                              height: 5.0
                          ),
                          selectCenterList()
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        });
  }
}
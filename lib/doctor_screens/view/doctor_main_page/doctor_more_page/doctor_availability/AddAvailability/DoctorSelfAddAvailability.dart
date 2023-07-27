import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';

import '../../../../../../helper/mycolor/mycolor.dart';
import '../../../../../../language_translator/LanguageTranslate.dart';
import '../../../../../../patient_screens/controller/appointment_controller/AppointmentController.dart';
import '../../../../../../patient_screens/controller/doctor_list_ctr/DoctorListController.dart';
import '../../../../../controller/AddAvailablityCtr.dart';
import '../doctorViewAvailability/DoctorViewCalenderSlot.dart';

class MyAvailability extends StatefulWidget {
  const MyAvailability({Key? key}) : super(key: key);

  @override
  State<MyAvailability> createState() => _MyAvailabilityState();
}

class _MyAvailabilityState extends State<MyAvailability> {
  AddAvailabilityCtr addAvailabilityCtr = Get.put(AddAvailabilityCtr());
  CustomView custom = CustomView();
  LocalString text = LocalString();

  AppointmentController appointmentController =
  Get.put(AppointmentController());
  //select date's
  var selectedIndexes = [];
  var timeIdArray = [];

  @override
  void initState() {
    super.initState();
    appointmentController.doctorViewDateCalender("");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      appointmentController.doctorViewDateCalender("");
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
    final widht = MediaQuery.of(context).size.width;
    return Obx(() {
      return Scaffold(
        body: Center(
          child: Column(children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DoctorViewCalender(
                                centerId: "",
                              )));
                },
                child: Card(
                  color: MyColor.midgray,
                  child: Center(
                      child: custom.text(text.viewAvailability.tr, 13,
                          FontWeight.w500, MyColor.primary1)),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(
                      text.startDate.tr, 15, FontWeight.w500, MyColor.black)),
            ),
            Container(
                height: 40,
                width: widht * 0.90,
                padding: const EdgeInsets.only(left: 7.0, bottom: 2.5),
                margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 1.5,
                          spreadRadius: 1.5),
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
                  decoration:  InputDecoration(
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
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(
                     text.endDate.tr, 15, FontWeight.w500, MyColor.black)),
            ),
            Container(
                height: 40,
                width: widht * 0.90,
                padding: const EdgeInsets.only(left: 7.0, bottom: 2.5),
                margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 1.5,
                          spreadRadius: 1.5),
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
                  decoration:  InputDecoration(
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
              height: 30.0,
            ),
            addAvailabilityCtr.doctorTimeList.isEmpty?  addAvailabilityCtr.loading.value
                ? custom.MyIndicator()
                : custom.MyButton(context, text.Submit.tr, () {
                    if (startDateController.text.isEmpty ||
                        endDateController.text.isEmpty) {
                      custom.MySnackBar(context, text.enterDates.tr);
                    } else {
                      addAvailabilityCtr.addAvailability(
                          context,
                          startDateController.text,
                          endDateController.text,
                          () {});
                    }
                  },
                    MyColor.primary,
                    const TextStyle(
                        color: MyColor.white,
                        fontSize: 16,
                        fontFamily: 'Heebo',
                        letterSpacing: 0.8)):Text(""),

            const Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 20.0,),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: addAvailabilityCtr.doctorTimeList.isEmpty
                      ? const Text("")
                      : custom.text(text.yourTimeSlotAccordingSelectDate.tr,
                          13, FontWeight.w500, MyColor.black)),
            ),
            addAvailabilityCtr.loadingf.value == true
                ? custom.MyIndicator()
                : Expanded(
                    child: ListView.builder(
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
                                  title: Text("${list.from} ${text.To.tr} ${list.to}"),
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
                    ),
                  ),
            // const Expanded(child: SizedBox()),
     /*       addAvailabilityCtr.doctorTimeList.isEmpty
                ? const Text("")
                : addAvailabilityCtr.loadingd.value
                    ? custom.MyIndicator()
                    : custom.acceptRejectButton(context, "select Time", () {
                        if (timeIdArray.isNotEmpty) {
                          addAvailabilityCtr.addTime(
                              context,
                              timeIdArray.join(","),
                              addAvailabilityCtr.dateId.value, () {
                            Get.back();
                          });
                        } else {
                          custom.MySnackBar(context, "Select slot's");
                          log("empty");
                        }
                      },
                        MyColor.primary, const TextStyle(color: MyColor.white)),*/
            const SizedBox(
              height: 15,
            ),
          ]),
        ),
        bottomNavigationBar: addAvailabilityCtr.doctorTimeList.isEmpty
            ? const Text("")
            :  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,),
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
                              title: text.success.tr,
                              desc: text.selfAvailabilityAddSuccessfully.tr,
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
                          custom.MySnackBar(context,text.selectSlot.tr);
                          log("empty");
                        }
                      },
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
}

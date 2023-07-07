import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';

import '../../../../../../helper/mycolor/mycolor.dart';
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

  //select date's
  var selectedIndexes = [];
  var timeIdArray = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
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
                child: Container(
                  height: 32,
                  width: 120,
                  decoration: BoxDecoration(
                      color: MyColor.primary1,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: custom.text("View Availability", 13,
                          FontWeight.w500, MyColor.white)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(
                      "Start Date", 15, FontWeight.w500, MyColor.black)),
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
                  decoration: const InputDecoration(
                    hintText: "select start date",
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
                      "End Date", 15, FontWeight.w500, MyColor.black)),
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
                  decoration: const InputDecoration(
                    hintText: "select end date",
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
            addAvailabilityCtr.loading.value
                ? custom.MyIndicator()
                : custom.MyButton(context, "Submit", () {
                    if (startDateController.text.isEmpty ||
                        endDateController.text.isEmpty) {
                      custom.MySnackBar(context, "Enter Dates");
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
                        letterSpacing: 0.8)),

            const Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 10.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: addAvailabilityCtr.doctorTimeList.isEmpty
                      ? const Text("")
                      : custom.text("Your Time Slot's according select date",
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
                                  title: Text("${list.from} To ${list.to}"),
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
                        horizontal: 20.0, vertical: 10),
                    child: AnimatedButton(
                      // width: MediaQuery.of(context).size.width * 0.8,
                      text: 'Submit',
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
                              title: 'Success',
                              desc: 'Self Availability Add Successfully',
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
                          custom.MySnackBar(context, "Select slot's");
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

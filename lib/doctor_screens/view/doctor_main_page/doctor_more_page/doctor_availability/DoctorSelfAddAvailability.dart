import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';

import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../controller/AddAvailablityCtr.dart';

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
    addAvailabilityCtr.doctorTimeList.clear();
    // addAvailabilityCtr.doctorFetchTimeList();
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
    return Scaffold(
      body: Center(
        child: Column(children: [
          const SizedBox(
            height: 20,
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
              decoration: BoxDecoration(boxShadow: const [
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

                  setState(() {});
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
              decoration: BoxDecoration(boxShadow: const [
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
                  setState(() {});
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
          Obx(
                () =>
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

              // Get.offNamed(RouteHelper.DLoginScreen());
            },
                MyColor.primary,
                const TextStyle(
                    color: MyColor.white,
                    fontSize: 16,
                    fontFamily: 'Heebo',
                    letterSpacing: 0.8)),
          ),

          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10.0),
            child: Align(
                alignment: Alignment.topLeft,
                child: addAvailabilityCtr.doctorTimeList.length == 0
                    ? Text("")
                    : custom.text(
                    "Your Time Slot's according select date", 13,
                    FontWeight.w500, MyColor.black)),
          ),
          addAvailabilityCtr.loadingf.value == true
              ? custom.MyIndicator()
              : Expanded(
            child: Obx(() {
              if (addAvailabilityCtr.doctorTimeList.length == 0) {
                return const SizedBox.shrink();
              } else {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: addAvailabilityCtr.doctorTimeList.length,
                  itemBuilder: (context, index) {
                    // var id = addAvailabilityCtr.doctorTimeList[index].id;
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
                                  "${addAvailabilityCtr.doctorTimeList[index]
                                      .from} To ${addAvailabilityCtr
                                      .doctorTimeList[index].to}"),
                              value: selectedIndexes.contains(index),
                              onChanged: (vale) {
                                setState(() {
                                  if (selectedIndexes.contains(index)) {
                                    selectedIndexes.remove(index);
                                    timeIdArray.remove(addAvailabilityCtr
                                        .doctorTimeList[index].id);
                                    // unselect
                                  } else {
                                    selectedIndexes.add(index); // select
                                    timeIdArray.add(addAvailabilityCtr
                                        .doctorTimeList[index].id);
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
              }
            }),
          ),
          // const Expanded(child: SizedBox()),
          addAvailabilityCtr.doctorTimeList.length == 0
              ? Text("")
              : Obx(() =>
          addAvailabilityCtr.loadingd.value
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
              log("empty");
            }
          }, MyColor.primary, const TextStyle(color: MyColor.white))),
          const SizedBox(
            height: 15,
          ),
        ]),
      ),
    );
  }

  //*******date strt end************//
  Future<DateTime?> pickDate() async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1999),
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

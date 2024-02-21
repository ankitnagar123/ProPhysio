import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../../../../../helper/CustomView/CustomView.dart';
import '../../../../../../helper/mycolor/mycolor.dart';
import '../../../../../../language_translator/LanguageTranslate.dart';
import '../../../../../../patient_screens/controller/appointment_controller/AppointmentController.dart';
import '../../../../../../patient_screens/controller/doctor_list_ctr/DoctorListController.dart';
import 'DoctorViewTimeSlots.dart';

class DoctorViewCalender extends StatefulWidget {
  final branchId;

  const DoctorViewCalender({
    Key? key,
    this.branchId,
  }) : super(key: key);

  @override
  State<DoctorViewCalender> createState() => _DoctorViewCalenderState();
}

class _DoctorViewCalenderState extends State<DoctorViewCalender> {
  DoctorListCtr doctorListCtr = Get.put(DoctorListCtr());
  AppointmentController appointmentController = Get.put(AppointmentController());
  CustomView custom = CustomView();
  LocalString text = LocalString();

  DateTime focusedDay = DateTime.now();
  final EventList<Event> _markedDateMap = EventList<Event>(events: {});

  final List<String> bookDate = <String>[];
  bool loader = true;

  int? lMonth;
  int? lDay;
  int? lYear;

  int? sMonth;
  int? sDay;
  int? sYear;

  @override
  void initState() {
    super.initState();
    fetchDataAsync();
  }

  Future<void> fetchDataAsync() async {
    setState(() {
      loader = true; // Show loader before fetching data
    });

    await appointmentController.doctorViewDateCalender(widget.branchId.toString());
    updateCalendar();
  }

  static Widget _presentIcon(String day, String status) => Container(
    height: 50.0,
    width: 50.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: status == "inactive" ? Colors.red : MyColor.primary,
    ),
    child: Center(
      child: Text(
        day,
        style: TextStyle(
          color: status == "inactive" ? Colors.white : Colors.white,
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white24,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: MyColor.black,
              size: 20,
            ),
          ),
          elevation: 0,
          centerTitle: true,
          title: custom.text(
            "${text.appointmentWith.tr} ${doctorListCtr.doctorname.value}",
            16,
            FontWeight.w500,
            MyColor.black,
          ),
        ),
        bottomNavigationBar: Container(
          color: MyColor.midgray,
          height: 60.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Wrap(
                      children: [
                        Container(
                          height: 20.0,
                          width: 20.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.0),
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(width: 5),
                        custom.text(
                          text.fullSlot.tr,
                          13,
                          FontWeight.w400,
                          MyColor.black,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: loader == true
              ? Center(heightFactor: 10, child: custom.MyIndicator())
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Divider(color: Colors.grey),
              StatefulBuilder(builder: (context, setState) {
                return CalendarCarousel<Event>(
                  disableDayPressed: false,
                  minSelectedDate: focusedDay,
                  onDayPressed: (DateTime selectDay, event) {
                    var finalDate = DateFormat("yyyy-MM-dd").format(selectDay);
                    var day = DateFormat("dd").format(selectDay);
                    var month = DateFormat("MM").format(selectDay);
                    var year = DateFormat("yyyy").format(selectDay);
                    log(finalDate);
                    if (bookDate.contains(finalDate)) {
                      custom.MySnackBar(context, "Doctor not available on this date");
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DoctorViewTimeSlot(
                                centerId: widget.branchId,
                                date: finalDate,
                                day: day,
                                month: month,
                                year: year,
                              )));
                    }
                    setState(() {});
                  },
                  weekdayTextStyle: const TextStyle(color: Colors.black),
                  height: MediaQuery.of(context).size.height,
                  rightButtonIcon: const Icon(Icons.arrow_circle_right, color: MyColor.primary),
                  leftButtonIcon: const Icon(Icons.arrow_circle_left, color: MyColor.primary),
                  headerMargin: const EdgeInsets.only(bottom: 20, top: 10.0),
                  headerTextStyle: const TextStyle(
                    color: MyColor.primary,
                    fontSize: 18,
                    fontFamily: "Lato",
                  ),
                  weekendTextStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  todayButtonColor: Colors.white,
                  todayTextStyle: const TextStyle(color: Colors.black),
                  markedDatesMap: _markedDateMap,
                  markedDateShowIcon: true,
                  markedDateIconMargin: 0.0,
                  customGridViewPhysics: const BouncingScrollPhysics(),
                  markedDateIconMaxShown: 1,
                  markedDateMoreShowTotal: null,
                  markedDateIconBuilder: (event) {
                    return event.icon;
                  },
                );
              }),
              const Divider(color: Colors.grey),
            ],
          ),
        ),
      );
    });
  }

  void updateCalendar() {
    setState(() {
      _markedDateMap.clear(); // Clear existing marked dates
      bookDate.clear(); // Clear existing booked dates
    });

    for (int i = 0; i < appointmentController.dateList.length; i++) {
      _markedDateMap.add(
        DateTime(
          int.parse(appointmentController.dateList[i].year),
          int.parse(appointmentController.dateList[i].month),
          int.parse(appointmentController.dateList[i].day),
        ),
        Event(
          location: "available",
          date: DateTime(
            int.parse(appointmentController.dateList[i].year),
            int.parse(appointmentController.dateList[i].month),
            int.parse(appointmentController.dateList[i].day),
          ),
          icon: _presentIcon(
            appointmentController.dateList[i].day,
            appointmentController.dateList[i].status,
          ),
        ),
      );

      if (appointmentController.dateList[i].status == "inactive") {
        setState(() {
          bookDate.add(
            "${appointmentController.dateList[i].year}-${appointmentController.dateList[i].month}-${appointmentController.dateList[i].day}",
          );
        });
      }
    }

    setState(() {
      loader = false; // Hide loader after updating calendar
    });
  }
}

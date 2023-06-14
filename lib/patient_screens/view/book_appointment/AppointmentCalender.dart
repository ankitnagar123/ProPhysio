import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:medica/patient_screens/controller/appointment_controller/AppointmentController.dart';
import 'package:medica/patient_screens/view/book_appointment/AppointmentTimeSlot.dart';

import '../../../helper/CustomView/CustomView.dart';
import '../../../helper/mycolor/mycolor.dart';
import '../../controller/doctor_list_ctr/DoctorListController.dart';

class calender extends StatefulWidget {
  String centerId;
   calender({Key? key,
   required this.centerId}) : super(key: key);

  @override
  State<calender> createState() => _calenderState();
}

class _calenderState extends State<calender> {
  DoctorListCtr doctorListCtr = Get.put(DoctorListCtr());
  AppointmentController appointmentController =
      Get.put(AppointmentController());
  CustomView custom = CustomView();

  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();
  final EventList<Event> _markedDateMap = EventList<Event>(events: {});
  late CalendarCarousel _calendarCarouselNoHeader;

  String doctorId = "";
  String centerId = "";

  @override
  void initState() {
    centerId = widget.centerId;
    print("center id $centerId");
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      doctorId = doctorListCtr.doctorid.value;
      appointmentController.dateCalender(doctorId,centerId);
    });
  }

/*---Show Icon on Calender custom---*/
  static Widget _presentIcon(String day, int percent) => Container(
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: percent < 50
              ? const Color(0xffC4DEF2)
              : percent == 100
                  ? Colors.red
                  : const Color(0xffDAA558),
        ),
        child: Center(
          child: Text(
            day,
            style: TextStyle(
              color: percent < 50
                  ? MyColor.primary1
                  : percent == 100
                      ? Colors.white
                      : Colors.white,
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < appointmentController.dateList.length; i++) {
      int day = int.parse(appointmentController.dateList[i].day);
      int month = int.parse(appointmentController.dateList[i].month);
      int year = int.parse(appointmentController.dateList[i].year);
      log("my date$day");
      log("my month$month");
      log("my year$year");
      _markedDateMap.add(
          DateTime(year, month, day),
          Event(
            location: "available",
            date: DateTime(year, month, day),
            icon: _presentIcon(appointmentController.dateList[i].day,
                int.parse(appointmentController.dateList[i].percent)),
          ));
    }
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      onDayPressed: (DateTime selectDay, event) {
        setState(() {
          selectedDay = selectDay;
          var finalDate = DateFormat("yyyy-MM-dd").format(selectDay);

          var day = DateFormat("dd").format(selectDay);
          var month = DateFormat("MM").format(selectDay);
          var year = DateFormat("yyyy").format(selectDay);

          print("final date$finalDate");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AppointmentTimeSlot(
                        date: finalDate,
                        day: day,
                        month: month,
                        year: year,
                    centerId: centerId,
                      )));
          // focusedDay = event;
        });
        print(selectDay);
      },
      weekdayTextStyle: const TextStyle(color: Colors.black),
      height: MediaQuery.of(context).size.height,
      rightButtonIcon:
          const Icon(Icons.arrow_circle_right, color: MyColor.primary1),
      leftButtonIcon:
          const Icon(Icons.arrow_circle_left, color: MyColor.primary1),
      headerMargin: const EdgeInsets.only(bottom: 20, top: 10.0),
      headerTextStyle: const TextStyle(
          color: MyColor.primary1, fontSize: 18, fontFamily: "Poppins"),
      weekendTextStyle: const TextStyle(
        color: Colors.black,
      ),
      todayButtonColor: MyColor.midgray,
      todayTextStyle: const TextStyle(color: Colors.black),
      todayBorderColor: Colors.black,
      markedDatesMap: _markedDateMap,
      markedDateShowIcon: true,
      markedDateIconMargin: 0.0,
      customGridViewPhysics: const BouncingScrollPhysics(),

      markedDateIconMaxShown: 1,
      markedDateMoreShowTotal: null,
      // null for not showing hidden events indicator
      markedDateIconBuilder: (event) {
        return event.icon;
      },
    );
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
                )),
            elevation: 0,
            centerTitle: true,
            title: custom.text(
                "Appointment with ${doctorListCtr.doctorname.value}",
                16,
                FontWeight.w500,
                MyColor.black),
          ),
          bottomNavigationBar: Container(
            color: MyColor.midgray,
            height: 60.0,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                                color: const Color(0xffC4DEF2))),
                        const SizedBox(
                          width: 5,
                        ),
                        custom.text(
                            "Free slot", 13, FontWeight.w400, MyColor.black),
                      ],
                    ),
                    Wrap(
                      children: [
                        Container(
                            height: 20.0,
                            width: 20.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.0),
                                color: const Color(0xffDAA558))),
                        const SizedBox(
                          width: 5,
                        ),
                        custom.text(
                            "Few slot", 13, FontWeight.w400, MyColor.black)
                      ],
                    ),
                    Wrap(
                      children: [
                        Container(
                            height: 20.0,
                            width: 20.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.0),
                                color: Colors.red)),
                        const SizedBox(
                          width: 5,
                        ),
                        custom.text(
                            "full slot", 13, FontWeight.w400, MyColor.black)
                      ],
                    ),
                  ],
                ),
              )
            ]),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Divider(),
                appointmentController.dateList.isEmpty
                    ? const Center(
                        child: Text("No time slot's available at the moment!"))
                    : const Text(""),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _calendarCarouselNoHeader,
                ),
                const Divider(),
                //
              ],
            ),
          ));
    });
  }
}

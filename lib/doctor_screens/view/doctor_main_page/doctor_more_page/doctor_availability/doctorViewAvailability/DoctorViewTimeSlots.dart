import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';

import '../../../../../../helper/mycolor/mycolor.dart';
import '../../../../../../patient_screens/controller/appointment_controller/AppointmentController.dart';
import '../../../../../../patient_screens/controller/doctor_list_ctr/DoctorListController.dart';


class DoctorViewTimeSlot extends StatefulWidget {
  String date, day, month, year,centerId;

  DoctorViewTimeSlot({
    Key? key,
    required this.date,
    required this.day,
    required this.month,
    required this.year,
    required this.centerId,
  }) : super(key: key);

  @override
  State<DoctorViewTimeSlot> createState() => _DoctorViewTimeSlotState();
}

class _DoctorViewTimeSlotState extends State<DoctorViewTimeSlot> {
  AppointmentController appointmentController = Get.put(AppointmentController());
  DoctorListCtr doctorListCtr = Get.put(DoctorListCtr());
  // PatientProfileCtr profileCtr = Get.put(PatientProfileCtr());

  CustomView custom = CustomView();
  String centerId = "";
  String? time;
  String? price;
  String? fee;
  String? formateddate;
  int selectedCard = -1;
  String day = "";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("final date...................${widget.date}");
      print("day...................${widget.day}");
      print("moth...................${widget.month}");
      print("year...................${widget.year}");

      day = widget.day;
      appointmentController.seletedtime.value = widget.date;
      centerId = widget.centerId;
      print("center id $centerId");

      /*-------doctor Time Slots Fetch API Hit-------*/
      appointmentController.doctorViewTimeSlotsFetch(appointmentController.seletedtime.value.toString(), centerId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
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
                size: 20.0,
              )),
          elevation: 0,
          centerTitle: true,
          title: custom.text(
              "Your time slots",
              16,
              FontWeight.w500,
              MyColor.black),
        ),
        body: appointmentController.loadingFetch.value
            ? Center(child: custom.MyIndicator())
            : SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: <Widget>[
                const Divider(),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0, bottom: 7),
                    child: custom.text("Time Slots", 16,
                        FontWeight.w500, MyColor.black),
                  ),
                ),
                appointmentController.loadingFetchTime.value
                    ? custom.MyIndicator()
                    : appointmentController.timeList.isEmpty
                    ? const Text("You haven't Time Slot's on this date")
                    : GridView.builder(
                    padding: const EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount:
                    appointmentController.timeList.length,
                    gridDelegate:
                    const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150,
                        // childAspectRatio: 3/ 2,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                        mainAxisExtent: 45),
                    itemBuilder:
                        (BuildContext context, int index) {
                      var slotList = appointmentController.timeList[index];
                      return Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            // margin: EdgeInsets.all(10),
                            height: 35.0,
                            width: widht * 0.30,
                            decoration: BoxDecoration(
                              color: MyColor.primary,
                              borderRadius:
                              BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x5b000000),
                                  offset: Offset(0, 0),
                                  blurRadius: 2,
                                  // spreadRadius: 1
                                ),
                              ],
                            ),
                            child: Center(
                                child: Text(
                                  '${slotList.from.toString()} - ${slotList.to.toString()}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color:  MyColor.white,
                                  ),
                                )),
                          ),
                        ],
                      );
                    }),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

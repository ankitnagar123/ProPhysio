import 'dart:developer';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medica/helper/CustomView/CustomView.dart';

import '../../../helper/mycolor/mycolor.dart';
import '../../controller/appointment_controller/AppointmentController.dart';
import '../../controller/auth_controllers/PatientProfileController.dart';
import '../../controller/doctor_list_ctr/DoctorListController.dart';
import 'HealthCardScreen.dart';

class AppointmentTimeSlot extends StatefulWidget {
  String date, day, month, year, centerId;

  AppointmentTimeSlot({
    Key? key,
    required this.date,
    required this.day,
    required this.month,
    required this.year,
    required this.centerId,
  }) : super(key: key);

  @override
  State<AppointmentTimeSlot> createState() => _AppointmentTimeSlotState();
}

class _AppointmentTimeSlotState extends State<AppointmentTimeSlot> {
  AppointmentController appointmentController =
      Get.put(AppointmentController());
  DoctorListCtr doctorListCtr = Get.put(DoctorListCtr());
  PatientProfileCtr profileCtr = Get.put(PatientProfileCtr());

  CustomView custom = CustomView();
  DateTime _selectedValue = DateTime.now();
  String? id;
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
      print("CENTER ID...................${widget.centerId}");

      day = widget.day;
      appointmentController.seletedtime.value = widget.date;
      profileCtr.patientProfile(context);
      centerId = widget.centerId;
      print("center id $centerId");
      id = doctorListCtr.doctorid.value;
      print("doctor id$id");

      /*-------doctor Time Slots Fetch API Hit-------*/
      appointmentController.doctorTimeSlotsFetch(id.toString(),
          appointmentController.seletedtime.value.toString(), centerId);
      appointmentController.doctorVisitChargefetch(id.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return Obx(() {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: custom.MyButton(context, "Confirm appointment", () {
            if (time == null) {
              custom.MySnackBar(context, "Select time");
            } else if (fee == null) {
              custom.MySnackBar(context, "Select visit charge's");
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HealthCardScreen(
                            timeid: time.toString(),
                            price: fee.toString(),
                            date: appointmentController.seletedtime.value
                                .toString(),
                            centerId: centerId,
                          )));
            }

            // Get.back();
          }, MyColor.primary,
              const TextStyle(color: MyColor.white, fontFamily: "Poppins")),
        ),
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
              " Appointment with ${doctorListCtr.doctorname.value}",
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
                      DatePicker(
                        DateTime.now(),
                        initialSelectedDate: DateTime(int.parse(widget.year),
                            int.parse(widget.month), int.parse(widget.day)),
                        selectionColor: MyColor.iconColor,
                        selectedTextColor: Colors.white,
                        onDateChange: (date) {
                          // New date selected
                          setState(() {
                            appointmentController.seletedtime.value =
                                DateFormat("yyyy-MM-dd").format(date);
                            /*-------doctor Time Slots Fetch API Hit-------*/
                            // print(_selectedValue);
                            _selectedValue = date;
                            print(formateddate);
                            appointmentController.doctorTimeSlotsFetch(
                                id.toString(),
                                appointmentController.seletedtime.value
                                    .toString(),
                                centerId);
                          });
                        },
                      ),
                      const SizedBox(height: 32),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0, bottom: 7),
                          child: custom.text("Doctor Time Slots", 16,
                              FontWeight.w500, MyColor.black),
                        ),
                      ),
                      appointmentController.loadingFetchTime.value
                          ? custom.MyIndicator()
                          : appointmentController.timeList.isEmpty
                              ? const Text("No Time Slot's on this date")
                              : GridView.builder(
                                  padding: const EdgeInsets.all(0),
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                      appointmentController.timeList.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 130,
                                          // childAspectRatio: 3/ 2,
                                          crossAxisSpacing: 0,
                                          mainAxisSpacing: 0,
                                          mainAxisExtent: 45),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var slotList =
                                        appointmentController.timeList[index];
                                    print(
                                        appointmentController.timeList.length);
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          time = slotList.timeId.toString();
                                          log("time id>$time");
                                          selectedCard = index;
                                          // print(selectedCard);
                                        });
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            // margin: EdgeInsets.all(10),
                                            height: 35.0,
                                            width: widht * 0.30,
                                            decoration: BoxDecoration(
                                              color: selectedCard == index
                                                  ? MyColor.primary
                                                  : Colors.white,
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
                                              style: TextStyle(
                                                fontWeight:
                                                    selectedCard == index
                                                        ? FontWeight.bold
                                                        : FontWeight.normal,
                                                color: selectedCard == index
                                                    ? MyColor.white
                                                    : Colors.black,
                                              ),
                                            )),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(height: 50),
                      Align(
                          alignment: Alignment.topLeft,
                          child: custom.text("Visit Charges", 16,
                              FontWeight.w500, MyColor.black)),
                      appointmentController.visitCharge.isEmpty
                          ? const Center(
                              heightFactor: 5,
                              child: Text("No visit Charges added by Doctor"),
                            )
                          : appointmentController.loadingFetch.value
                              ? custom.MyIndicator()
                              : ListView.builder(
                                  padding: const EdgeInsets.only(bottom: 40),
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      appointmentController.visitCharge.length,
                                  itemBuilder: (context, index) {
                                    var list = appointmentController
                                        .visitCharge[index];
                                    return ListTile(
                                      subtitle: Text(list.price.toString()),
                                      horizontalTitleGap: 20,
                                      visualDensity: const VisualDensity(
                                          horizontal: 3, vertical: -4),
                                      leading: const Icon(
                                          Icons.arrow_circle_right,
                                          size: 20,
                                          color: MyColor.lightblue),
                                      title: Text(list.name.toString()),
                                      trailing: Radio<String>(
                                        value: index.toString(),
                                        groupValue: price,
                                        onChanged: (value) {
                                          setState(() {
                                            price = value!;
                                            print("....$price");
                                            fee = list.price.toString();
                                            print('fee----------$fee');
                                            print('price----------$price');
                                          });
                                        },
                                      ),
                                    );
                                  })
                    ],
                  ),
                ),
              ),
      );
    });
  }
}

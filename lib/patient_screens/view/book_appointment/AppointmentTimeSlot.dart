import 'dart:developer';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../helper/CustomView/CustomView.dart';
import '../../../helper/mycolor/mycolor.dart';
import '../../../language_translator/LanguageTranslate.dart';
import '../../controller/appointment_controller/AppointmentController.dart';
import '../../controller/auth_controllers/PatientProfileController.dart';
import '../../controller/doctor_list_ctr/DoctorListController.dart';
import '../patient_payment_screen/PatientCheckOutCard.dart';

class AppointmentTimeSlot extends StatefulWidget {
  String date, day, month, year, branchId, cat;

  AppointmentTimeSlot({
    Key? key,
    required this.date,
    required this.day,
    required this.month,
    required this.year,
    required this.branchId,
    required this.cat,
  }) : super(key: key);

  @override
  State<AppointmentTimeSlot> createState() => _AppointmentTimeSlotState();
}

class _AppointmentTimeSlotState extends State<AppointmentTimeSlot> {
  AppointmentController appointmentController =
      Get.put(AppointmentController());
  DoctorListCtr doctorListCtr = Get.put(DoctorListCtr());
  LocalString text = LocalString();

  CustomView custom = CustomView();
  DateTime _selectedValue = DateTime.now();
  String? id;
  String branchId = "";
  String time ="";
  String price =  "0";
  String fee = "";
  String? formateddate;
  int selectedCard = -1;
  String day = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      log("final date...................${widget.date}");
      log("day...................${widget.day}");
      log("moth...................${widget.month}");
      log("year...................${widget.year}");
      log("CENTER ID...................${widget.branchId}");

      day = widget.day;
      appointmentController.seletedtime.value = widget.date;
      branchId = widget.branchId;
      log("center id $branchId");
      id = doctorListCtr.doctorid.value;
      log("doctor id--------$id");

      /*-------doctor Time Slots Fetch API Hit-------*/
      appointmentController.doctorTimeSlotsFetch(id.toString(),
              appointmentController.seletedtime.value.toString(),);
    appointmentController.doctorVisitChargefetch(widget.cat,widget.branchId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    return Obx(() {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: custom.MyButton(context, text.confirmAppointment.tr, () {
            if(time == ""){
              custom.massenger(context, "Please select time slot");
            }else if(fee == ""){
              custom.massenger(context, "Please select fee");
            }else{
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PatientCheckOutCard(
                        price: fee.toString(),
                        time: time.toString(),
                        date: appointmentController.seletedtime.value
                            .toString(),
                        branchId: branchId,
                      )));
            }


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
              "${text.appointmentWith.tr} ${doctorListCtr.doctorname.value}",
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
                       const Divider(color: Colors.grey),
                      SizedBox(
                        height: 90,
                        child: DatePicker(
                          DateTime.now(),
                          initialSelectedDate: DateTime(int.parse(widget.year),
                              int.parse(widget.month), int.parse(widget.day)),
                          selectionColor: MyColor.primary,
                          selectedTextColor: Colors.white,
                          onDateChange: (date) {
                            // New date selected
                            setState(() {
                              appointmentController.seletedtime.value =
                                  DateFormat("yyyy-MM-dd").format(date);
                              /*-------doctor Time Slots Fetch API Hit-------*/
                              // print(_selectedValue);
                              _selectedValue = date;
                              log("formatted-date-----$formateddate");
                              appointmentController.doctorTimeSlotsFetch(id.toString(),
                                  appointmentController.seletedtime.value.toString(),);
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0, bottom: 7),
                          child: custom.text(text.DoctorTimeSlots.tr, 16,
                              FontWeight.w500, MyColor.black),
                        ),
                      ),
                      appointmentController.loadingFetchTime.value
                          ? custom.MyIndicator()
                          : appointmentController.timeList.isEmpty
                              ? Text(text.noTimeSlotDate.tr)
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
                          child: custom.text(text.visitCharges.tr, 16,
                              FontWeight.w500, MyColor.black)),
                      appointmentController.visitCharge.isEmpty
                              ? Center(
                                  heightFactor: 5,
                                  child: Text(text.noVisitChargesDoctor.tr),
                                )
                              : appointmentController.loadingFetch.value
                                  ? custom.MyIndicator()
                                  : ListView.builder(
                                      padding:
                                          const EdgeInsets.only(bottom: 40),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: appointmentController
                                          .visitCharge.length,
                                      itemBuilder: (context, index) {
                                        var list = appointmentController
                                            .visitCharge[index];
                                         fee = appointmentController
                                            .visitCharge[index].price.toString();
                                        return ListTile(
                                          subtitle: Text(list.price.toString()),
                                          horizontalTitleGap: 20,
                                          visualDensity: const VisualDensity(
                                              horizontal: 3, vertical: -4),
                                          leading: const Icon(
                                              Icons.arrow_circle_right,
                                              size: 20,
                                              color: MyColor.primary1),
                                          title: Text(list.categoryName.toString()),
                                          trailing: Radio<String>(
                                            value: index.toString(),
                                            groupValue: price,
                                            onChanged: (value) {
                                              setState(() {
                                                price = value!;
                                                log("....$price");
                                                fee = list.price.toString();
                                                log('fee----------$fee');
                                                log('price----------$price');
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

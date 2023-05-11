import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../controller/DocotorBookingController.dart';
import 'AddPrescriptionandMedicalReport/PrescriptionandMedical.dart';

class CompleteAppointPrescription extends StatefulWidget {
  const CompleteAppointPrescription({Key? key}) : super(key: key);

  @override
  State<CompleteAppointPrescription> createState() => _CompleteAppointPrescriptionState();
}

class _CompleteAppointPrescriptionState extends State<CompleteAppointPrescription> {
  CustomView customView = CustomView();
  TextEditingController searchCtr = TextEditingController();
  BookingController bookingController = Get.put(BookingController());
  int selectedCard = -1;

  @override
  void initState() {
    bookingController.bookingAppointment(context,"Complete","");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios, color: MyColor.black)),
        elevation: 0,
        centerTitle: true,
        title: customView.text("Past Appointment", 17, FontWeight.w500, MyColor.black),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Obx(() {
          if(bookingController.loading.value){
            return Center(
                heightFactor: 12,child: customView.MyIndicator());
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                showList(),
              ],
            ),
          );
        }),
      ),
    );
  }


  Widget showList() {
    return SingleChildScrollView(
      child: bookingController.booking.isEmpty?const Center(heightFactor: 15,child: Text("No Past Appointment's at the moment!"),): ListView.builder(
          shrinkWrap: true,
          itemCount: bookingController.booking.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            var id = bookingController.booking[index].Id.toString();
            return InkWell(
              onTap: () {
                print(id);
Navigator.push(context, MaterialPageRoute(builder: (context)=> PrescriptionMedicalTab(patientId: id,)));
              },
              child: Card(
                color: MyColor.midgray,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 7.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customView.text(
                          bookingController.booking[index].name.toString(),
                          14.0,
                          FontWeight.w500,
                          Colors.black),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Date",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10.0,
                                      fontFamily: "Poppins"),
                                ),
                                const SizedBox(
                                  height: 2.0,
                                ),
                                Text(
                                    bookingController.booking[index].bookingDate
                                        .toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.0,
                                        fontFamily: "Poppins")),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Slot",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10.0,
                                      fontFamily: "Poppins"),
                                ),
                                const SizedBox(
                                  height: 2.0,
                                ),
                                Text(
                                  bookingController.booking[index].time
                                      .toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0,
                                      fontFamily: "Poppins"),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Booking ID",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10.0,
                                      fontFamily: "Poppins"),
                                ),
                                const SizedBox(
                                  height: 2.0,
                                ),
                                Text(
                                  bookingController.booking[index].bookID
                                      .toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0,
                                      fontFamily: "Poppins"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

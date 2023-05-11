import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:medica/helper/mycolor/mycolor.dart';

import '../../../../controller/booking_controller_list/PBookingController.dart';

class PastAppointmentsScreen extends StatefulWidget {
  const PastAppointmentsScreen({Key? key}) : super(key: key);

  @override
  State<PastAppointmentsScreen> createState() => _PastAppointmentsScreenState();
}

class _PastAppointmentsScreenState extends State<PastAppointmentsScreen> {
  CustomView customView = CustomView();
  TextEditingController searchCtr = TextEditingController();
  PatientBookingController patientBookingController =
      Get.put(PatientBookingController());

  @override
  void initState() {
    patientBookingController.bookingAppointment("Complete");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        await patientBookingController.bookingAppointment("");
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white24,
            title: customView.text(
                "Past appointments", 17, FontWeight.bold, MyColor.black),
            leading: IconButton(
              onPressed: () {
                patientBookingController.bookingAppointment("");
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios, color: MyColor.black),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                showList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showList() {
    return Obx(() {
      if (patientBookingController.loading.value) {
        return Center(heightFactor: 7, child: customView.MyIndicator());
      }
      return patientBookingController.booking.isEmpty
          ? Center(
              heightFactor: 10,
              child: customView.text("You don’t have any past appointment.", 14,
                  FontWeight.w400, MyColor.primary1))
          : SingleChildScrollView(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: patientBookingController.booking.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    var id = patientBookingController.booking[index].bookingId;
                    return InkWell(
                      onTap: () {
                        patientBookingController
                            .bookingAppointmentDetails(context, id!, "", () {
                          showBottomSheet(id);
                        });
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
                                  "Visit with ${patientBookingController.booking[index].name} ${patientBookingController.booking[index].surname}"
                                      .toString(),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            patientBookingController
                                                .booking[index].bookingDate
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          patientBookingController
                                              .booking[index].time
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
    });
  }

  showBottomSheet(String id) {
    showModalBottomSheet(
        isDismissible: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(7.0))),
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 15.0,
                ),
                customView.text("Details", 17.0, FontWeight.w500, Colors.black),
                const SizedBox(
                  height: 7.0,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Doctor information",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11.0,
                                fontFamily: "Poppins"),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(
                              "${patientBookingController.name.value}  ${patientBookingController.surname.value}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: "Poppins")),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Patient",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11.0,
                                fontFamily: "Poppins"),
                          ),
                          SizedBox(
                            height: 2.0,
                          ),
                          Text(
                            "You",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontFamily: "Poppins"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 30.0,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Address",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11.0,
                                fontFamily: "Poppins"),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(patientBookingController.location.value,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: "Poppins")),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 30.0,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Booking information",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11.0,
                                fontFamily: "Poppins"),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(
                              "${patientBookingController.bookingDate.value}  ${patientBookingController.time.value}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: "Poppins")),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 30.0,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Payment information",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11.0,
                                fontFamily: "Poppins"),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(patientBookingController.paymentTyp.value,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
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
                            "Total cost",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11.0,
                                fontFamily: "Poppins"),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(
                            patientBookingController.price.value,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontFamily: "Poppins"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 30.0,
                ),
              ],
            ),
          );
        });
  }
}

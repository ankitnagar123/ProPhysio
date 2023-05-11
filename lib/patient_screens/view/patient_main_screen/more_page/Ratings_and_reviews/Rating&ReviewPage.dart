import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:medica/helper/Shimmer/ChatShimmer.dart';
import 'package:medica/helper/mycolor/mycolor.dart';

import '../../../../controller/booking_controller_list/PBookingController.dart';
import 'Rate&ReviewDetial.dart';

class PastAppointmentsRating extends StatefulWidget {
  const PastAppointmentsRating({Key? key}) : super(key: key);

  @override
  State<PastAppointmentsRating> createState() => _PastAppointmentsRatingState();
}

class _PastAppointmentsRatingState extends State<PastAppointmentsRating> {
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
            title: customView.text("Ratings & Reviews", 15,
                FontWeight.w500, MyColor.black),
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
                Center(
                  heightFactor: 5,
                  child: customView.text(
                      "Rate those last visits you did.",
                      14.0,
                      FontWeight.w500,
                      Colors.black),
                ),
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
        return categorysubShimmerEffect(context);
      } else if (patientBookingController.booking.isEmpty) {
        return const Center(
            heightFactor: 10.0,
            child: Text("You don’t have any new rating or review to do."));
      }
      return SingleChildScrollView(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: patientBookingController.booking.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              var id = patientBookingController.booking[index].doctorId;
              var bookingId = patientBookingController.booking[index].bookingId;
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RateAndReviewDetails(
                                id: id!,
                                bookingId: bookingId!,
                              )));
                },
                child: Card(
                  color: MyColor.midgray,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 7.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            customView.text(
                                "Visit with ${patientBookingController.booking[index].name} ${patientBookingController.booking[index].surname}"
                                    .toString(),
                                14.0,
                                FontWeight.w500,
                                Colors.black),
                            const Icon(Icons.arrow_right_alt_rounded, size: 18),
                          ],
                        ),
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
                                    patientBookingController.booking[index].time
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
}

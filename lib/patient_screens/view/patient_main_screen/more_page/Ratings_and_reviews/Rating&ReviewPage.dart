import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/Shimmer/ChatShimmer.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../../language_translator/LanguageTranslate.dart';
import '../../../../controller/booking_controller_list/PBookingController.dart';
import 'Rate&ReviewDetial.dart';

class PastAppointmentsRating extends StatefulWidget {
  const PastAppointmentsRating({Key? key}) : super(key: key);

  @override
  State<PastAppointmentsRating> createState() => _PastAppointmentsRatingState();
}

class _PastAppointmentsRatingState extends State<PastAppointmentsRating> {
  CustomView customView = CustomView();
  LocalString text = LocalString();
  TextEditingController searchCtr = TextEditingController();
  PatientBookingController patientBookingController =
      Get.put(PatientBookingController());

  @override
  void initState() {
    patientBookingController.completeRatingAppoint();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white24,
          title: customView.text(text.ratingsAndReviews.tr, 15,
              FontWeight.w500, MyColor.black),
          leading: IconButton(
            onPressed: () {
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
                    text.rateThoseLastVisitsYouDid.tr,
                    14.0,
                    FontWeight.w500,
                    Colors.black),
              ),
              showList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget showList() {
    return Obx(() {
      if (patientBookingController.loadingRate.value) {
        return categorysubShimmerEffect(context);
      } else if (patientBookingController.bookingCompleteRate.isEmpty) {
        return  Center(
            heightFactor: 10.0,
            child: Text(text.youDonHaveAnyRatingReview.tr));
      }
      return SingleChildScrollView(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: patientBookingController.bookingCompleteRate.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {

              var id = patientBookingController.bookingCompleteRate[index].doctorId;
              var bookingId = patientBookingController.bookingCompleteRate[index].bookingId;
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RateAndReviewDetails(
                                id: id,
                                bookingId: bookingId,
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
                                "${text.visitWith.tr} ${patientBookingController.bookingCompleteRate[index].name} ${patientBookingController.bookingCompleteRate[index].surname}"
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
                                   Text(
                                    text.date.tr,
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10.0,
                                        fontFamily: "Poppins"),
                                  ),
                                  const SizedBox(
                                    height: 2.0,
                                  ),
                                  Text(
                                      patientBookingController.bookingCompleteRate[index].bookingDate
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
                                   Text(
                                    text.slot.tr,
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10.0,
                                        fontFamily: "Poppins"),
                                  ),
                                  const SizedBox(
                                    height: 2.0,
                                  ),
                                  Text(
                                    patientBookingController.bookingCompleteRate[index].time
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
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                   Text(
                                    text.bookingID.tr,
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10.0,
                                        fontFamily: "Poppins"),
                                  ),
                                  const SizedBox(
                                    height: 2.0,
                                  ),
                                  Text(
                                      patientBookingController.bookingCompleteRate[index].bookingId.toString(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.0,
                                          fontFamily: "Poppins")),
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

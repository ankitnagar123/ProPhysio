import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

// import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../controller/booking_controller_list/PBookingController.dart';
import '../../../../controller/rating_controller/PatinetRatingController.dart';

class RateAndReviewDetails extends StatefulWidget {
  String id, bookingId;

  RateAndReviewDetails({Key? key, required this.id, required this.bookingId})
      : super(key: key);

  @override
  State<RateAndReviewDetails> createState() => _RateAndReviewDetailsState();
}

class _RateAndReviewDetailsState extends State<RateAndReviewDetails> {
  CustomView custom = CustomView();
  TextEditingController reviewCtr = TextEditingController();
  PatientBookingController patientBookingController = Get.put(PatientBookingController());
  PatientRatingCtr patientRatingCtr = Get.put(PatientRatingCtr());

  /*--------DATA STORE STRING'S-----*/
  var rating = 0.0;
  String? doctorId;
  String? bookId;

  @override
  void initState() {
    doctorId = widget.id;
    bookId = widget.bookingId;
    print("doctor Id here$doctorId");
    print("doctor booking here$bookId");

    patientBookingController.bookingAppointmentDetails(
        context, bookId.toString(), "", () {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
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
        title: custom.text(
            "Ratings and reviews", 17, FontWeight.w500, MyColor.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Obx(() {
            if (patientBookingController.loadingd.value) {
              return Center(
                heightFactor: 10,
                child: custom.MyIndicator(),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(
                      "Visit with ${patientBookingController.name}",
                      15.0,
                      FontWeight.bold,
                      Colors.black),
                ),
                SizedBox(
                  height: height * 0.01,
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
                          Text(patientBookingController.bookingDate.value,
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
                            patientBookingController.time.value,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                                fontFamily: "Poppins"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                custom.text("Select a rating range", 14.0, FontWeight.w500,
                    Colors.black),
                SizedBox(
                  height: height * 0.01,
                ),
                RatingBar.builder(
                  itemSize: 35,
                  initialRating: rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: MyColor.primary,
                  ),
                  onRatingUpdate: (ratings) {
                    rating = ratings;
                    print(rating);
                  },
                ),
                SizedBox(
                  height: height * 0.06,
                ),
                custom.text(
                    "Write a review", 14.0, FontWeight.w500, Colors.black),
                SizedBox(
                  height: height * 0.01,
                ),
                TextField(
                  controller: reviewCtr,
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(top: 20, left: 20),
                    hintText: "Your review",
                    hintStyle: TextStyle(fontSize: 14),
                    filled: true,
                    fillColor: MyColor.white,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: height * 0.3,
                ),
                Align(
                  alignment: Alignment.center,
                  child: AnimatedButton(
                    width: MediaQuery.of(context).size.width * 0.9,
                    text: 'Submit',
                    color: MyColor.primary,
                    pressEvent: () {
                      if(validation()){
                        patientRatingCtr.ratingAdd(
                            context, doctorId!, rating.toString(), reviewCtr.text,
                                () {
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.leftSlide,
                                headerAnimationLoop: false,
                                dialogType: DialogType.success,
                                showCloseIcon: true,
                                title: 'Success',
                                desc: 'Rating Successfully',
                                btnOkOnPress: () {
                                  Get.back();
                                  debugPrint('OnClcik');
                                },
                                btnOkIcon: Icons.check_circle,
                                onDismissCallback: (type) {
                                  debugPrint('Dialog Dissmiss from callback $type');
                                },
                              ).show();
                              // Get.back();
                            });
                      }

                    },
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
  //******************RATING VALIDATION (IF/ELSE CONDITIONS.)*****************//
  bool validation() {
    if (rating == 0.0) {
      custom.MySnackBar(context, "Select rating range");
    } else {
      return true;
    }
    return false;
  }
}

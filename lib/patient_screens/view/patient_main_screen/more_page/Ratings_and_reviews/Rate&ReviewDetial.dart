import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../../language_translator/LanguageTranslate.dart';
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
  LocalString text = LocalString();
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
        bottom: PreferredSize(preferredSize:Size.fromHeight(5),child: Divider(color: Colors.grey), ),
        backgroundColor: Colors.white24,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios, color: MyColor.black)),
        elevation: 0,
        centerTitle: true,
        title: custom.text(
            text.ratingsAndReviews.tr, 16, FontWeight.w500, MyColor.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
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
                Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(
                      "${text.visitWith.tr} ${patientBookingController.name}",
                      15.0,
                      FontWeight.w600,
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
                custom.text(text.selectRatingRange.tr, 14.0, FontWeight.w500,
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
                    text.writeReview.tr, 14.0, FontWeight.w500, Colors.black),
                SizedBox(
                  height: height * 0.01,
                ),
                TextField(
                  controller: reviewCtr,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  decoration:  InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 20, left: 20),
                    hintText: text.yourReview.tr,
                    hintStyle: const TextStyle(fontSize: 14),
                    filled: true,
                    fillColor: MyColor.white,
                    border: const OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: height * 0.3,
                ),
                Align(
                  alignment: Alignment.center,
                  child:patientRatingCtr.loadingAdd.value?custom.MyIndicator() :AnimatedButton(
                    width: MediaQuery.of(context).size.width * 0.9,
                    text: text.Submit.tr,
                    color: MyColor.red,
                    pressEvent: () {
                      if(validation()){
                        patientRatingCtr.ratingAdd(
                            context, doctorId.toString(), rating.toString(), reviewCtr.text,bookId.toString(),
                                () {
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.leftSlide,
                                headerAnimationLoop: false,
                                dialogType: DialogType.success,
                                showCloseIcon: true,
                                title: text.success.tr,
                                desc: text.ratingSuccessfully.tr,
                                btnOkOnPress: () {
                                  Get.back();
                                  Get.back();
                                  debugPrint('OnClick');
                                },
                                btnOkIcon: Icons.check_circle,
                                onDismissCallback: (type) {
                                  debugPrint('Dialog Dismiss from callback $type');
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
      custom.MySnackBar(context, text.selectRatingRange.tr);
    } else {
      return true;
    }
    return false;
  }
}

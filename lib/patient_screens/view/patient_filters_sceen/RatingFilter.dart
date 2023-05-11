import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:medica/Helper/RoutHelper/RoutHelper.dart';
import 'package:medica/helper/AppConst.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:medica/helper/mycolor/mycolor.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:medica/patient_screens/controller/doctor_list_ctr/DoctorListController.dart';

class RatingFilterScreen extends StatefulWidget {
  const RatingFilterScreen({Key? key}) : super(key: key);

  @override
  State<RatingFilterScreen> createState() => _RatingFilterScreenState();
}

class _RatingFilterScreenState extends State<RatingFilterScreen> {
  CustomView custom = CustomView();
  var rating = 2.5;
  DoctorListCtr doctorListCtr = DoctorListCtr();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final widht = MediaQuery
        .of(context)
        .size
        .width;
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white24,
          title: custom.text("Rating", 17, FontWeight.bold, MyColor.black),
          leading: IconButton(
            onPressed: () {
              Get.offNamed(RouteHelper.getFilterScreen());
            },
            icon: const Icon(Icons.arrow_back_ios, color: MyColor.black),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: custom.MyButton(context, "Submit", () {
           Get.offNamed(RouteHelper.getFilterScreen());
          }, MyColor.primary, const TextStyle(
              color: MyColor.white,
              fontFamily: "Poppins"
          )),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              SizedBox(
                height: height * 0.02,
              ),
              custom.text(
                  "Select rating range", 17, FontWeight.w500, MyColor.black),
              SizedBox(
                height: height * 0.02,
              ),
              RatingBar(
                itemSize: 23,
                initialRating: 0.0 /*double.parse(
                  patientRatingCtr.address.value.aveRating.toString())*/,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                ratingWidget: RatingWidget(
                    full: Icon(Icons.star, color: MyColor.primary),
                    half: Icon(Icons.star_half, color: MyColor.primary),
                    empty: const Icon(Icons.star_border_purple500_outlined,
                        color: MyColor.primary)),
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                onRatingUpdate: (rating) {
               //   log(">>>>> $rating");
                 // doctorListCtr.location.value = rating.toString();
                  /*=================*/
                  setState(() {
                    AppConst.rating = rating.toString();
                  });


                    log(" app const = ${AppConst.rating}");
                },
              ),
            ],
          ),
        ),
      );
  }
}

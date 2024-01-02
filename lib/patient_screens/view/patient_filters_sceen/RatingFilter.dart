import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../helper/AppConst.dart';
import '../../../helper/CustomView/CustomView.dart';
import '../../../helper/mycolor/mycolor.dart';
import '../../../language_translator/LanguageTranslate.dart';
import '../../controller/doctor_list_ctr/DoctorListController.dart';
import '../patient_main_screen/patient_home_page/category_sub-category/DoctorListwithCategoy.dart';

class RatingFilterScreen extends StatefulWidget {
  const RatingFilterScreen({Key? key}) : super(key: key);

  @override
  State<RatingFilterScreen> createState() => _RatingFilterScreenState();
}

class _RatingFilterScreenState extends State<RatingFilterScreen> {
  CustomView custom = CustomView();
  DoctorListCtr doctorListCtr = DoctorListCtr();
  LocalString text = LocalString();
  var cat = "";
  var subCat = "";
  String ratings = "";
  @override
  void initState() {
    super.initState();
    cat = Get.parameters['cat'].toString();
    subCat = Get.parameters['subCat'].toString();
  }
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
          title: custom.text(text.Rating.tr, 17, FontWeight.bold, MyColor.black),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: MyColor.black),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: custom.MyButton(context, text.Submit.tr, () {
        /*    Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => DoctorListWithCategory(
                      catId: cat,
                      subCatId: subCat,
                      startPrice: "",
                      EndPrice:  "", rating: ratings,
                    )));*/
           // Get.offNamed(RouteHelper.getFilterScreen());
          }, MyColor.red, const TextStyle(
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
               const Divider(color: Colors.grey),
              SizedBox(
                height: height * 0.02,
              ),
              custom.text(
                  text.selectRatingRange.tr, 17, FontWeight.w500, MyColor.black),
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
                    full: const Icon(Icons.star, color: MyColor.primary),
                    half: const Icon(Icons.star_half, color: MyColor.primary),
                    empty: const Icon(Icons.star_border_purple500_outlined,
                        color: MyColor.primary)),
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                onRatingUpdate: (rating) {
               //   log(">>>>> $rating");
                 // doctorListCtr.location.value = rating.toString();
                  /*=================*/
                  setState(() {
                    ratings = rating.toString();
                    // AppConst.rating = rating.toString();
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

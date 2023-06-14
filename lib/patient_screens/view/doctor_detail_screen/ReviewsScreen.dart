
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';

import '../../../helper/mycolor/mycolor.dart';
import '../../controller/rating_controller/PatinetRatingController.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({Key? key}) : super(key: key);

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  PatientRatingCtr patientRatingCtr = Get.put(PatientRatingCtr());
  CustomView custom = CustomView();
  String? doctorid;

  @override
  void initState() {
    doctorid = Get.arguments["doctorid"];
    print("doctor id=>>>>>>$doctorid");
    patientRatingCtr.fetchRating(doctorid!);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: MyColor.black,
            )),
        elevation: 0,
        centerTitle: true,
        title: custom.text("Reviews", 17, FontWeight.w500, MyColor.black),
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          if (patientRatingCtr.loading.value) {
            return Center(
              heightFactor: 10,
              child: custom.MyIndicator(),
            );
          }
          return Column(
            children: [
              const Divider(),
              SizedBox(
                height: height * 0.022,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  custom.text(
                      patientRatingCtr.address.value.aveRating.toString(),
                      17,
                      FontWeight.bold,
                      MyColor.primary),
                  RatingBar(
                    ignoreGestures: true,
                    itemSize: 30,
                    initialRating: double.parse(
                        patientRatingCtr.address.value.aveRating.toString()),
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    ratingWidget: RatingWidget(
                        full: const Icon(Icons.star, color: MyColor.primary),
                        half: const Icon(Icons.star_half, color: MyColor.primary),
                        empty: const Icon(Icons.star_border_purple500_outlined,
                            color: MyColor.primary)),
                    itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                    onRatingUpdate: (rating) {
                    },
                  ),
                ],
              ),
              const SizedBox(height: 3,),
              custom.text(
                  "Average rating", 14, FontWeight.normal, MyColor.grey),
              SizedBox(
                height: height * 0.1,
              ),
              const Divider(),
              SizedBox(
                height: height * 0.022,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(
                      "${patientRatingCtr.address.value.totalReview.toString()} reviews",
                      16,
                      FontWeight.normal,
                      MyColor.grey),
                ),
              ),
              ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                shrinkWrap: true,
                itemCount: patientRatingCtr.address.value.users.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RatingBar(
                              ignoreGestures: true,
                              itemSize: 20,
                              initialRating: double.parse(patientRatingCtr
                                  .address.value.users[index].rating
                                  .toString()),
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              ratingWidget: RatingWidget(
                                  full:
                                      const Icon(Icons.star, color: MyColor.primary),
                                  half: const Icon(Icons.star_half,
                                      color: MyColor.primary),
                                  empty: const Icon(
                                      Icons.star_border_purple500_outlined,
                                      color: MyColor.primary)),
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            SizedBox(
                              width: widht * 0.01,
                            ),
                            custom.text(
                                patientRatingCtr
                                    .address.value.users[index].userName,
                                15,
                                FontWeight.normal,
                                MyColor.lightblue),
                          ],
                        ),
                        custom.text(
                            patientRatingCtr.address.value.users[index].review,
                            15,
                            FontWeight.normal,
                            MyColor.black),
                      ],
                    ),
                  );
                },
              )
            ],
          );
        }),
      ),
    );
  }
}

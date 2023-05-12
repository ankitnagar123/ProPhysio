import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/Helper/RoutHelper/RoutHelper.dart';
import 'package:medica/helper/sharedpreference/SharedPrefrenc.dart';

import '../../../../helper/CustomView/CustomView.dart';
import '../../helper/Shimmer/ChatShimmer.dart';
import '../../helper/mycolor/mycolor.dart';
import '../center_controller/CenterHomeController.dart';

class CenterDoctorViewScreen extends StatefulWidget {
  const CenterDoctorViewScreen({Key? key}) : super(key: key);

  @override
  State<CenterDoctorViewScreen> createState() => _CenterDoctorViewScreenState();
}

class _CenterDoctorViewScreenState extends State<CenterDoctorViewScreen> {
  TextEditingController searchCtr = TextEditingController();
  CustomView custom = CustomView();
  SharedPreferenceProvider sp = SharedPreferenceProvider();
  int selectedCard = -1;
  CenterHomeCtr centerHomeCtr = CenterHomeCtr();

  String? id;
  String? userTyp;
  String? deviceId;
  String? deviceTyp;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      centerHomeCtr.centerSelectedDrList(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return Obx(() {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.06,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(Icons.arrow_back_ios_new_outlined,
                              size: 20)),
                      custom.text(centerHomeCtr.medicalCenterName.value, 17,
                          FontWeight.w500, MyColor.black),
                      GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.CEditWard());
                          },
                          child: const Icon(Icons.more_outlined, size: 20)),
                    ],
                  ),
                ),
                custom.searchField(
                    context,
                    searchCtr,
                    "Search doctors by name, surname",
                    TextInputType.text,
                    const Text(""),
                    const Icon(Icons.search_rounded), () {
                  Get.toNamed(RouteHelper.DSearchAppointment());
                }, () {}),
                SizedBox(
                  height: height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    custom.text("results", 14, FontWeight.normal,
                        MyColor.grey.withOpacity(0.70)),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 25.0,
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: custom.text("Sort by:", 17,
                                          FontWeight.w500, MyColor.black),
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    ListTile(
                                        visualDensity: const VisualDensity(
                                            horizontal: -4, vertical: -4),
                                        onTap: () {
                                          setState(() {
                                            selectedCard = 0;
                                          });

                                          Get.back();
                                        },
                                        leading: custom.text("Date: linear", 15,
                                            FontWeight.normal, MyColor.black),
                                        trailing: selectedCard == 0
                                            ? const Icon(Icons.check_outlined,
                                                color: MyColor.lightblue)
                                            : const Text("")),
                                    const Divider(
                                      thickness: 1.5,
                                    ),
                                    ListTile(
                                        visualDensity: const VisualDensity(
                                            horizontal: -4, vertical: -4),
                                        onTap: () {
                                          setState(() {
                                            selectedCard = 1;
                                          });
                                          Get.back();
                                        },
                                        leading: custom.text(
                                            "Date: reverse",
                                            15,
                                            FontWeight.normal,
                                            MyColor.black),
                                        trailing: selectedCard == 1
                                            ? const Icon(Icons.check_outlined,
                                                color: MyColor.lightblue)
                                            : const Text("")),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Wrap(
                        children: [
                          custom.text("Sort by: ", 14, FontWeight.normal,
                              MyColor.grey.withOpacity(0.70)),
                          custom.text(
                              "Name (A-Z)", 14, FontWeight.w500, MyColor.black),
                          const Icon(
                            Icons.keyboard_arrow_down,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                centerHomeCtr.selectedDoctorList.length == 0
                    ? categorysubShimmerEffect(context)
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: centerHomeCtr.selectedDoctorList.length == 0
                            ? const Center(
                                heightFactor: 10,
                                child:
                                    Text("Doctor Not Available at the Moment"))
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    centerHomeCtr.selectedDoctorList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {},
                                    child: Card(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 7, vertical: 6.0),
                                      color: MyColor.midgray,
                                      elevation: 2.2,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 100.0,
                                            height: 100.0,
                                            // margin: const EdgeInsets.all(6),
                                            child: FadeInImage.assetNetwork(
                                                placeholder:
                                                    "assets/images/YlWC.gif",
                                                alignment: Alignment.center,
                                                image: centerHomeCtr
                                                        .selectedDoctorList[
                                                    index]["Doctor_profile"],
                                                fit: BoxFit.fitWidth,
                                                width: double.infinity,
                                                imageErrorBuilder: (context,
                                                    error, stackTrace) {
                                                  return Image.asset(
                                                    'assets/images/noimage.png',
                                                    fit: BoxFit.cover,
                                                  );
                                                }),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              custom.text(
                                                  "${centerHomeCtr.selectedDoctorList[index]["name"]} ${centerHomeCtr.selectedDoctorList[index]["surname"]}",
                                                  13,
                                                  FontWeight.w600,
                                                  MyColor.black),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      size: 18),
                                                  SizedBox(
                                                    width: 150,
                                                    child: custom.text(
                                                        centerHomeCtr
                                                                .selectedDoctorList[
                                                            index]["location"],
                                                        12,
                                                        FontWeight.normal,
                                                        MyColor.grey),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              // Row(
                                              //   children: [
                                              //     const Icon(
                                              //         Icons.monetization_on,
                                              //         size: 18),
                                              //     const SizedBox(
                                              //       width: 3,
                                              //     ),
                                              //     custom.text(
                                              //         centerHomeCtr.selectedDoctorList[index]["Doctor_profile"],
                                              //         12,
                                              //         FontWeight.normal,
                                              //         MyColor.grey),
                                              //   ],
                                              // ),
                                              /*SizedBox(
                                    width: widht * 0.50,
                                    child: custom.text(
                                        centerHomeCtr.selectedDoctorList[index]["Doctor_profile"],
                                        12,
                                        FontWeight.w500,
                                        MyColor.black)),*/

                                              // RatingBar(
                                              //   // ignoreGestures: true,
                                              //   itemSize: 17,
                                              //   initialRating: double.parse(list[index].rating),
                                              //   direction: Axis.horizontal,
                                              //   allowHalfRating: true,
                                              //   itemCount: 5,
                                              //   ratingWidget: RatingWidget(
                                              //       full:
                                              //       const Icon(Icons.star, color: MyColor.primary),
                                              //       half: const Icon(Icons.star_half,
                                              //           color: MyColor.primary),
                                              //       empty: const Icon(
                                              //           Icons.star_border_purple500_outlined,
                                              //           color: MyColor.primary)),
                                              //   itemPadding:
                                              //   const EdgeInsets.symmetric(horizontal: 2.0),
                                              //   onRatingUpdate: (rating) {
                                              //     print(rating);
                                              //   },
                                              // ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
              ],
            ),
          ),
        ),
      );
    });
  }

  void getValuee() async {
    id = await sp.getStringValue(sp.DOCTOR_ID_KEY);
    deviceTyp = await sp.getStringValue(sp.CURRENT_DEVICE_KEY);
    deviceId = await sp.getStringValue(sp.FIREBASE_TOKEN_KEY);
    // userTyp = await sp.getStringValue(sp.CURRENT_DEVICE_KEY);

    // loginCtr.updateToken(context, id!, "Doctor", deviceId!, deviceTyp!);
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/Helper/RoutHelper/RoutHelper.dart';
import 'package:medica/helper/sharedpreference/SharedPrefrenc.dart';

import '../../../../helper/CustomView/CustomView.dart';
import '../../helper/Shimmer/ChatShimmer.dart';
import '../../helper/mycolor/mycolor.dart';
import '../center_controller/CenterHomeController.dart';
import '../center_models/CenterSelectedDrModel.dart';

class CenterDoctorViewScreen extends StatefulWidget {
  const CenterDoctorViewScreen({Key? key}) : super(key: key);

  @override
  State<CenterDoctorViewScreen> createState() => _CenterDoctorViewScreenState();
}

class _CenterDoctorViewScreenState extends State<CenterDoctorViewScreen> {
  TextEditingController searchCtr = TextEditingController();
  CustomView custom = CustomView();
  SharedPreferenceProvider sp = SharedPreferenceProvider();
  CenterHomeCtr centerHomeCtr = Get.put(CenterHomeCtr());

  int selectedCard = -1;
String wardId = "";
  String wardName = "";
String keyword = "";
  @override
  void initState() {
    super.initState();
    wardId = Get.parameters["wardId"].toString();
    wardName = Get.parameters["wardName"].toString();
    print("ward id $wardId");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      centerHomeCtr.centerSelectedDrList(context,wardId);
    });
    centerHomeCtr.wardDeleteReason(context);
  }

  List<CenterSelectedDListModel> _getFilteredList() {
    if (keyword.isEmpty) {
      return centerHomeCtr.selectedDoctorList;
    }
    return  centerHomeCtr.selectedDoctorList
        .where(
            (user) => user.name.toLowerCase().contains(keyword.toLowerCase())||user.surname.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
  }


  @override
  Widget build(BuildContext context) {
  final  drList =  _getFilteredList();
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
                      custom.text(wardName, 17,
                          FontWeight.w500, MyColor.black),
                      GestureDetector(
                          onTap: () {
                            var data = {
                              "wardId":wardId,
                              "wardName":wardName,
                            };
                            Get.toNamed(RouteHelper.CEditWard(),parameters: data);
                          },
                          child: const Icon(Icons.more_outlined, size: 20)),
                    ],
                  ),
                ),
                SizedBox(
                  width: widht,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        keyword = value;
                      });
                      log(value);
                    },
                    cursorWidth: 0.0,
                    cursorHeight: 0.0,
                    onTap: () {},
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.black,
                    controller: searchCtr,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      prefixIconColor: MyColor.primary1,
                      contentPadding: EdgeInsets.only(top: 3, left: 20),
                      hintText: "search doctor by name,surname",
                      hintStyle: TextStyle(
                          fontSize: 12, color: MyColor.primary1),
                      fillColor: MyColor.lightcolor,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
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
                centerHomeCtr.loadingFetchS.value
                    ? categorysubShimmerEffect(context)
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: drList.length == 0
                            ? const Center(
                                heightFactor: 10,
                                child:
                                    Text("Doctor Not Available at the Moment"))
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    drList.length,
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
                                                image: drList[
                                                    index].doctorProfile,
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
                                                  "${drList[index].name} ${drList[index].surname}",
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
                                                        drList[
                                                            index].location,
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
                // SizedBox(
                //                     width: widht * 0.50,
                //                     child: custom.text(
                //                         centerHomeCtr.selectedDoctorList[index]["Doctor_profile"],
                //                         12,
                //                         FontWeight.w500,
                //                         MyColor.black)),

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
                                           /*   ListView.builder(
                                                itemCount: centerHomeCtr.selectedDoctorList[index].cat.length,
                                                itemBuilder:  (context, indx) {
                                                  SizedBox(
                                                      width: widht * 0.50,
                                                      child: custom.text(
                                                          centerHomeCtr.selectedDoctorList[index]
                                                              .cat[indx].categoryName
                                                              .toString(),
                                                          12,
                                                          FontWeight.w500,
                                                          MyColor.black));
                                                },
                                              ),*/
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
}

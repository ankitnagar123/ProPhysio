import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../helper/CustomView/CustomView.dart';
import '../../../../../../helper/Shimmer/ChatShimmer.dart';
import '../../../../../../helper/mycolor/mycolor.dart';
import '../../../../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../../../../../language_translator/LanguageTranslate.dart';
import '../../../../../../medica_center/center_controller/CenterHomeController.dart';
import '../../../../doctor_detail_screen/DoctorDetailScreen.dart';

class PWardDrListScreen extends StatefulWidget {
  const PWardDrListScreen({Key? key}) : super(key: key);

  @override
  State<PWardDrListScreen> createState() => _PWardDrListScreenState();
}

class _PWardDrListScreenState extends State<PWardDrListScreen> {
  TextEditingController searchCtr = TextEditingController();
  CustomView custom = CustomView();
  LocalString text = LocalString();


  SharedPreferenceProvider sp = SharedPreferenceProvider();
  int selectedCard = -1;
  CenterHomeCtr centerHomeCtr = CenterHomeCtr();
  String wardId = "";
  String wardName = "";
String centerId = "";
  String? id;
  String? userTyp;
  String? deviceId;
  String? deviceTyp;

  @override
  void initState() {
    super.initState();
    centerId = Get.parameters["centerId"].toString();
    wardId = Get.parameters["wardId"].toString();
    wardName = Get.parameters["wardName"].toString();
    print("ward id $wardId");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      centerHomeCtr.centerSelectedDrList(context,wardId);
    });
    centerHomeCtr.wardDeleteReason(context);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return Obx(() {
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
          title: custom.text(wardName, 17, FontWeight.w500, MyColor.black),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                custom.searchField(
                    context,
                    searchCtr,
                    text.Search_Doctorby_Name.tr,
                    TextInputType.text,
                    const Text(""),
                    const Icon(Icons.search_rounded), () {
                  // Get.toNamed(RouteHelper.DSearchAppointment());
                }, () {}),
                SizedBox(
                  height: height * 0.04,
                ),
                centerHomeCtr.loadingFetchS.value
                    ? categorysubShimmerEffect(context)
                    : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: centerHomeCtr.selectedDoctorList.isEmpty
                      ?  Center(
                      heightFactor: 10,
                      child:
                      Text(text.Doctor_Not_Available.tr,))
                      : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                    centerHomeCtr.selectedDoctorList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DoctorDetailScreen(
                                        id:   centerHomeCtr.selectedDoctorList[index].doctorId, centerId:centerId, drImg: centerHomeCtr.selectedDoctorList[index].doctorProfile,
                                      )));
                        },
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
                                      "${centerHomeCtr.selectedDoctorList[index].name} ${centerHomeCtr.selectedDoctorList[index].surname}",
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

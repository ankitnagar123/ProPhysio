import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/sharedpreference/SharedPrefrenc.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:medica/Helper/RoutHelper/RoutHelper.dart';

import '../../../../helper/CustomView/CustomView.dart';
import '../../../helper/Shimmer/ChatShimmer.dart';
import '../../../helper/mycolor/mycolor.dart';
import '../../center_controller/CenterHomeController.dart';
import '../../center_models/CenterAllDrModel.dart';


class WardAddMoreDoctor extends StatefulWidget {
  const WardAddMoreDoctor({Key? key}) : super(key: key);

  @override
  State<WardAddMoreDoctor> createState() => _WardAddMoreDoctorState();
}

class _WardAddMoreDoctorState extends State<WardAddMoreDoctor> {
  TextEditingController nameCtr = TextEditingController();
  TextEditingController searchCtr = TextEditingController();
  CustomView custom = CustomView();
  SharedPreferenceProvider sp = SharedPreferenceProvider();
  int selectedCard = -1;
  CenterHomeCtr centerHomeCtr = CenterHomeCtr();
  String? id;
  String? userTyp;
  String? deviceId;
  String? deviceTyp;

  String _keyword = '';

  var drIdArray = [];
  var drIdMainArray = [];
  var drIdMainArrayimg = [];

  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      centerHomeCtr.centerDoctorListFetch(context);
    });
  }

  List<CenterDoctorListModel> _getFilteredList() {
    if (_keyword.isEmpty) {
      return centerHomeCtr.doctorList;
    }
    return centerHomeCtr.doctorList
        .where(
            (user) => user.name.toLowerCase().contains(_keyword.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final list = _getFilteredList();
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return Obx(() {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: drIdMainArray.isEmpty
              ? const Text("")
              : centerHomeCtr.loadingAdd.value?custom.MyIndicator():custom.MyButton(context, "Add ward", () {
            if (nameCtr.text.isEmpty) {
              custom.MySnackBar(context, "Enter ward name");
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) =>
              //             HealthCardScreen(
              //               timeid: time.toString(),
              //               price: fee.toString(),
              //               date: appointmentController.seletedtime.value
              //                   .toString(),
              //             )));
            } else if (drIdMainArray.length == 0) {
              custom.MySnackBar(context, "Select doctor");
            } else {
              centerHomeCtr.addDoctors(context, nameCtr.text, drIdMainArray.join(','),(){
                Get.toNamed(RouteHelper.CBottomNavigation());
              });
              print("object");
            }
            // Get.back();
          }, MyColor.primary,
              const TextStyle(color: MyColor.white, fontFamily: "Poppins")),
        ),
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
                      custom.text(
                          "New ward", 17, FontWeight.w500, MyColor.black),
                      const Text("")
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: custom.text("Enter ward name", 12.0, FontWeight.w600,
                      MyColor.primary1),
                ),
                const SizedBox(
                  height: 3.0,
                ),
                custom.myField(context, nameCtr, "name", TextInputType.text),
                SizedBox(
                  height: height * 0.03,
                ),
                const Divider(thickness: 1.5, color: MyColor.midgray),
                SizedBox(
                  height: height * 0.03,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(
                      "Add doctors", 17.0, FontWeight.w600, MyColor.black),
                ),
                SizedBox(
                  width: widht,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        // drIdArray.clear();
                        _keyword = value;
                      });
                      print(value);
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
                      suffixIconColor: MyColor.primary1,
                      contentPadding: EdgeInsets.only(top: 3, left: 20),
                      hintText: "Search Doctor",
                      hintStyle:
                      TextStyle(fontSize: 12, color: MyColor.primary1),
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
                const SizedBox(
                  height: 5,
                ),
                if (drIdMainArrayimg.isEmpty)
                  const Text("")
                else
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: drIdMainArrayimg.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Stack(
                                    children: [
                                      ClipRRect(
                                          clipBehavior: Clip.antiAlias,
                                          borderRadius:
                                          BorderRadius.circular(13.0),
                                          child: FadeInImage.assetNetwork(
                                            imageErrorBuilder: (c, o, s) =>
                                                Image.asset(
                                                    color: MyColor.midgray,
                                                    "assets/images/noimage.png",
                                                    width: 50,
                                                    height: 50,
                                                    fit: BoxFit.cover),
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                            placeholder:
                                            "assets/images/loading.gif",
                                            image: "${drIdMainArrayimg[index]}",
                                            placeholderFit: BoxFit.cover,
                                          )),
                                      Positioned(
                                          left: 0,
                                          child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  drIdMainArrayimg.remove(
                                                      drIdMainArrayimg[index]);
                                                  /*drIdArray.remove(index);
                                         drIdMainArrayimg.clear();*/
                                                  // drIdMainArrayimg.remove(drIdMainArray.remove(list[index].doctorId));
                                                });
                                              },
                                              child: const Icon(
                                                  Icons.close_outlined)))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                centerHomeCtr.loadingFetch.value
                    ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 8),
                  child: Column(
                    children: [
                      categorysubShimmerEffect(context),
                    ],
                  ),
                )
                    : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: centerHomeCtr.doctorList.length == 0
                      ? const Center(
                      heightFactor: 10,
                      child:
                      Text("Doctor Not Available at the Moment"))
                      : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          /* var id = {
                              "data": centerHomeCtr.doctorList[index].doctorId
                            };*/
                          setState(() {
                            if (drIdArray.contains(index)) {
                              drIdArray.remove(index);
                              drIdMainArray
                                  .remove(list[index].doctorId);
                              drIdMainArrayimg.remove(
                                  list[index].doctorProfile);
                            } else {
                              drIdArray.add(index);
                              drIdMainArray
                                  .add(list[index].doctorId);
                              drIdMainArrayimg
                                  .add(list[index].doctorProfile);
                            }
                          });
                          print(drIdArray);
                          print(drIdMainArray);
                          print(drIdMainArrayimg);

                          /*   Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DoctorDetailScreen(
                                          id: list[index]
                                              .doctorId
                                              .toString(),
                                        )));*/
                          // Get.toNamed(RouteHelper.getDoctorDetailScreen(id),);
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 6.0),
                          color: drIdArray.contains(index)
                              ? const Color(0xff9EC8E6)
                              : MyColor.midgray,
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
                                    image: list[index]
                                        .doctorProfile
                                        .toString(),
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
                                      list[index].name.toString(),
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
                                            list[index]
                                                .location
                                                .toString(),
                                            12,
                                            FontWeight.normal,
                                            MyColor.grey),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                          Icons.monetization_on,
                                          size: 18),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      custom.text(
                                          list[index]
                                              .fees
                                              .toString(),
                                          12,
                                          FontWeight.normal,
                                          MyColor.grey),
                                    ],
                                  ),
                                  SizedBox(
                                      width: widht * 0.50,
                                      child: custom.text(
                                          list[index]
                                              .category
                                              .toString(),
                                          12,
                                          FontWeight.w500,
                                          MyColor.black)),

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
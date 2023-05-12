import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/sharedpreference/SharedPrefrenc.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:medica/Helper/RoutHelper/RoutHelper.dart';

import '../../../../helper/CustomView/CustomView.dart';
import '../../helper/Shimmer/ChatShimmer.dart';
import '../../helper/mycolor/mycolor.dart';
import '../center_controller/CenterHomeController.dart';
import '../center_models/CenterAllDrModel.dart';

class CenterEditWardScreen extends StatefulWidget {
  const CenterEditWardScreen({Key? key}) : super(key: key);

  @override
  State<CenterEditWardScreen> createState() => _CenterEditWardScreenState();
}

class _CenterEditWardScreenState extends State<CenterEditWardScreen> {
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
      nameCtr.text = centerHomeCtr.medicalCenterName.value;
    });
  }

/*

  List<CenterDoctorListModel> _getFilteredList() {
    if (_keyword.isEmpty) {
      return centerHomeCtr.doctorList;
    }
    return centerHomeCtr.doctorList
        .where(
            (user) => user.name.toLowerCase().contains(_keyword.toLowerCase()))
        .toList();
  }*/

  @override
  Widget build(BuildContext context) {
    // final list = _getFilteredList();
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final widht = MediaQuery
        .of(context)
        .size
        .width;
    return Obx(() {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: custom.MyButton(context, "Save ward", () {
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
              centerHomeCtr.addDoctors(
                  context, nameCtr.text, drIdMainArray.join(','));
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
                          "Edit ward", 17, FontWeight.w500, MyColor.black),
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
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.08,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: centerHomeCtr.selectedDoctorList.length,
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
                                            image: "${centerHomeCtr
                                                .selectedDoctorList[index]["Doctor_profile"]}",
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

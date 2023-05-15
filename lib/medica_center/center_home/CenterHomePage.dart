import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/Helper/RoutHelper/RoutHelper.dart';
import 'package:medica/helper/sharedpreference/SharedPrefrenc.dart';

import '../../../../helper/CustomView/CustomView.dart';
import '../../helper/mycolor/mycolor.dart';
import '../add_ward/CenterAddNewWard.dart';
import '../center_controller/CenterHomeController.dart';
import 'CenterDoctorView.dart';

class CenterHomeScreen extends StatefulWidget {
  const CenterHomeScreen({Key? key}) : super(key: key);

  @override
  State<CenterHomeScreen> createState() => _CenterHomeScreenState();
}

class _CenterHomeScreenState extends State<CenterHomeScreen> {
  TextEditingController searchCtr = TextEditingController();
  CustomView custom = CustomView();
  SharedPreferenceProvider sp = SharedPreferenceProvider();
  int selectedCard = -1;
  CenterHomeCtr centerHomeCtr = CenterHomeCtr();
String wardId = "";
  String wardName = "";

  String? id;
  String? userTyp;
  String? deviceId;
  String? deviceTyp;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      centerHomeCtr.centerSelectedWardList(context);
    });
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
    return Obx(() {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.05,
                ),
                Padding(
                  padding: EdgeInsets.all(17.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => CenterAddWardScreen()));
                        }, child: Icon(Icons.add, size: 20)),
                  ),
                ),
                custom.searchField(
                    context,
                    searchCtr,
                    "Search wards, doctors",
                    TextInputType.text,
                    const Text(""),
                    const Icon(Icons.search_rounded), () {
                  // Get.toNamed(RouteHelper.DSearchAppointment());
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
                                            "Date: reverse", 15,
                                            FontWeight.normal, MyColor.black),
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
                SizedBox(
                  height: height * 0.02,
                ),

               /*centerHomeCtr.selectedWardList.length == 0? Center(
                  heightFactor: 13,
                  child: custom.text(
                      "You don’t have any ward.Create your first one now.", 11.0, FontWeight.normal, Colors.black),
                ):*/
                centerHomeCtr.loadingFetchW.value?custom.MyIndicator(): ListView.builder(
                  itemCount: centerHomeCtr.selectedWardList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Card(
                      color: MyColor.midgray,
                      child: ListTile(
                        onTap: () {
                          wardId = centerHomeCtr.selectedWardList[index].wardId;
                          wardName = centerHomeCtr.selectedWardList[index].name;

                          var data ={
                            "wardId":wardId,
                            "wardName":wardName,
                          };
                         Get.toNamed(RouteHelper.CCenterDoctorViewScreen(),parameters: data);
                          // Get.toNamed(RouteHelper.getPatientSettingsScreen());
                        },
                        title: custom.text(
                            centerHomeCtr.selectedWardList[index].name, 14.0,
                            FontWeight.w500, Colors.black),
                        subtitle: Row(
                          children: [
                            const Icon(Icons.person_outline_outlined,
                                size: 17, color: Colors.black),
                            const SizedBox(
                              width: 4.0,
                            ),
                            custom.text(
                                "${centerHomeCtr.selectedWardList[index].totalDoctor} doctors", 11.0, FontWeight.normal, Colors.black),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  void getValue() async {
    id = await sp.getStringValue(sp.DOCTOR_ID_KEY);
    deviceTyp = await sp.getStringValue(sp.CURRENT_DEVICE_KEY);
    deviceId = await sp.getStringValue(sp.FIREBASE_TOKEN_KEY);
    // userTyp = await sp.getStringValue(sp.CURRENT_DEVICE_KEY);

    // loginCtr.updateToken(context, id!, "Doctor", deviceId!, deviceTyp!);
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/Helper/RoutHelper/RoutHelper.dart';
import 'package:medica/helper/sharedpreference/SharedPrefrenc.dart';

import '../../../../helper/CustomView/CustomView.dart';
import '../../helper/mycolor/mycolor.dart';
import '../center_controller/CenterHomeController.dart';
import '../center_models/CenterSelectedWardModel.dart';

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
  CenterHomeCtr centerHomeCtr = Get.put(CenterHomeCtr());
  String wardId = "";
  String wardName = "";

  String? id;
  String? userTyp;
  String? deviceId;
  String? deviceTyp;
  String keyword = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      centerHomeCtr.centerSelectedWardList(context);
    });
  }

  /*----For SEARCH WARD LIST-------*/
  List<CenterSelectedDWardModel> _getFilteredList() {
    if (keyword.isEmpty) {
      return centerHomeCtr.selectedWardList;
    }
    return centerHomeCtr.selectedWardList
        .where(
            (user) => user.name.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final list = _getFilteredList();
    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Obx(() {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.all(17.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.CCenterAddWardScreen());
                        },
                        child: const Icon(Icons.add, size: 20,semanticLabel: "Add Ward",)),
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
                      hintText: "search ward",
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
             /*   SizedBox(
                  height: height * 0.04,
                ),*/
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     custom.text("results", 14, FontWeight.normal,
                //         MyColor.grey.withOpacity(0.70)),
                //     GestureDetector(
                //       onTap: () {
                //         showModalBottomSheet(
                //           context: context,
                //           builder: (context) {
                //             return Padding(
                //               padding: const EdgeInsets.only(left: 15.0),
                //               child: SingleChildScrollView(
                //                 child: Column(
                //                   mainAxisAlignment: MainAxisAlignment.start,
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     const SizedBox(
                //                       height: 25.0,
                //                     ),
                //                     Align(
                //                       alignment: Alignment.topCenter,
                //                       child: custom.text("Sort by:", 17,
                //                           FontWeight.w500, MyColor.black),
                //                     ),
                //                     const SizedBox(
                //                       height: 20.0,
                //                     ),
                //                     ListTile(
                //                         visualDensity: const VisualDensity(
                //                             horizontal: -4, vertical: -4),
                //                         onTap: () {
                //                           setState(() {
                //                             selectedCard = 0;
                //                           });
                //
                //                           Get.back();
                //                         },
                //                         leading: custom.text("Date: linear", 15,
                //                             FontWeight.normal, MyColor.black),
                //                         trailing: selectedCard == 0
                //                             ? const Icon(Icons.check_outlined,
                //                                 color: MyColor.lightblue)
                //                             : const Text("")),
                //                     const Divider(
                //                       thickness: 1.5,
                //                     ),
                //                     ListTile(
                //                         visualDensity: const VisualDensity(
                //                             horizontal: -4, vertical: -4),
                //                         onTap: () {
                //                           setState(() {
                //                             selectedCard = 1;
                //                           });
                //                           Get.back();
                //                         },
                //                         leading: custom.text(
                //                             "Date: reverse",
                //                             15,
                //                             FontWeight.normal,
                //                             MyColor.black),
                //                         trailing: selectedCard == 1
                //                             ? const Icon(Icons.check_outlined,
                //                                 color: MyColor.lightblue)
                //                             : const Text("")),
                //                   ],
                //                 ),
                //               ),
                //             );
                //           },
                //         );
                //       },
                //       child: Wrap(
                //         children: [
                //           custom.text("Sort by: ", 14, FontWeight.normal,
                //               MyColor.grey.withOpacity(0.70)),
                //           custom.text(
                //               "Name (A-Z)", 14, FontWeight.w500, MyColor.black),
                //           const Icon(
                //             Icons.keyboard_arrow_down,
                //           ),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
                centerHomeCtr.loadingFetchW.value
                    ? Center(heightFactor: 10, child: custom.MyIndicator())
                    : list.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: custom.text("No ward found", 14,
                                FontWeight.normal, MyColor.black))
                        : SingleChildScrollView(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                              itemCount: list.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Card(
                                  color: MyColor.midgray,
                                  child: ListTile(
                                    onTap: () {
                                      wardId = list[index].wardId;
                                      wardName = list[index].name;

                                      var data = {
                                        "wardId": wardId,
                                        "wardName": wardName,
                                      };
                                      Get.toNamed(
                                          RouteHelper.CCenterDoctorViewScreen(),
                                          parameters: data);
                                      // Get.toNamed(RouteHelper.getPatientSettingsScreen());
                                    },
                                    title: custom.text(list[index].name, 16.0,
                                        FontWeight.w500, MyColor.primary1),
                                    subtitle: Row(
                                      children: [
                                        const Icon(Icons.person_outline_outlined,
                                            size: 18, color: MyColor.primary1),
                                        const SizedBox(
                                          width: 4.0,
                                        ),
                                        custom.text(
                                            "${list[index].totalDoctor} doctors",
                                            13.0,
                                            FontWeight.normal,
                                            Colors.black),
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

  void getValue() async {
    id = await sp.getStringValue(sp.CENTER_ID_KEY);
    deviceTyp = await sp.getStringValue(sp.CURRENT_DEVICE_KEY);
    deviceId = await sp.getStringValue(sp.FIREBASE_TOKEN_KEY);
    userTyp = await sp.getStringValue(sp.CURRENT_DEVICE_KEY);

   // loginCtr.updateToken(context, id!, "Doctor", deviceId!, deviceTyp!);
  }
}

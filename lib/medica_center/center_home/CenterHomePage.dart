import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/Helper/RoutHelper/RoutHelper.dart';
import 'package:medica/helper/sharedpreference/SharedPrefrenc.dart';

import '../../../../helper/CustomView/CustomView.dart';
import '../../helper/mycolor/mycolor.dart';
import '../../language_translator/LanguageTranslate.dart';
import '../../signin_screen/signin_controller/SignInController.dart';
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
  LocalString text = LocalString();
  SharedPreferenceProvider sp = SharedPreferenceProvider();
  CenterHomeCtr centerHomeCtr = Get.put(CenterHomeCtr());
  LoginCtr loginCtr = LoginCtr();


  int selectedCard = -1;

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
      getValue();
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
            (user) => user.wardName.toLowerCase().contains(keyword.toLowerCase()))
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
                    decoration:  InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      prefixIconColor: MyColor.primary1,
                      contentPadding: EdgeInsets.only(top: 3, left: 20),
                      hintText: text.search_Ward.tr,
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
                centerHomeCtr.loadingFetchW.value
                    ? Center(heightFactor: 10, child: custom.MyIndicator())
                    : list.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: custom.text(text.No_Ward.tr, 14,
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
                                      wardName = list[index].wardName;

                                      var data = {
                                        "wardId": wardId,
                                        "wardName": wardName,
                                      };
                                      Get.toNamed(
                                          RouteHelper.CCenterDoctorViewScreen(),
                                          parameters: data);
                                      // Get.toNamed(RouteHelper.getPatientSettingsScreen());
                                    },
                                    title: custom.text(list[index].wardName, 16.0,
                                        FontWeight.w500, MyColor.primary1),
                                    subtitle: Row(
                                      children: [
                                        const Icon(Icons.person_outline_outlined,
                                            size: 18, color: MyColor.primary1),
                                        const SizedBox(
                                          width: 4.0,
                                        ),
                                        custom.text(
                                            "${list[index].totalDoctor} ${text.Doctor.tr}",
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
    // userTyp = await sp.getStringValue(sp.CURRENT_DEVICE_KEY);

    loginCtr.updateToken(context, id!, "Center", deviceId!, deviceTyp!);
  }
}

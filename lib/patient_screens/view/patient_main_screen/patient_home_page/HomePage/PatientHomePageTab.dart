import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../doctor_screens/controller/DoctorSignUpController.dart';
import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../../language_translator/LanguageTranslate.dart';
import "../../../../controller/auth_controllers/card_controller's/PatientCardController.dart";
import '../../../../controller/doctor_list_ctr/DoctorListController.dart';
import 'PDoctorTab.dart';

class PatientHomePage extends StatefulWidget {
  const PatientHomePage({Key? key}) : super(key: key);

  @override
  State<PatientHomePage> createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage>
    with SingleTickerProviderStateMixin {
  DoctorSignUpCtr doctorSignUpCtr = Get.put(DoctorSignUpCtr());
  DoctorListCtr doctorListCtr = Get.put(DoctorListCtr());
  CardCtr cardCtr = Get.put(CardCtr());

  TextEditingController searchCtr = TextEditingController();
  LocalString text = LocalString();
  CustomView customView = CustomView();
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    doctorSignUpCtr.doctorCategory();
    cardCtr.cardFetch();
    print("doctor length${doctorListCtr.doctorList.length}");
    tabController = TabController(length: 1, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    /* final widht = MediaQuery
        .of(context)
        .size
        .width;*/
    return Scaffold(

        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
            child: Column(children: [
              Container(
                constraints: const BoxConstraints.expand(height: 95),
                child: TabBar(
                    // indicatorPadding: EdgeInsets.only(bottom: 0),
                    physics: const NeverScrollableScrollPhysics(),
                    onTap: (value) {
                      log("$value");
                    },
                    controller: tabController,
                    indicatorColor: Colors.white54,
                    labelColor: MyColor.primary1,
                    labelStyle: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      color: MyColor.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    tabs: const [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Image(
                              image: AssetImage("assets/images/prologo1.png"),
                              width: 150,
                            ),
                          ),
                          // Tab(text: "SPECIALIZATION"),
                        ],
                      ),
                      // Tab(text: text.Medical_Center.tr),
                    ]),
              ),
              Expanded(
                child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: tabController,
                    children: const [
                      HomeView(),
                      // PCenterHomeScreen()
                    ]),
              ),
            ])));
  }
}

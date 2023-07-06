
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:medica/helper/mycolor/mycolor.dart';
import '../../../../../doctor_screens/controller/DoctorSignUpController.dart';
import '../../../../controller/doctor_list_ctr/DoctorListController.dart';

import 'CenterSide/PCenterHomePage.dart';
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
  TextEditingController searchCtr = TextEditingController();
  CustomView customView = CustomView();
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    doctorSignUpCtr.DoctorCategory();
    print("doctor length${doctorListCtr.doctorList.length}");
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
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
            padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 25),
            child: Column(children: [
              /*  SizedBox(
                height: height * 0.05,
              ),
              customView.searchFieldnew(
                  context,
                  searchCtr,
                  "Search doctors, medical center",
                  TextInputType.text,
                  InkWell(
                      onTap: () {
                        Get.toNamed(RouteHelper.getFilterScreen());
                      },
                      child: const Icon(Icons.filter_list_alt)),
                  const Icon(Icons.search_rounded), () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DoctorSearchList()));
              }, () {
                */
              /*   setState(() {
                      doctorListCtr.keywords.value;

                    });*/ /*
              },true),*/
              Container(
                constraints: const BoxConstraints.expand(height: 60),
                child: TabBar(
                  // indicatorPadding: EdgeInsets.only(bottom: 0),
                  physics: const NeverScrollableScrollPhysics(),
                    onTap: (value) {
                      print(value);
                    },
                    controller: tabController,
                    indicatorColor: MyColor.primary,
                    labelColor: MyColor.primary,
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
                      Tab(text: "Doctor"),
                      Tab(text: "Medical Center"),
                    ]),
              ),
              Expanded(
                child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),controller: tabController, children: const [
                  HomeView(),
                  PCenterHomeScreen()
                ]),
              ),
            ])));
  }
}

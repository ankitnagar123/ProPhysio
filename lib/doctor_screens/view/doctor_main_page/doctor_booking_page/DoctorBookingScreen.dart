import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../../helper/CustomView/CustomView.dart';
import '../../../../helper/mycolor/mycolor.dart';
import 'DoctorCompletAppoint.dart';
import 'DoctorPendingAppoiment.dart';
import 'DoctorUpcommingAppointment.dart';

class DoctorBookingScreen extends StatefulWidget {
  const DoctorBookingScreen({Key? key}) : super(key: key);

  @override
  State<DoctorBookingScreen> createState() => _DoctorBookingScreenState();
}

class _DoctorBookingScreenState extends State<DoctorBookingScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  TextEditingController searchCtr = TextEditingController();
  CustomView custom = CustomView();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white24,
        flexibleSpace: Container(),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: MyColor.primary.withOpacity(0.60)),
        elevation: 0,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
            child: custom.searchField(
                context,
                searchCtr,
                "Search appointments",
                TextInputType.text,
                const Text(""),
                const Icon(Icons.search_rounded), () {
              Get.toNamed(RouteHelper.DSearchAppointment());
            }, () {}),
          ),
        ),
        // centerTitle: true,
        bottom: TabBar(
          controller: tabController,
          indicatorColor: Colors.black,
          indicatorWeight: 2,
          tabs: [
            Tab(
              child: custom.text("Pending", 14, FontWeight.w500, MyColor.black),
            ),
            Tab(
              child: Tab(
                child:
                    custom.text("Upcoming", 14, FontWeight.w500, MyColor.black),
              ),
            ),
            Tab(
              child: Tab(
                child: custom.text(
                    "Completed", 14, FontWeight.w500, MyColor.black),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 17),
          child: Stack(children: [
            TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: tabController,
                children: const [
                  DoctorPendingAppointment(),
                  DoctorUpcomingAppointment(),
                  DoctorCompleteAppoint(),
                ]),
          ])),
    );
  }
}

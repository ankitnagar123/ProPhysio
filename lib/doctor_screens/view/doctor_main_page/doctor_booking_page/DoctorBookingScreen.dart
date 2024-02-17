import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../../helper/CustomView/CustomView.dart';
import '../../../../helper/mycolor/mycolor.dart';
import '../../../../language_translator/LanguageTranslate.dart';
import '../../../controller/DocotorBookingController.dart';
import 'DoctorCancelAppointment.dart';
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
  LocalString text = LocalString();
  BookingController bookingController = Get.put(BookingController());

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 108,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white24,
        flexibleSpace: Container(),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: MyColor.primary.withOpacity(0.60)),
        elevation: 0,
        title: Column(
          children: [
            Image(
              image: AssetImage("assets/images/runlogo.png"),
              height: 40,
              width: 40,
            ),
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 3.0, right: 3.0, top: 10.0),
                child: custom.searchField(
                    context,
                    searchCtr,
                    text.searchAppointment.tr,
                    TextInputType.text,
                    const Text(""),
                    const Icon(Icons.search_rounded), () async {
                  var data = {"data": "pending"};
                  var result = await Get.toNamed(
                      RouteHelper.DSearchAppointment(),
                      parameters: data);

                  if (result == true) {
                    bookingController.bookingAppointmentPending(
                        context, "", "");
                    setState(() {
                      tabController?.index = 0;
                    });
                  }
                }, () {}),
              ),
            ),
          ],
        ),
        // centerTitle: true,
        bottom: TabBar(
isScrollable: true,
          padding: EdgeInsets.all(0),
          indicatorSize: TabBarIndicatorSize.tab,
          onTap: (value) {
            log("number${tabController?.index}");
          },
          labelColor: MyColor.red,
          controller: tabController,
          indicatorColor: MyColor.red,
          indicatorWeight: 2,
          tabs: [

            Tab(
              child: custom.text(
                  text.pending.tr, 12, FontWeight.w500, MyColor.black),
            ),
            Tab(
              child: Tab(
                child: custom.text(
                    text.upcoming.tr, 12, FontWeight.w500, MyColor.black),
              ),
            ),
            Tab(
              child: Tab(
                child: custom.text(
                    text.Complete.tr, 12, FontWeight.w500, MyColor.black),
              ),
            ),
            Tab(
              child: Tab(
                child: custom.text("Cancel", 12, FontWeight.w500, MyColor.black),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
          child: Stack(children: [
            TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: tabController,
                children: const [
                  DoctorPendingAppointment(),
                  DoctorUpcomingAppointment(),
                  DoctorCompleteAppoint(),
                  DoctorCancelAppoint(),
                ]),
          ])),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../../../helper/CustomView/CustomView.dart';
import '../../../../../../helper/mycolor/mycolor.dart';
import 'DoctorAddAvailability.dart';


class AddAvailabilityTab extends StatefulWidget {

  const AddAvailabilityTab({
    Key? key,
  }) : super(key: key);

  @override
  State<AddAvailabilityTab> createState() => _AddAvailabilityTabState();
}

class _AddAvailabilityTabState extends State<AddAvailabilityTab>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  TextEditingController searchCtr = TextEditingController();
  CustomView custom = CustomView();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: MyColor.white,
        toolbarHeight: 10,
        bottom: TabBar(
          controller: tabController,
          indicatorColor: MyColor.primary,
          indicatorWeight: 2,
          tabs: [
            Tab(
              child: custom.text(
                  "Self", 14, FontWeight.w500, MyColor.black),
            ),
            Tab(
              child: Tab(
                child: custom.text(
                    "Medical center", 14, FontWeight.w500, MyColor.black),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 17),
          child: Stack(children: [
            TabBarView(controller: tabController, children: [
              MyAvailability(),
              Text("no data"),
            ]),
          ])),
    );
  }
}

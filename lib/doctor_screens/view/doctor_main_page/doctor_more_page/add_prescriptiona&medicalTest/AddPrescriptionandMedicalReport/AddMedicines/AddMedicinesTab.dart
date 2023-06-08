import 'package:flutter/material.dart';

import '../../../../../../../helper/CustomView/CustomView.dart';
import '../../../../../../../helper/mycolor/mycolor.dart';
import 'DrAddMedicines.dart';
import 'ViewMedicines.dart';


class AddMedicinesTab extends StatefulWidget {
  String patientId;

  AddMedicinesTab({
    Key? key,
    required this.patientId,
  }) : super(key: key);

  @override
  State<AddMedicinesTab> createState() => _AddMedicinesTabState();
}

class _AddMedicinesTabState extends State<AddMedicinesTab>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  String pId = "";

  @override
  void initState() {
    pId = widget.patientId;
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
                  "Add Medicine", 14, FontWeight.w500, MyColor.black),
            ),
            Tab(
              child: Tab(
                child: custom.text(
                    "View Medicine", 14, FontWeight.w500, MyColor.black),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 17),
          child: Stack(children: [
            TabBarView(controller: tabController, children: [
              DrAddMedicines(patientId: widget.patientId,),
              DrViewMedicines(patientId: widget.patientId,),
            ]),
          ])),
    );
  }
}

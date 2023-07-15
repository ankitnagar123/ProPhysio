import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../helper/CustomView/CustomView.dart';
import '../../../../../../../helper/mycolor/mycolor.dart';
import '../../../../../../../language_translator/LanguageTranslate.dart';
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
  LocalString text = LocalString();
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
        toolbarHeight: 0,
        bottom: TabBar(
          controller: tabController,
          indicatorColor: MyColor.primary,
          tabs: [
            Tab(
              child: custom.text(
                  text.AddMedicine.tr, 14, FontWeight.w500, MyColor.black),
            ),
            Tab(
              child: Tab(
                child: custom.text(
                    text.View_Medicine.tr, 14, FontWeight.w500, MyColor.black),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 15),
          child: Stack(children: [
            TabBarView(
                physics: const NeverScrollableScrollPhysics(),controller: tabController, children: [
              DrAddMedicines(patientId: widget.patientId,),
              DrViewMedicines(patientId: widget.patientId,),
            ]),
          ])),
    );
  }
}

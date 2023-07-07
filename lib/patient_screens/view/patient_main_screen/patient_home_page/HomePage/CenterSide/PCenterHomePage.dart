import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:medica/helper/Shimmer/ChatShimmer.dart';
import 'package:medica/helper/mycolor/mycolor.dart';
import 'package:medica/patient_screens/controller/patinet_center_controller/PCenterController.dart';

import 'CenterMapView/PcenterList.dart';
import 'CenterMapView/PcenterMapViewList.dart';
import 'PCenterDetailsPage.dart';

class PCenterHomeScreen extends StatefulWidget {
  const PCenterHomeScreen({Key? key}) : super(key: key);

  @override
  State<PCenterHomeScreen> createState() => _PCenterHomeScreenState();
}

class _PCenterHomeScreenState extends State<PCenterHomeScreen> with SingleTickerProviderStateMixin{
  CustomView customView = CustomView();
  PCenterCtr pCenterCtr = PCenterCtr();
  TabController? tabController;
  int _selectedIndex = 0;
  bool _isListView = true;
  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pCenterCtr.centerListApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Container(
          height: 38.0,
          width: widht * 0.37,
          decoration: BoxDecoration(
              color: MyColor.primary, borderRadius: BorderRadius.circular(30)),
          child: Center(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (_selectedIndex < 1) {
                    _selectedIndex++;
                    _isListView = true;
                  } else {
                    _isListView = false;
                    _selectedIndex = 0;
                  }
                  // _isListView = !_isListView;
                  //
                  // _currentWidget = _isListView ? const DoctorList() : const MapView();
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customView.text(
                      _isListView
                          ? 'View List'
                          : 'View on map'
                          '',
                      14,
                      FontWeight.w500,
                      MyColor.white),
                  const SizedBox(
                    width: 3.0,
                  ),
                  const Icon(
                    Icons.view_agenda_outlined,
                    color: MyColor.white,
                    size: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: tabController,
                children: [
                  IndexedStack(
                    index: _selectedIndex,
                    children: [
                      const PCenterListView(),
                      CenterMapViewScreen()
                      /* MapView(
                          catId: widget.catId.toString(),
                          subCatID: widget.subCatId.toString()),*/
                    ],
                  ),
                ]),
          ),
        ],
      ),
    );
  }

}

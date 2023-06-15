import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:medica/helper/mycolor/mycolor.dart';
import 'package:medica/patient_screens/controller/patinet_center_controller/PCenterController.dart';

import 'PCenterDetailsPage.dart';

class PCenterHomeScreen extends StatefulWidget {
  const PCenterHomeScreen({Key? key}) : super(key: key);

  @override
  State<PCenterHomeScreen> createState() => _PCenterHomeScreenState();
}

class _PCenterHomeScreenState extends State<PCenterHomeScreen> {
  CustomView customView = CustomView();
  PCenterCtr pCenterCtr = PCenterCtr();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pCenterCtr.centerListApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        // await patientBookingController.bookingAppointment("");
        return true;
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 7.0),
        child: Column(
          children: [
            showList(),
          ],
        ),
      ),
    );
  }

  Widget showList() {
    return Obx(() {
      if (pCenterCtr.loadingFetch.value) {
        return Center(heightFactor: 7, child: customView.MyIndicator());
      }
      return pCenterCtr.centerList.isEmpty
          ? Center(
              heightFactor: 10,
              child: customView.text("Center not available at the moment.", 14,
                  FontWeight.w400, MyColor.primary1))
          : SingleChildScrollView(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: pCenterCtr.centerList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    var centerList= pCenterCtr.centerList[index];
                    var id = pCenterCtr.centerList[index].centerId;
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PCenterDetailScreen(
                                      id: id,
                                    )));
                        /*  patientBookingController
                      .bookingAppointmentDetails(context, id!, "", () {
                    showBottomSheet(id);
                  });*/
                      },
                      child: Card(
                        color: MyColor.midgray,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7.0, vertical: 10.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100,
                                height: 100,
                                // margin: const EdgeInsets.all(6),
                                child: Image.network(
                                  centerList.image,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.amber,
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Whoops!',
                                        style: TextStyle(fontSize: 30),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customView.text(
                                      pCenterCtr.centerList[index].name.toString(),
                                      14.0,
                                      FontWeight.w500,
                                      Colors.black),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  customView.text(
                                      pCenterCtr.centerList[index].biography.toString(),
                                      12.0,
                                      FontWeight.w400,
                                      Colors.black),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on_outlined,
                                          size: 18),
                                      SizedBox(
                                        width: 150,
                                        child: customView.text(
                                            pCenterCtr.centerList[index].address,
                                            12,
                                            FontWeight.normal,
                                            MyColor.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],

                          ),
                        ),
                      ),
                    );
                  }),
            );
    });
  }
}

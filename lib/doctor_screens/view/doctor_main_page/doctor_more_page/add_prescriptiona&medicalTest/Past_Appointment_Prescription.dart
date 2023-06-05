import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../controller/DocotorBookingController.dart';
import 'AddPrescriptionandMedicalReport/PrescriptionandMedical.dart';
import 'QRScannerReports/QRScannerPage.dart';

class CompleteAppointPrescription extends StatefulWidget {
  const CompleteAppointPrescription({Key? key}) : super(key: key);

  @override
  State<CompleteAppointPrescription> createState() => _CompleteAppointPrescriptionState();
}

class _CompleteAppointPrescriptionState extends State<CompleteAppointPrescription> {
  CustomView customView = CustomView();
  TextEditingController searchCtr = TextEditingController();
  BookingController bookingController = Get.put(BookingController());
  int selectedCard = -1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bookingController.bookingAppointment(context,"Complete","");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        leading: InkWell(
            onTap: () {
               Get.back();
            },
            child: const Icon(Icons.arrow_back_ios, color: MyColor.black)),
        elevation: 0,
        centerTitle: true,
        title: customView.text("Past Appointment", 17, FontWeight.w500, MyColor.black),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Obx(() {
              if(bookingController.loading.value){
                return Center(
                    heightFactor: 12,child: customView.MyIndicator());
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    showList(),
                  ],
                ),
              );
            }),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const QRScannerDoctor()));
                print("on-tap");
              },
              child: Container(
                  height: 50.0,
                  margin:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: MyColor.lightcolor,
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.qr_code_scanner_sharp,
                          size: 25.0,
                          color: MyColor.primary1,
                        ),
                        const SizedBox(width: 40.00,),
                        customView.text("Scan and check reports", 15.0,
                            FontWeight.w500, MyColor.primary1),

                      ],
                    ),
                  )),
            ),
          ),
        ],

      ),

    );
  }


  Widget showList() {
    return SingleChildScrollView(
      child: bookingController.booking.isEmpty?const Center(heightFactor: 15,child: Text("No Past Appointment's at the moment!"),): ListView.builder(
          shrinkWrap: true,
          itemCount: bookingController.booking.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            var id = bookingController.booking[index].Id.toString();
            var list = bookingController.booking[index];
            return InkWell(
              onTap: () {
                print(id);
Navigator.push(context, MaterialPageRoute(builder: (context)=> PrescriptionMedicalTab(patientId: id,)));
              },
              child: Card(
                color: MyColor.midgray,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 7.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customView.text(
                          list.name.toString(),
                          14.0,
                          FontWeight.w500,
                          Colors.black),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Date",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10.0,
                                      fontFamily: "Poppins"),
                                ),
                                const SizedBox(
                                  height: 2.0,
                                ),
                                Text(
                                    list.bookingDate
                                        .toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.0,
                                        fontFamily: "Poppins")),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Slot",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10.0,
                                      fontFamily: "Poppins"),
                                ),
                                const SizedBox(
                                  height: 2.0,
                                ),
                                Text(
                                  list.time
                                      .toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0,
                                      fontFamily: "Poppins"),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Booking ID",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10.0,
                                      fontFamily: "Poppins"),
                                ),
                                const SizedBox(
                                  height: 2.0,
                                ),
                                Text(
                                  list.bookID
                                      .toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0,
                                      fontFamily: "Poppins"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

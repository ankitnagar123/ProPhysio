import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../../language_translator/LanguageTranslate.dart';
import '../../../../controller/DocotorBookingController.dart';
import 'AddPrescriptionandMedicalReport/PrescriptionandMedical.dart';


class CompleteAppointPrescription extends StatefulWidget {
  const CompleteAppointPrescription({Key? key}) : super(key: key);

  @override
  State<CompleteAppointPrescription> createState() => _CompleteAppointPrescriptionState();
}

class _CompleteAppointPrescriptionState extends State<CompleteAppointPrescription> {
  CustomView customView = CustomView();
  LocalString text = LocalString();
  TextEditingController searchCtr = TextEditingController();
  BookingController bookingController = Get.put(BookingController());
  int selectedCard = -1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bookingController.bookingAppointmentComplete(context, "","");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: const PreferredSize(preferredSize: Size.fromHeight(7),child: Divider()),
        backgroundColor: Colors.white24,
        leading: InkWell(
            onTap: () {
               Get.back();
            },
            child: const Icon(Icons.arrow_back_ios, color: MyColor.black)),
        elevation: 0,
        centerTitle: true,
        title: customView.text(text.pastAppointment.tr, 17, FontWeight.w500, MyColor.black),
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
                padding: const EdgeInsets.symmetric(horizontal: 8),
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
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: InkWell(
          //     onTap: () {
          //       // Navigator.push(context, MaterialPageRoute(builder: (context)=>const QRScannerDoctor()));
          //       print("on-tap");
          //     },
          //     child: Container(
          //         height: 50.0,
          //         margin:
          //         const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
          //         decoration: BoxDecoration(
          //           color: MyColor.lightcolor,
          //           borderRadius: BorderRadius.circular(0.0),
          //         ),
          //         child: Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 13.0),
          //           child: Row(
          //             children: [
          //               const Icon(
          //                 Icons.qr_code_scanner_sharp,
          //                 size: 25.0,
          //                 color: MyColor.primary1,
          //               ),
          //               const SizedBox(width: 40.00,),
          //               customView.text(text.scanAndCheckReports.tr, 15.0,
          //                   FontWeight.w500, MyColor.primary1),
          //
          //             ],
          //           ),
          //         )),
          //   ),
          // ),
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
            var id = bookingController.booking[index].userId.toString();
            var list = bookingController.booking[index];
            var patientName = list.name;
            return InkWell(
              onTap: () {
                print(id);
Navigator.push(context, MaterialPageRoute(builder: (context)=> PrescriptionMedicalTab(patientId: id,patientName: patientName.toString(),)));
              },
              child: Card(
                elevation: 2,
                surfaceTintColor: MyColor.grey,
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
                                 Text(
                                  text.date.tr,
                                  style: const TextStyle(
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
                                 Text(
                                  text.slot.tr,
                                  style: const TextStyle(
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
                                 Text(
                                  text.bookingID.tr,
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10.0,
                                      fontFamily: "Poppins"),
                                ),
                                const SizedBox(
                                  height: 2.0,
                                ),
                                Text(
                                  list.bookId
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

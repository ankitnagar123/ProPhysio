import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/Helper/RoutHelper/RoutHelper.dart';
import 'package:medica/helper/mycolor/mycolor.dart';

import '../../../../helper/CustomView/CustomView.dart';
import '../../../../helper/Shimmer/ChatShimmer.dart';
import '../../../controller/booking_controller_list/PBookingController.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  CustomView customView = CustomView();
  TextEditingController searchCtr = TextEditingController();
  String? cancelId = '';
  String? cancelReason = '';
  PatientBookingController patientBookingController = Get.put(PatientBookingController());

  @override
  void initState() {
    patientBookingController.appointmentCancelReason();
    patientBookingController.bookingAppointment("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(children: [
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              customView.searchFieldnew(
                  context,
                  searchCtr,
                  "Search your appointments",
                  TextInputType.text,
                  Text(""),
                  const Icon(Icons.search_rounded), () {
                Get.toNamed(RouteHelper.getSearchAppointmentScreen());
              }, () {},true),
              const SizedBox(
                height: 7.0,
              ),
              const Divider(),
              showList(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () {
                patientBookingController.bookingAppointment("Complete");
                print("on-tap");
                Get.toNamed(RouteHelper.getPastAppointmentsScreen());
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customView.text("Past appointments", 14.0,
                            FontWeight.w500, MyColor.primary1),
                        const Icon(
                          Icons.arrow_forward,
                          size: 20.0,
                          color: MyColor.primary1,
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ),
      ]),
    );
  }

  Widget showList() {
    return Obx(() {
      if (patientBookingController.loading.value) {
        return categorysubShimmerEffect(context);
      } else if (patientBookingController.booking.isEmpty) {
        return const Text(
            "You don’t have any upcoming or pending appointment right now. Book an appointment  if needed.");
      } else {}
      return SingleChildScrollView(
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 40),
            shrinkWrap: true,
            itemCount: patientBookingController.booking.length,
            itemBuilder: (BuildContext context, int index) {
              var id = patientBookingController.booking[index].bookingId;
              var idDr = patientBookingController.booking[index].doctorId;
              return InkWell(
                onTap: () {
                  patientBookingController
                      .bookingAppointmentDetails(context, id!, "", () {
                    showBottomSheet(id, idDr!);
                  });
                },
                child:
                    patientBookingController.booking[index].status == "Cancel"
                        ? Card(
                            borderOnForeground: true,
                            shadowColor: Colors.red,
                            shape: const RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.red, //<-- SEE HERE
                              ),
                            ),
                            color: Colors.red.shade50,
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7.0, vertical: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 0,
                                        child: Container(
                                          height: 10.0,
                                          width: 10.0,
                                          decoration: BoxDecoration(
                                            color: patientBookingController
                                                        .booking[index]
                                                        .status ==
                                                    "Pending"
                                                ? MyColor.statusYellow
                                                : patientBookingController
                                                            .booking[index]
                                                            .status ==
                                                        "Confirmed"
                                                    ? Colors.green
                                                    : Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 7.0,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: customView.text(
                                            patientBookingController
                                                .booking[index].status
                                                .toString(),
                                            11.0,
                                            FontWeight.w400,
                                            Colors.black),
                                      ),
                                      const Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.black,
                                            size: 18.0,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  customView.text(
                                      "Visit with ${patientBookingController.booking[index].name} ${patientBookingController.booking[index].surname}"
                                          .toString(),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                patientBookingController
                                                    .booking[index].bookingDate
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                              patientBookingController
                                                  .booking[index].time
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
                          )
                        : Card(
                            color: MyColor.midgray,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7.0, vertical: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 0,
                                        child: Container(
                                          height: 10.0,
                                          width: 10.0,
                                          decoration: BoxDecoration(
                                            color: patientBookingController
                                                        .booking[index]
                                                        .status ==
                                                    "Pending"
                                                ? MyColor.statusYellow
                                                : patientBookingController
                                                            .booking[index]
                                                            .status ==
                                                        "Confirmed"
                                                    ? Colors.green
                                                    : Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 7.0,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: customView.text(
                                            patientBookingController
                                                .booking[index].status
                                                .toString(),
                                            11.0,
                                            FontWeight.w400,
                                            Colors.black),
                                      ),
                                      const Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.black,
                                            size: 18.0,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  customView.text(
                                      "Visit with ${patientBookingController.booking[index].name} ${patientBookingController.booking[index].surname}"
                                          .toString(),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                patientBookingController
                                                    .booking[index].bookingDate
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                              patientBookingController
                                                  .booking[index].time
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
    });
  }

  showBottomSheet(String id, String idDr) {
    showModalBottomSheet(
        isDismissible: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(7.0))),
        context: context,
        builder: (BuildContext context) {
          return /* patientBookingController.loadingd.value?customView.MyIndicator():*/ SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 15.0,
                ),
                customView.text("Details", 17.0, FontWeight.w500, Colors.black),
                const SizedBox(
                  height: 7.0,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Doctor information",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11.0,
                                fontFamily: "Poppins"),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(
                              "${patientBookingController.name.value}  ${patientBookingController.surname.value}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: "Poppins")),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Patient",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11.0,
                                fontFamily: "Poppins"),
                          ),
                          SizedBox(
                            height: 2.0,
                          ),
                          Text(
                            "You",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontFamily: "Poppins"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 30.0,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Address",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11.0,
                                fontFamily: "Poppins"),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(patientBookingController.location.value,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: "Poppins")),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 30.0,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Booking information",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11.0,
                                fontFamily: "Poppins"),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(
                              "${patientBookingController.bookingDate.value}  ${patientBookingController.time.value}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: "Poppins")),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 30.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Status",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11.0,
                          fontFamily: "Poppins"),
                    ),
                    const SizedBox(
                      height: 2.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 0,
                          child: Container(
                            height: 10.0,
                            width: 10.0,
                            decoration: BoxDecoration(
                              color: patientBookingController.status.value ==
                                      "Pending"
                                  ? MyColor.statusYellow
                                  : patientBookingController.status.value ==
                                          "Confirmed"
                                      ? Colors.green
                                      : Colors.red,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 7.0,
                        ),
                        Expanded(
                          flex: 1,
                          child: customView.text(
                              patientBookingController.status.value,
                              11.0,
                              FontWeight.w400,
                              Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(
                  height: 30.0,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Payment information",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11.0,
                                fontFamily: "Poppins"),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(patientBookingController.paymentTyp.value,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
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
                            "Total cost",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11.0,
                                fontFamily: "Poppins"),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(
                            patientBookingController.price.value,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontFamily: "Poppins"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    patientBookingController.status.value == "Pending"
                        ? TextButton(
                            onPressed: () {
                              cancelPopUp(context, id, idDr);
                            },
                            child: const Text(
                              "Cancel appointment",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14.0,
                                  fontFamily: "Poppins"),
                            ),
                          )
                        : patientBookingController.status.value == "Confirmed"
                            ? TextButton(
                                onPressed: () {
                                  cancelPopUp(context, id, idDr);
                                },
                                child: const Text(
                                  "Cancel appointment",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14.0,
                                      fontFamily: "Poppins"),
                                ),
                              )
                            : TextButton(
                                onPressed: () {
                                  patientBookingController
                                      .cancelAppointmentRemove(context, id, () {
                                    Get.back();
                                  });
                                },
                                child: const Text(
                                  "Remove from booking section",
                                  style: TextStyle(
                                      color: Colors.red,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.9),
                                )),
                    const SizedBox(
                      height: 8.0,
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  void cancelPopUp(BuildContext context, String id, String DrId) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black54,
        pageBuilder: (context, anim1, anim2) {
          return Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1,
              child: StatefulBuilder(
                builder: (context, StateSetter setState) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: customView.text("Cancel appointment", 17,
                                FontWeight.w500, Colors.black),
                          ),
                          const SizedBox(
                            height: 13.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: customView.text(
                                "Are you sure you want to cancel the appointment? Please select a reason.",
                                12,
                                FontWeight.w400,
                                Colors.black),
                          ),
                          const SizedBox(
                            height: 13.0,
                          ),
                          SingleChildScrollView(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  patientBookingController.cancelReason.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  visualDensity: const VisualDensity(
                                      horizontal: 0, vertical: -2),
                                  leading: Text(patientBookingController
                                      .cancelReason[index].reason),
                                  trailing: Radio<String>(
                                    value: index.toString(),
                                    groupValue: cancelReason,
                                    onChanged: (value) {
                                      setState(() {
                                        cancelReason = value!;
                                        log("....$cancelReason");
                                        cancelId = patientBookingController
                                            .cancelReason[index].id;
                                        log('cardId----------$cancelId');
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: customView.text("Dismiss", 14.0,
                                        FontWeight.w400, MyColor.grey),
                                  )),
                              Expanded(
                                child: patientBookingController
                                        .loadingCancel.value
                                    ? customView.MyIndicator()
                                    : customView.mysButton(
                                        context,
                                        "Cancel appointment",
                                        () {
                                          if(cancelReason == null){
                                            customView.MySnackBar(context, "Select reason");
                                          }else{
                                            patientBookingController
                                                .bookingAppointmentCancel(
                                                context, id, cancelId!,
                                                    () {
                                                  Get.offNamed(RouteHelper
                                                      .getCancelBookingScreen());
                                                });
                                          }

                                        },
                                        Colors.red,
                                        const TextStyle(
                                          fontSize: 13.0,
                                          color: MyColor.white,
                                        ),
                                      ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        });
  }
}

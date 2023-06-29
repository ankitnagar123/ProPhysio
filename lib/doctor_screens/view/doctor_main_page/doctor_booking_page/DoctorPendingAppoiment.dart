import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../helper/CustomView/CustomView.dart';
import '../../../../helper/Shimmer/ChatShimmer.dart';
import '../../../../helper/mycolor/mycolor.dart';
import '../../../controller/DocotorBookingController.dart';

class DoctorPendingAppointment extends StatefulWidget {
  const DoctorPendingAppointment({Key? key}) : super(key: key);

  @override
  State<DoctorPendingAppointment> createState() =>
      _DoctorPendingAppointmentState();
}

class _DoctorPendingAppointmentState extends State<DoctorPendingAppointment> {
  TextEditingController searchCtr = TextEditingController();
  CustomView custom = CustomView();
  BookingController bookingController = Get.put(BookingController());
  int selectedCard = -1;

  @override
  void initState() {
    super.initState();
    bookingController.bookingAppointment(context, "Pending", "");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Obx(() {
        if (bookingController.loading.value) {
          return categorysubShimmerEffect(context);
        }
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                custom.text("${bookingController.booking.length} results", 14,
                    FontWeight.normal, MyColor.grey.withOpacity(0.70)),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 25.0,
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: custom.text("Sort by:", 17,
                                      FontWeight.w500, MyColor.black),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                ListTile(
                                    visualDensity: const VisualDensity(
                                        horizontal: -4, vertical: -4),
                                    onTap: () {
                                      setState(() {
                                        selectedCard = 0;
                                      });
                                      bookingController.bookingAppointment(
                                          context, "Pending", "linear");
                                      Get.back();
                                    },
                                    leading: custom.text("Date: linear", 15,
                                        FontWeight.normal, MyColor.black),
                                    trailing: selectedCard == 0
                                        ? const Icon(Icons.check_outlined,
                                            color: MyColor.lightblue)
                                        : const Text("")),
                                const Divider(
                                  thickness: 1.5,
                                ),
                                ListTile(
                                    visualDensity: const VisualDensity(
                                        horizontal: -4, vertical: -4),
                                    onTap: () {
                                      setState(() {
                                        selectedCard = 1;
                                      });
                                      bookingController.bookingAppointment(
                                          context, "Pending", "reverse");
                                      Get.back();
                                    },
                                    leading: custom.text("Date: reverse", 15,
                                        FontWeight.normal, MyColor.black),
                                    trailing: selectedCard == 1
                                        ? const Icon(Icons.check_outlined,
                                            color: MyColor.lightblue)
                                        : const Text("")),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Wrap(
                    children: [
                      custom.text("Sort by: ", 14, FontWeight.normal,
                          MyColor.grey.withOpacity(0.70)),
                      custom.text("Date", 14, FontWeight.w500, MyColor.black),
                      const Icon(
                        Icons.keyboard_arrow_down,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            showList(),
          ],
        );
      }),
    );
  }

  /*------------Booking PENDING List--------------*/
  Widget showList() {
    return SingleChildScrollView(
      child: bookingController.booking.isEmpty
          ? const Center(
              heightFactor: 15,
              child: Text("No Pending Appointment's at the moment!"),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: bookingController.booking.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                var bookingId =
                    bookingController.booking[index].bookingId.toString();
                var pendingList = bookingController.booking[index];
                return InkWell(
                  onTap: () {
                    bookingController.bookingAppointmentDetails(
                        context, bookingId, "Pending", () {
                      showBottomSheet(bookingId);
                    });
                  },
                  child: Card(
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
                                    color: MyColor.statusYellow,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 7.0,
                              ),
                              Expanded(
                                flex: 1,
                                child: custom.text(
                                    pendingList.status.toString(),
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
                          custom.text(pendingList.name.toString(), 14.0,
                              FontWeight.w500, Colors.black),
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
                                    Text(pendingList.bookingDate.toString(),
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
                                      pendingList.time.toString(),
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
                                      pendingList.bookID.toString(),
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

  /*------------Booking PENDING List Details--------------*/
  showBottomSheet(String id) {
    showModalBottomSheet(
        isDismissible: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(7.0))),
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: /*bookingController.loadingd == true
              ? Container(
              width: 100,
              height: 100,
              child: Center(child: custom.MyIndicator()))
              :*/
                Obx(() {
              return Column(
                children: [
                  const SizedBox(
                    height: 15.0,
                  ),
                  custom.text("Details", 17.0, FontWeight.w500, Colors.black),
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
                              "Patient",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11.0,
                                  fontFamily: "Poppins"),
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Text(bookingController.name.value,
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
                              "Patient ID",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11.0,
                                  fontFamily: "Poppins"),
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Text(
                              bookingController.patientId.value,
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
                                "${bookingController.bookingDate.value}   ${bookingController.time.value}",
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
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              bookingController.status.value,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11.0,
                                  fontFamily: "Poppins"),
                            ),
                          ),
                          const Expanded(
                            flex: 1,
                            child: Text(
                              "Booking ID",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11.0,
                                  fontFamily: "Poppins"),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 2.0,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 10.0,
                            width: 10.0,
                            decoration: BoxDecoration(
                              color: MyColor.statusYellow,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          const SizedBox(
                            width: 7.0,
                          ),
                          /*-----------*/
                          Expanded(
                            flex: 1,
                            child: custom.text(bookingController.status.value,
                                11.0, FontWeight.w400, Colors.black),
                          ),
                          Expanded(
                            flex: 1,
                            child: custom.text(bookingController.bookId.value,
                                11.0, FontWeight.w400, Colors.black),
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
                            Text(bookingController.paymentTyp.value,
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
                              "Fees",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11.0,
                                  fontFamily: "Poppins"),
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Text(
                              bookingController.price.value,
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
                            Text(bookingController.location.value,
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
                    height: 25.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        bookingController.loadingReject.value
                            ? Center(
                          widthFactor: 10,
                                child: custom.MyIndicator(),
                              )
                            : custom.acceptRejectButton(context, "Reject", () {
                                bookingController
                                    .bookingAppointmentReject(context, id, () {
                                  bookingController.bookingAppointment(
                                      context, "Pending", "");
                                  Get.back();
                                });
                              }, MyColor.midgray,
                                const TextStyle(color: MyColor.primary)),
                        custom.acceptRejectButton(context, "Accept", () {
                          acceptPopUp(context, id);
                        }, MyColor.primary,
                            const TextStyle(color: MyColor.white))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  )
                ],
              );
            }),
          );
        });
  }

  /*------------Booking PENDING ACCEPT POPUP--------------*/
  void acceptPopUp(BuildContext context, String bookingId) {
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
                            child: custom.text("Accept request", 17,
                                FontWeight.w500, Colors.black),
                          ),
                          const SizedBox(
                            height: 13.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: custom.text(
                                "Are you sure you want to accept the visit? You will find it in upcoming appointmntes.",
                                12,
                                FontWeight.w400,
                                Colors.black),
                          ),
                          const SizedBox(
                            height: 13.0,
                          ),
                          Obx(() {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: TextButton(
                                      onPressed: () {
                                        // Get.back();
                                      },
                                      child: custom.text("Dismiss", 14.0,
                                          FontWeight.w400, MyColor.grey),
                                    )),
                                Expanded(
                                  child: bookingController.loadingAccept.value
                                      ? Center(child: custom.MyIndicator())
                                      : custom.mysButton(
                                          context,
                                          "Yes, accept",
                                          () {
                                            bookingController
                                                .bookingAppointmentAccept(
                                                    context, bookingId, () {
                                              bookingController
                                                  .bookingAppointment(
                                                      context, "Pending", "");
                                              Get.back();
                                              Get.back();
                                            });

                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //         const CancelAppointmentSuccess()));
                                          },
                                          MyColor.primary,
                                          const TextStyle(
                                            fontSize: 13.0,
                                            color: MyColor.white,
                                          ),
                                        ),
                                ),
                              ],
                            );
                          })
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

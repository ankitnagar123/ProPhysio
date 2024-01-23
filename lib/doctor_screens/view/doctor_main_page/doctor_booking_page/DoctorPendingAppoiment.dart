import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../helper/CustomView/CustomView.dart';
import '../../../../helper/Shimmer/ChatShimmer.dart';
import '../../../../helper/mycolor/mycolor.dart';
import '../../../../language_translator/LanguageTranslate.dart';
import '../../../controller/DocotorBookingController.dart';

class DoctorPendingAppointment extends StatefulWidget {
  const DoctorPendingAppointment({super.key});

  @override
  State<DoctorPendingAppointment> createState() =>
      _DoctorPendingAppointmentState();
}

class _DoctorPendingAppointmentState extends State<DoctorPendingAppointment> {
  TextEditingController searchCtr = TextEditingController();
  LocalString text = LocalString();
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
                custom.text("${bookingController.booking.length} ${text.results.tr}", 14,
                    FontWeight.normal, MyColor.grey.withOpacity(0.70)),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
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
                                  child: custom.text("${text.Sort_by.tr} :", 17,
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
                                          context, text.pending.tr, text.linear.tr);
                                      Get.back();
                                    },
                                    leading: custom.text("${text.date}: ${text.linear.tr}", 15,
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
                                          context, text.pending, text.reverse.tr);
                                      Get.back();
                                    },
                                    leading: custom.text("${text.date.tr}: ${text.reverse.tr}", 15,
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
                      custom.text(text.Sort_by.tr, 14, FontWeight.normal,
                          MyColor.grey.withOpacity(0.70)),
                      custom.text(text.date.tr, 14, FontWeight.w500, MyColor.black),
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
          ?  Center(
              heightFactor: 15,
              child: Text(text.NoPendingAppoint.tr),
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
                    color: Colors.white,
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7.0, vertical: 8.0),
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
                                    text.Pending.tr,
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
                          custom.text(pendingList.name.toString().toUpperCase(), 14.0,
                              FontWeight.w400, Colors.black),
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
        isScrollControlled: true,
        isDismissible: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.0))),
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
                  custom.text(text.details.tr, 17.0, FontWeight.w500, Colors.black),
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
                             Text(
                              text.patient.tr,
                              style: const TextStyle(
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
                             Text(
                              text.PatientId.tr,
                              style: const TextStyle(
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
                   Divider(
                    color: MyColor.grey.withOpacity(0.5),
                    height: 30.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                             text.bookingInformation.tr,
                              style: const TextStyle(
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
                   Divider(
                    color: MyColor.grey.withOpacity(0.5),
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
                              text.status.tr,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11.0,
                                  fontFamily: "Poppins"),
                            ),
                          ),
                           Expanded(
                            flex: 1,
                            child: Text(
                             text.bookingID.tr,
                              style: const TextStyle(
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
                            child: custom.text(text.Pending.tr,
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
                   Divider(
                    color: MyColor.grey.withOpacity(0.5),
                    height: 30.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                              text.paymentInformation.tr,
                              style: const TextStyle(
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
                             Text(
                              text.fees.tr,
                              style: const TextStyle(
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
                   Divider(
                    color: MyColor.grey.withOpacity(0.5),
                    height: 30.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                              text.address.tr,
                              style: const TextStyle(
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
                Divider(
                    color: MyColor.grey.withOpacity(0.5),
                    height: 25,
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
                            : custom.acceptRejectButton(context, text.reject.tr, () {
                                bookingController
                                    .bookingAppointmentReject(context, id, () {
                                  bookingController.bookingAppointment(
                                      context, "Pending", "");
                                  Get.back();
                                });
                              }, MyColor.midgray,
                                const TextStyle(color: MyColor.primary)),
                        custom.acceptRejectButton(context, text.accept.tr, () {
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
                            child: custom.text(text.Accept_request.tr, 17,
                                FontWeight.w500, Colors.black),
                          ),
                          const SizedBox(
                            height: 13.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: custom.text(
                               text.AcceptVisitLine.tr,
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
                                         Get.back();
                                         Get.back();
                                      },
                                      child: custom.text(text.Dismiss.tr, 14.0,
                                          FontWeight.w400, MyColor.grey),
                                    )),
                                Expanded(
                                  child: bookingController.loadingAccept.value
                                      ? Center(child: custom.MyIndicator())
                                      : custom.mysButton(
                                          context,
                                          text.Yes_accept.tr,
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

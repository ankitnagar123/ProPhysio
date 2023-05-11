import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../../helper/CustomView/CustomView.dart';
import '../../../../helper/Shimmer/ChatShimmer.dart';
import '../../../../helper/mycolor/mycolor.dart';
import '../../../controller/DocotorBookingController.dart';

class DoctorUpcomingAppointment extends StatefulWidget {
  const DoctorUpcomingAppointment({Key? key}) : super(key: key);

  @override
  State<DoctorUpcomingAppointment> createState() =>
      _DoctorUpcomingAppointmentState();
}

class _DoctorUpcomingAppointmentState extends State<DoctorUpcomingAppointment> {

  TextEditingController searchCtr = TextEditingController();
  CustomView custom = CustomView();
  BookingController bookingController = Get.put(BookingController());
  String? cancelId = '';
  String? cancelReason = '';
  int selectedCard = -1;

  @override
  void initState() {
    bookingController.bookingAppointment(context,"Confirmed","");
    bookingController.appointmentCancelReason();
    super.initState();
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
                                          context,"Confirmed", "linear");
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
                                          context,"Confirmed", "reverse");
                                      Get.back();
                                    },
                                    leading: custom.text(
                                        "Date: reverse",
                                        15,
                                        FontWeight.normal,
                                        MyColor.black),
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

  /*------------Booking UPCOMING List--------------*/
  Widget showList() {
    return SingleChildScrollView(
      child: bookingController.booking.isEmpty
          ? const Center(
              heightFactor: 15,
              child: Text("No Upcoming Appointment at the moment!"),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: bookingController.booking.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                var id = bookingController.booking[index].Id.toString();

                return InkWell(
                  onTap: () {
                    var userid = bookingController.booking[index].id.toString();
                    print(id);
                    print(userid);
                    log("user id $userid");
                    bookingController.bookingAppointmentDetails(
                        context, id, "Confirmed", () {
                      showBottomSheet(id, userid);
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
                                    color: Colors.green,
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
                                    bookingController.booking[index].status
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
                          custom.text(
                              bookingController.booking[index].name.toString(),
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
                                        bookingController
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
                                      bookingController.booking[index].time
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
                                      bookingController.booking[index].bookID
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

  /*------------Booking UPCOMING DETAILS List--------------*/
  showBottomSheet(String id, String userid) {
    print("object$userid");
    showModalBottomSheet(
        isDismissible: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(7.0))),
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
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
                            color: Colors.green,
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
                      custom.callButton(context, "Call", () {
                        UrlLauncher.launchUrl(Uri.parse(
                            'tel:${bookingController.contact.value}'));
                      },
                          MyColor.primary,
                          const TextStyle(
                            color: MyColor.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          Icons.call),
                      custom.callButton(
                          context,
                          "Chat",
                          () {
                            var patientId ={
                              "ID": bookingController.userId.value,
                            };
                            Get.toNamed(RouteHelper.DChatScreen(),arguments: patientId);
                          },
                          MyColor.primary,
                          const TextStyle(
                            color: MyColor.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          Icons.chat_bubble_outline_outlined)
                    ],
                  ),
                ),
                custom.callButton(context, "Complete", () {
                  bookingController.bookingAppointmentDone(context, id, () {
                    bookingController.bookingAppointment(context,"Confirmed","");
                    Get.back();
                  });
                },
                    MyColor.primary,
                    const TextStyle(
                      color: MyColor.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    Icons.done),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        cancelPopUp(context, id, userid);
                      },
                      child: const Text(
                        "Cancel appointment",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.red,
                            fontSize: 13.0,
                            fontFamily: "Poppins"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  /*------------Booking UPCOMING CANCEL POPUP List--------------*/
  void cancelPopUp(BuildContext context, String id, String userId) {
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
                            child: custom.text("Cancel appointment", 17,
                                FontWeight.w500, Colors.black),
                          ),
                          const SizedBox(
                            height: 13.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: custom.text(
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
                              itemCount: bookingController.cancelReason.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  visualDensity: const VisualDensity(
                                      horizontal: 0, vertical: -2),
                                  leading: Text(bookingController
                                      .cancelReason[index].reason),
                                  trailing: Radio<String>(
                                    value: index.toString(),
                                    groupValue: cancelReason,
                                    onChanged: (value) {
                                      setState(() {
                                        cancelReason = value!;
                                        print("....$cancelReason");
                                        cancelId = bookingController
                                            .cancelReason[index].id;
                                        print('cardId----------$cancelId');
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
                                    child: custom.text("Dismiss", 14.0,
                                        FontWeight.w400, MyColor.grey),
                                  )),
                              Expanded(
                                child: bookingController.loadingCancel.value
                                    ? custom.MyIndicator()
                                    : custom.mysButton(
                                        context,
                                        "Cancel appointment",
                                        () {
                                          bookingController
                                              .bookingAppointmentCancel(
                                                  context, id,cancelId!, () {
                                            Get.offNamed(RouteHelper
                                                .DCancelAppointSucces());
                                          });
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

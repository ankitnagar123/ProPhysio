import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medica/Helper/RoutHelper/RoutHelper.dart';
import 'package:medica/helper/Shimmer/ChatShimmer.dart';
import 'package:medica/helper/sharedpreference/SharedPrefrenc.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../../../../helper/CustomView/CustomView.dart';
import '../../../../helper/mycolor/mycolor.dart';
import '../../../../patient_screens/controller/patinet_chat_controller/PatinetChatController.dart';
import '../../../../signin_screen/signin_controller/SignInController.dart';
import '../../../controller/DocotorBookingController.dart';
import '../doctor_more_page/add_prescriptiona&medicalTest/AddPrescriptionandMedicalReport/PrescriptionandMedical.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({Key? key}) : super(key: key);

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  String cdate1 = DateFormat("EEEEE, dd").format(DateTime.now());

  TextEditingController searchCtr = TextEditingController();
  CustomView custom = CustomView();

  ChatController chatController = Get.put(ChatController());
  BookingController bookingController = Get.put(BookingController());
  LoginCtr loginCtr = LoginCtr();
  SharedPreferenceProvider sp = SharedPreferenceProvider();

  String? id;
  String? userTyp;
  String? deviceId;
  String? deviceTyp;

  @override
  void initState() {
    super.initState();
    chatController.doctorReceivedMsgListFetch(
        context, bookingController.userId.value);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bookingController.appointmentCancelReason();
      getValue();
      bookingController.bookingAppointment(context, "", "");
    });
  }

  String? cancelId = '';
  String? cancelReason = '';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: custom.text(
                    "${bookingController.booking.length} meetings",
                    12,
                    FontWeight.normal,
                    MyColor.grey.withOpacity(0.70)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  custom.text(cdate1, 19, FontWeight.w600, MyColor.black),
                  Wrap(
                    spacing: 15.0,
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: MyColor.midgray,
                        ),
                        child: const Center(
                          child:
                          Icon(Icons.arrow_back_ios_new_outlined, size: 18),
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: MyColor.primary,
                        ),
                        child: const Center(
                          child: Icon(Icons.arrow_forward_ios,
                              size: 18, color: MyColor.white),
                        ),
                      )
                    ],
                  )
                ],
              ),
              const Divider(),
              SizedBox(
                height: height * 0.04,
              ),
              custom.searchField(
                  context,
                  searchCtr,
                  "Search appointments",
                  TextInputType.text,
                  const Text(""),
                  const Icon(Icons.search_rounded), () {
                Get.toNamed(RouteHelper.DSearchAppointment());
              }, () {}),
              SizedBox(
                height: height * 0.04,
              ),
              Obx(() {
                if (bookingController.loading.value) {
                  return categorysubShimmerEffect(context);
                }
                return showList();
              }),
            ],
          ),
        ),
      ),
    );
  }

/*------------Booking All List--------------*/
  Widget showList() {
    return SingleChildScrollView(
      child: bookingController.booking.isEmpty
          ? const Center(
        heightFactor: 15,
        child: Text("No Appointment's at the moment!"),
      )
          : ListView.builder(
          shrinkWrap: true,
          itemCount: bookingController.booking.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            var bookingId =
            bookingController.booking[index].bookingId.toString();
            var userid = bookingController.booking[index].id.toString();
            log("user id$userid");
            log("booking id$id");

            var list = bookingController.booking[index];
            var status = bookingController.booking[index].status!;
            return InkWell(
              onTap: () {
                bookingController.bookingAppointmentDetails(
                    context,
                    bookingId,
                    bookingController.booking[index].status.toString(), () {
                  showBottomSheet(bookingId, userid, status);
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
                                color: list.status == "Pending"
                                    ? MyColor.statusYellow
                                    : list.status == "Cancel"
                                    ? Colors.red
                                    : Colors.green,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 7.0,
                          ),
                          Expanded(
                            flex: 1,
                            child: custom.text(list.status.toString(), 11.0,
                                FontWeight.w400, Colors.black),
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
                      custom.text(list.name.toString(), 14.0,
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
                                Text(list.bookingDate.toString(),
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
                                  list.time.toString(),
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
                                  list.bookID.toString(),
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

  /*------------Booking List Details--------------*/
  showBottomSheet(String id, String userid, String status) {
    print("object$userid");
    showModalBottomSheet(
        isDismissible: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(7.0))),
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Obx(() {
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
                                "${bookingController.bookingDate
                                    .value}   ${bookingController.time.value}",
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
                              color: status == "Pending"
                                  ? MyColor.statusYellow
                                  : status == "Cancel"
                                  ? Colors.red
                                  : Colors.green,
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
                  status == "Pending"
                      ? Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        custom.acceptRejectButton(context, "Reject", () {
                          bookingController
                              .bookingAppointmentReject(context, id, () {
                            bookingController.bookingAppointment(
                                context, "", "");
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
                  )
                      : status == "Confirmed"
                      ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
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
                            custom.callButton(context, "Chat", () {
                              var patientId = {
                                "ID": bookingController.userId.value,
                                "userName": bookingController.username.value,
                                "userProfile": bookingController.userPic.value,
                                "userLocation": bookingController.location.value,
                                "userContact": bookingController.contact.value,
                                 "surName": bookingController.surname.value,
                                "name": bookingController.name.value,
                                "bookingSide": "booking",
                              };
                              Get.toNamed(RouteHelper.DChatScreen(),
                                  arguments: patientId);
                              chatController.doctorReceivedMsgListFetch(
                                  context,
                                  bookingController.userId.value);
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
                      Row(
                        children: [
                          custom.callButton(
                              context, "Write prescription", () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PrescriptionMedicalTab(
                                          patientId: userid,
                                        )));
                          },
                              MyColor.primary,
                              const TextStyle(
                                color: MyColor.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                              Icons.medical_information_outlined),
                          custom.callButton(context, "Complete", () {
                            bookingController.bookingAppointmentDone(
                                context, id, () {
                              bookingController.bookingAppointment(
                                  context, "", "");
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
                        ],
                      ),
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
                      ),
                    ],
                  )
                      : const Text(""),
                ],
              );
            }),
          );
        });
  }

  /*------------Booking Cancel PopUp--------------*/
  void cancelPopUp(BuildContext context, String id, String userId) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
        MaterialLocalizations
            .of(context)
            .modalBarrierDismissLabel,
        barrierColor: Colors.black54,
        pageBuilder: (context, anim1, anim2) {
          return Center(
            child: SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 1,
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
                                        context, id, cancelId!, () {
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

  /*------------Booking Accept PopUp--------------*/
  void acceptPopUp(BuildContext context, String bookingId) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
        MaterialLocalizations
            .of(context)
            .modalBarrierDismissLabel,
        barrierColor: Colors.black54,
        pageBuilder: (context, anim1, anim2) {
          return Center(
            child: SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 1,
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
                                        Get.back();
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
                                          context, bookingId.toString(),
                                              () {
                                                bookingController.bookingAppointment(context, "", "");
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

  void getValue() async {
    id = await sp.getStringValue(sp.DOCTOR_ID_KEY);
    deviceTyp = await sp.getStringValue(sp.CURRENT_DEVICE_KEY);
    deviceId = await sp.getStringValue(sp.FIREBASE_TOKEN_KEY);
    // userTyp = await sp.getStringValue(sp.CURRENT_DEVICE_KEY);

    loginCtr.updateToken(context, id!, "Doctor", deviceId!, deviceTyp!);
  }
}

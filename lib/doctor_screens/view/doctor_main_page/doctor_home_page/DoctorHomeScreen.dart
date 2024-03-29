import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../../helper/CustomView/CustomView.dart';
import '../../../../helper/Shimmer/ChatShimmer.dart';
import '../../../../helper/mycolor/mycolor.dart';
import '../../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../../../language_translator/LanguageTranslate.dart';
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
  LocalString text = LocalString();
  ChatController chatController = Get.put(ChatController());
  BookingController bookingController = Get.put(BookingController());
  LoginCtr loginCtr = LoginCtr();
  SharedPreferenceProvider sp = SharedPreferenceProvider();

  String? id;
  String? userTyp;
  String? deviceId;
  String? deviceTyp;
  int selectedCard = -1;

  @override
  void initState() {
    super.initState();

    // callController.initilize(id.toString());

/*    chatController.doctorReceivedMsgListFetch(
        context, bookingController.userId.value);*/
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getValue();
      bookingController.bookingAppointment(context, "", "");
      bookingController.appointmentCancelReason();
    });
  }

  String? cancelId = '';
  String? cancelReason = '';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.010,
              ),
              const Image(
                image: AssetImage("assets/images/runlogo.png"),
                height: 45,
                width: 45,
              ),
              // Obx(() {
              //   return Padding(
              //     padding: const EdgeInsets.only(left: 8.0),
              //     child: Align(
              //       alignment: Alignment.topLeft,
              //       child: custom.text(
              //           "${bookingController.booking.length} ${text.meetings.tr}",
              //           12,
              //           FontWeight.normal,
              //           MyColor.grey.withOpacity(0.70)),
              //     ),
              //   );
              // }),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: custom.text(cdate1, 19, FontWeight.w500, MyColor.black),
                ),
              ),
              const Divider(color: Colors.grey),
              SizedBox(
                height: height * 0.015,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: custom.searchField(
                    context,
                    searchCtr,
                    text.SearchAppointment.tr,
                    TextInputType.text,
                    const Text(""),
                    const Icon(
                      Icons.search_rounded,
                      color: Colors.black,
                    ), () async {
                  var data = {"data": "home"};
                  var result = await Get.toNamed(RouteHelper.DSearchAppointment(),
                      parameters: data);
        
                  if (result == true) {
                    bookingController.bookingAppointment(context, "", "");
                  }
                }, () {}),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
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
                                    height: 15.0,
                                  ),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: custom.text("${text.Filters.tr} :", 17,
                                        FontWeight.w500, MyColor.black),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: custom.mysButton(
                                          context,
                                          "Today",
                                          () {
                                            setState(() {
                                              selectedCard = 0;
                                            });
                                            bookingController.bookingAppointment(
                                                context, "", "Today");
                                            Get.back();
                                          },
                                          selectedCard == 0
                                              ? MyColor.primary
                                              : MyColor.white,
                                          TextStyle(
                                              fontSize: 11,
                                              fontFamily: "Poppins",
                                              color: selectedCard == 0
                                                  ? MyColor.white
                                                  : MyColor.primary1),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: custom.mysButton(
                                          context,
                                          "Weekly",
                                          () {
                                            setState(() {
                                              selectedCard = 1;
                                            });
                                            bookingController.bookingAppointment(
                                                context, "", "Weekly");
                                            Get.back();
                                          },
                                          selectedCard == 1
                                              ? MyColor.primary
                                              : MyColor.white,
                                          TextStyle(
                                              fontSize: 11,
                                              fontFamily: "Poppins",
                                              color: selectedCard == 1
                                                  ? MyColor.white
                                                  : MyColor.primary1),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: custom.mysButton(
                                          context,
                                          "Monthly",
                                          () {
                                            setState(() {
                                              selectedCard = 2;
                                            });
                                            bookingController.bookingAppointment(
                                                context, "", "Monthly");
                                            Get.back();
                                          },
                                          selectedCard == 2
                                              ? MyColor.primary
                                              : MyColor.white,
                                          TextStyle(
                                              fontSize: 11,
                                              fontFamily: "Poppins",
                                              color: selectedCard == 2
                                                  ? MyColor.white
                                                  : MyColor.primary1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Wrap(
                      children: [
                        custom.text(
                            text.Filters.tr, 14, FontWeight.w500, MyColor.black),
                        const Icon(
                          Icons.filter_list_alt,
                          color: MyColor.primary1,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Obx(() {
                if (bookingController.loading.value) {
                  return categorysubShimmerEffect(context);
                }
        
                return Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: showList(),
                );
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
          ? Center(
              heightFactor: 15,
              child: Text(text.No_Appointments_moment.tr),
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
                var status = bookingController.booking[index].status;
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
                    color: MyColor.white,
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
                                    color: list.status == "Pending"
                                        ? MyColor.statusYellow
                                        : list.status == "Cancel"
                                            ? Colors.red
                                            : list.status == "Complete"
                                                ? MyColor.primary1
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
                                child: custom.text(
                                    list.status == "Pending"
                                        ? text.Pending.tr
                                        : list.status == "Cancel"
                                            ? text.Cancel.tr
                                            : list.status == "Complete"
                                                ? text.Complete.tr
                                                : text.Upcoming.tr,
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
                                      list.bookId.toString(),
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
    log("object$userid");
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
            child: Obx(() {
              return Column(
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  custom.text(
                      text.details.tr, 17.0, FontWeight.w500, Colors.black),
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
                              color: status == "Pending"
                                  ? MyColor.statusYellow
                                  : status == "Cancel"
                                      ? Colors.red
                                      : status == "Complete"
                                          ? MyColor.primary1
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
                            child: custom.text(
                                bookingController.status.value == "Pending"
                                    ? text.Pending.tr
                                    : bookingController.status.value == "Cancel"
                                        ? text.Cancel.tr
                                        : bookingController.status.value ==
                                                "Complete"
                                            ? text.Complete.tr
                                            : text.Upcoming.tr,
                                11.0,
                                FontWeight.w400,
                                Colors.black),
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
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       flex: 1,
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             text.paymentInformation.tr,
                  //             style: const TextStyle(
                  //                 color: Colors.grey,
                  //                 fontSize: 11.0,
                  //                 fontFamily: "Poppins"),
                  //           ),
                  //           const SizedBox(
                  //             height: 2.0,
                  //           ),
                  //           Text(bookingController.paymentTyp.value,
                  //               style: const TextStyle(
                  //                   color: Colors.black,
                  //                   fontSize: 14.0,
                  //                   fontFamily: "Poppins")),
                  //         ],
                  //       ),
                  //     ),
                  //     Expanded(
                  //       flex: 1,
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             text.fees.tr,
                  //             style: const TextStyle(
                  //                 color: Colors.grey,
                  //                 fontSize: 11.0,
                  //                 fontFamily: "Poppins"),
                  //           ),
                  //           const SizedBox(
                  //             height: 2.0,
                  //           ),
                  //           Text(
                  //             bookingController.price.value,
                  //             style: const TextStyle(
                  //                 color: Colors.black,
                  //                 fontSize: 14.0,
                  //                 fontFamily: "Poppins"),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  //  Divider(
                  //   color: MyColor.grey.withOpacity(0.5),
                  //   height: 30.0,
                  // ),
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
                  status == "Pending"
                      ? Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              custom.acceptRejectButton(context, text.reject.tr,
                                  () {
                                cancelPopUp(context, id, userid);
                              }, MyColor.midgray,
                                  const TextStyle(color: MyColor.primary)),
                              custom.acceptRejectButton(context, text.accept.tr,
                                  () {
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
                                      custom.callButton(context, text.call.tr,
                                          () {
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
                                      custom.callButton(context, text.chat.tr,
                                          () {
                                        var patientId = {
                                          "ID": bookingController.userId.value,
                                          "userName":
                                              bookingController.username.value,
                                          "userProfile":
                                              bookingController.userPic.value,
                                          "userLocation":
                                              bookingController.location.value,
                                          "userContact":
                                              bookingController.contact.value,
                                          "surName":
                                              bookingController.surname.value,
                                          "name": bookingController.name.value,
                                          "bookingSide": "booking",
                                        };
                                        print(patientId);
                                        Get.toNamed(RouteHelper.DChatScreen(),
                                            arguments: patientId);
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
                                        context, text.prescription.tr, () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PrescriptionMedicalTab(
                                                    patientId: userid,
                                                    patientName:
                                                        bookingController
                                                            .name.value,
                                                  )));
                                    },
                                        MyColor.primary,
                                        const TextStyle(
                                          color: MyColor.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                        Icons.medical_information_outlined),
                                    custom.callButton(context, text.Complete.tr,
                                        () {
                                      bookingController.bookingAppointmentDone(
                                          context, id, () {
                                        bookingController.bookingAppointment(context, "", "");
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
                              ],
                            )
                          : status == "Complete"
                              ? const Text("")
                              : Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            text.cancelReason.tr,
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 11.0,
                                                fontFamily: "Poppins"),
                                          ),
                                          const SizedBox(
                                            height: 2.0,
                                          ),
                                          Text(
                                              bookingController
                                                  .reasonCancel.value,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                  fontFamily: "Poppins")),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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
                            child: custom.text(text.cancelAppointment.tr, 17,
                                FontWeight.w500, Colors.black),
                          ),
                          const SizedBox(
                            height: 13.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: custom.text(
                                text.areYouSureYouWantCancelAppointment.tr,
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
                                    child: custom.text(text.Dismiss.tr, 14.0,
                                        FontWeight.w400, MyColor.grey),
                                  )),
                              Expanded(
                                child: bookingController.loadingCancel.value
                                    ? custom.MyIndicator()
                                    : custom.mysButton(
                                        context,
                                        text.cancelAppointment.tr,
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
                            child: custom.text(text.AcceptVisit.tr, 17,
                                FontWeight.w500, Colors.black),
                          ),
                          const SizedBox(
                            height: 13.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: custom.text(text.AcceptVisitLine.tr, 12,
                                FontWeight.w400, Colors.black),
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
                                                    context,
                                                    bookingId.toString(), () {
                                              bookingController.bookingAppointment(context, "", "");
                                              Get.back();
                                              Get.back();
                                            });

                                            // Navigator.push(context,
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

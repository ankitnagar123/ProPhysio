import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../../helper/CustomView/CustomView.dart';
import '../../../../helper/Shimmer/ChatShimmer.dart';
import '../../../../helper/mycolor/mycolor.dart';
import '../../../../language_translator/LanguageTranslate.dart';
import '../../../controller/DocotorBookingController.dart';
import '../doctor_more_page/add_prescriptiona&medicalTest/AddPrescriptionandMedicalReport/PrescriptionandMedical.dart';

class DoctorUpcomingAppointment extends StatefulWidget {
  const DoctorUpcomingAppointment({Key? key}) : super(key: key);

  @override
  State<DoctorUpcomingAppointment> createState() =>
      _DoctorUpcomingAppointmentState();
}

class _DoctorUpcomingAppointmentState extends State<DoctorUpcomingAppointment> {
  TextEditingController searchCtr = TextEditingController();
  CustomView custom = CustomView();
  LocalString text = LocalString();

  BookingController bookingController = Get.put(BookingController());

  int selectedCard = -1;
  int selectedCard1 = -1;

  String today = "Today";
  String weekly = "Weekly";
  String monthly = "Monthly";

  @override
  void initState() {
    bookingController.bookingAppointmentConfirmed(context,"","");
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
                custom.text(
                    "${bookingController.booking.length} ${text.results.tr}",
                    14,
                    FontWeight.normal,
                    MyColor.grey.withOpacity(0.70)),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 7.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(""),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: custom.text("${text.Filters.tr} :",
                                          17, FontWeight.w500, MyColor.black),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: 15.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          bookingController.bookingAppointmentConfirmed(context,"","");
                                          Get.back();
                                          setState(() {
                                            selectedCard1 = -1;
                                            selectedCard = -1;

                                          });
                                        },
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          child: custom.text("Clear ✖", 15,
                                              FontWeight.w500, MyColor.red),
                                        ),
                                      ),
                                    ),
                                  ],
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
                                            selectedCard1 = 0;
                                          });
                                          bookingController.bookingAppointmentConfirmed(context,"",today);


                                          Get.back();
                                        },
                                        selectedCard1 == 0
                                            ? MyColor.primary
                                            : MyColor.white,
                                        TextStyle(
                                            fontSize: 11,
                                            fontFamily: "Poppins",
                                            color: selectedCard1 == 0
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
                                            selectedCard1 = 1;
                                          });
                                          bookingController.bookingAppointmentConfirmed(context,"",weekly);


                                          Get.back();
                                        },
                                        selectedCard1 == 1
                                            ? MyColor.primary
                                            : MyColor.white,
                                        TextStyle(
                                            fontSize: 11,
                                            fontFamily: "Poppins",
                                            color: selectedCard1 == 1
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
                                            selectedCard1 = 2;
                                          });
                                          bookingController.bookingAppointmentConfirmed(context,"",monthly);


                                          Get.back();
                                        },
                                        selectedCard1 == 2
                                            ? MyColor.primary
                                            : MyColor.white,
                                        TextStyle(
                                            fontSize: 11,
                                            fontFamily: "Poppins",
                                            color: selectedCard1 == 2
                                                ? MyColor.white
                                                : MyColor.primary1),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: custom.mysButton(
                                        context,
                                        "Linear",
                                            () {
                                          setState(() {
                                            selectedCard = 0;
                                          });
                                          bookingController.bookingAppointmentConfirmed(context,text.linear.tr,'');
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
                                        "Reverse",
                                            () {
                                          setState(() {
                                            selectedCard = 1;
                                          });
                                          bookingController.bookingAppointmentConfirmed(context,text.reverse.tr,'');

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
          ?  Center(
              heightFactor: 15,
              child: Text(text.NoUpcomingAppoint.tr),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: bookingController.booking.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                var bookingId =
                    bookingController.booking[index].bookingId.toString();
                var upcomingList = bookingController.booking[index];
                return InkWell(
                  onTap: () {
                    var userid = upcomingList.id.toString();
                    print("booking id$bookingId");
                    print(userid);
                    log("user id $userid");
                    bookingController.bookingAppointmentDetails(
                        context, bookingId, "Confirmed", () {
                      showBottomSheet(bookingId, userid);
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
                                    text.Upcoming.tr,
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
                          custom.text(upcomingList.name.toString().toUpperCase(), 14.0,
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
                                    Text(upcomingList.bookingDate.toString(),
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
                                      upcomingList.time.toString(),
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
                                      upcomingList.bookId.toString(),
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
        isScrollControlled: true,
        isDismissible: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.0))),
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
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
                          Text(bookingController.name.value.toUpperCase(),
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
                    height: 30,
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
                    height: 30,
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
                          child: custom.text(text.Upcoming.tr,
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
                    height: 30,
                  ),
               //  Row(
               //    children: [
               //      Expanded(
               //        flex: 1,
               //        child: Column(
               //          crossAxisAlignment: CrossAxisAlignment.start,
               //          children: [
               //             Text(
               //              text.paymentInformation.tr,
               //              style: const TextStyle(
               //                  color: Colors.grey,
               //                  fontSize: 11.0,
               //                  fontFamily: "Poppins"),
               //            ),
               //            const SizedBox(
               //              height: 2.0,
               //            ),
               //            Text(bookingController.paymentTyp.value,
               //                style: const TextStyle(
               //                    color: Colors.black,
               //                    fontSize: 14.0,
               //                    fontFamily: "Poppins")),
               //          ],
               //        ),
               //      ),
               //      Expanded(
               //        flex: 1,
               //        child: Column(
               //          crossAxisAlignment: CrossAxisAlignment.start,
               //          children: [
               //             Text(
               //              text.fees.tr,
               //              style: const TextStyle(
               //                  color: Colors.grey,
               //                  fontSize: 11.0,
               //                  fontFamily: "Poppins"),
               //            ),
               //            const SizedBox(
               //              height: 2.0,
               //            ),
               //            Text(
               //              bookingController.price.value,
               //              style: const TextStyle(
               //                  color: Colors.black,
               //                  fontSize: 14.0,
               //                  fontFamily: "Poppins"),
               //            ),
               //          ],
               //        ),
               //      ),
               //    ],
               //  ),
               // Divider(
               //      color: MyColor.grey.withOpacity(0.5),
               //      height: 30,
               //    ),
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
                const Divider(
                  height: 25.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      custom.callButton(context, text.call.tr, () {
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
                      custom.callButton(context, text.chat.tr, () {
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    custom.callButton(context, text.prescription.tr, () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrescriptionMedicalTab(
                                    patientId: userid,
                                    patientName: bookingController.name.value,
                                  )));
                    },
                        MyColor.primary,
                        const TextStyle(
                          color: MyColor.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        Icons.medical_information_outlined),
                    custom.callButton(context, text.Complete.tr, () {
                      bookingController.bookingAppointmentDone(context, id, () {
                        bookingController.bookingAppointmentConfirmed(
                            context,"","");
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
            ),
          );
        });
  }


}

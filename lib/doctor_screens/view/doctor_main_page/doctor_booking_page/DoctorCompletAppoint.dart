import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../helper/CustomView/CustomView.dart';
import '../../../../helper/Shimmer/ChatShimmer.dart';
import '../../../../helper/mycolor/mycolor.dart';
import '../../../../language_translator/LanguageTranslate.dart';
import '../../../controller/DocotorBookingController.dart';

class DoctorCompleteAppoint extends StatefulWidget {
  const DoctorCompleteAppoint({Key? key}) : super(key: key);

  @override
  State<DoctorCompleteAppoint> createState() => _DoctorCompleteAppointState();
}

class _DoctorCompleteAppointState extends State<DoctorCompleteAppoint> {
  CustomView customView = CustomView();
  LocalString text = LocalString();

  TextEditingController searchCtr = TextEditingController();
  BookingController bookingController = Get.put(BookingController());
  int selectedCard = -1;
  int selectedCard1 = -1;

  String today = "Today";
  String weekly = "Weekly";
  String monthly = "Monthly";

  @override
  void initState() {
    super.initState();

    bookingController.bookingAppointmentComplete(context, "","");
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
                customView.text(
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
                                      child: customView.text("${text.Filters.tr} :",
                                          17, FontWeight.w500, MyColor.black),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: 15.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          bookingController.bookingAppointmentComplete(context, "","");
                                          Get.back();
                                          setState(() {
                                            selectedCard1 = -1;
                                            selectedCard = -1;

                                          });
                                        },
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          child: customView.text("Clear ✖", 15,
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
                                      child: customView.mysButton(
                                        context,
                                        "Today",
                                            () {
                                          setState(() {
                                            selectedCard1 = 0;
                                          });
                                          bookingController.bookingAppointmentComplete(context,"",today);


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
                                      child: customView.mysButton(
                                        context,
                                        "Weekly",
                                            () {
                                          setState(() {
                                            selectedCard1 = 1;
                                          });
                                          bookingController.bookingAppointmentComplete(context,"",weekly);


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
                                      child: customView.mysButton(
                                        context,
                                        "Monthly",
                                            () {
                                          setState(() {
                                            selectedCard1 = 2;
                                          });
                                          bookingController.bookingAppointmentComplete(context,"",monthly);


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
                                      child: customView.mysButton(
                                        context,
                                        "Linear",
                                            () {
                                          setState(() {
                                            selectedCard = 0;
                                          });
                                          bookingController.bookingAppointmentComplete(context,text.linear.tr,'');
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
                                      child: customView.mysButton(
                                        context,
                                        "Reverse",
                                            () {
                                          setState(() {
                                            selectedCard = 1;
                                          });
                                          bookingController.bookingAppointmentComplete(context,text.reverse.tr,'');

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
                      customView.text(
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

  Widget showList() {
    return SingleChildScrollView(
      child: bookingController.booking.isEmpty
          ? Center(
              heightFactor: 15,
              child: Text(text.noPastAppointmentAtTheMoment.tr),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: bookingController.booking.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                var bookingId =
                    bookingController.booking[index].bookingId.toString();
                var completeList = bookingController.booking[index];
                return InkWell(
                  onTap: () {
                    bookingController.bookingAppointmentDetails(
                        context, bookingId, "Complete", () {
                      showBottomSheet(bookingId);
                    });
                  },
                  child: Card(

                    elevation: 1,
                   surfaceTintColor: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customView.text(completeList.name.toString().toUpperCase(), 14.0,
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
                                    Text(completeList.bookingDate.toString(),
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
                                      completeList.time.toString(),
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
                                      completeList.bookId.toString(),
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
                Column(
              children: [
                const SizedBox(
                  height: 15.0,
                ),
                customView.text(
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
                              "${bookingController.bookingDate.value}     ${bookingController.time.value}",
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
               //  Row(
               //    children: [
               //      Expanded(
               //        flex: 1,
               //        child: Column(
               //          crossAxisAlignment: CrossAxisAlignment.start,
               //          children: [
               //            Text(
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
               //            Text(
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
                const SizedBox(
                  height: 10.0,
                )
              ],
            ),
          );
        });
  }
}

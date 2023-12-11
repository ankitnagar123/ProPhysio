import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../../../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../../language_translator/LanguageTranslate.dart';
import '../../../../controller/DocotorBookingController.dart';
import '../../../../model/booking_list_model.dart';
import '../../DoctorMainPage.dart';
import '../../doctor_more_page/add_prescriptiona&medicalTest/AddPrescriptionandMedicalReport/PrescriptionandMedical.dart';

class DoctorSearchAppointments extends StatefulWidget {
  const DoctorSearchAppointments({Key? key}) : super(key: key);

  @override
  State<DoctorSearchAppointments> createState() =>
      _DoctorSearchAppointmentsState();
}

class _DoctorSearchAppointmentsState extends State<DoctorSearchAppointments> {
  CustomView custom = CustomView();
  TextEditingController searchCtr = TextEditingController();
  BookingController bookingController = Get.put(BookingController());
  LocalString text = LocalString();

/*------VARIABLES------*/
  String? cancelId = '';
  String? cancelReason = '';
  String _keyword = '';
  int selectedCard = -1;

  /*----For SEARCH BOOKING LIST-------*/
  List<bookingList> _getFilteredList() {
    if (_keyword.isEmpty) {
      return bookingController.booking;
    }
    return bookingController.booking
        .where(
            (user) => user.name!.toLowerCase().contains(_keyword.toLowerCase()))
        .toList();
  }

  @override
  void initState() {
    bookingController.bookingAppointment(context, "", "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DoctorMainScreen()));
        await bookingController.bookingAppointment(context, "", "");
        return true;
        /*Pending*/
      },
      child: Scaffold(
        // appBar: AppBar(
        //   toolbarHeight: 100,
        //   centerTitle: true,
        //   elevation: 0,
        //   backgroundColor: Colors.white24,
        //   title: Column(
        //     children: [
        //       Image(
        //         image: AssetImage("assets/images/runlogo.png"),
        //         height: 45,
        //         width: 45,
        //       ),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           IconButton(
        //             onPressed: () {
        //               Get.back();
        //               bookingController.bookingAppointment(context, "", "");
        //               /*Pending*/
        //             },
        //             icon: const Icon(Icons.arrow_back_ios, color: MyColor.black),
        //           ),
        //           custom.text(
        //               text.searchAppointment.tr, 17, FontWeight.w500, MyColor.black),
        //           Text(""),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              SizedBox(
                height: 35,
              ),
              Image(
                image: AssetImage("assets/images/runlogo.png"),
                height: 45,
                width: 45,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                      bookingController.bookingAppointment(context, "", "");
                      /*Pending*/
                    },
                    icon:
                        const Icon(Icons.arrow_back_ios, color: MyColor.black,size: 20),
                  ),
                  custom.text(text.searchAppointment.tr, 17, FontWeight.w500,
                      MyColor.black),
                  Text(""),
                ],
              ),
              Divider(color: Colors.black54),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: widht,
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _keyword = value;
                    });
                    print(value);
                  },
                  cursorWidth: 0.0,
                  cursorHeight: 0.0,
                  onTap: () {},
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  cursorColor: Colors.black,
                  controller: searchCtr,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: MyColor.white,
                    suffixIconColor: MyColor.white,
                    contentPadding: const EdgeInsets.only(top: 3, left: 20),
                    hintText: text.searchYourAppointments.tr,
                    hintStyle:
                        const TextStyle(fontSize: 12, color: MyColor.white),
                    labelStyle:
                        const TextStyle(fontSize: 12, color: MyColor.white),
                    fillColor: MyColor.lightcolor,
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: custom.mysButton(
                      context,
                      text.upcoming.tr,
                      () {
                        setState(() {
                          selectedCard = 0;
                        });
                        bookingController.bookingAppointment(
                            context, "Confirmed", "");
                      },
                      selectedCard == 0 ? MyColor.primary : MyColor.white,
                      TextStyle(
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
                      text.pending.tr,
                      () {
                        setState(() {
                          selectedCard = 1;
                        });
                        bookingController.bookingAppointment(
                            context, "Pending", "");
                      },
                      selectedCard == 1 ? MyColor.primary : MyColor.white,
                      TextStyle(
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
                      text.pastVisits.tr,
                      () {
                        setState(() {
                          selectedCard = 2;
                        });
                        bookingController.bookingAppointment(
                            context, "Complete", "");
                      },
                      selectedCard == 2 ? MyColor.primary : MyColor.white,
                      TextStyle(
                          fontFamily: "Poppins",
                          color: selectedCard == 2
                              ? MyColor.white
                              : MyColor.primary1),
                    ),
                  ),
                ],
              ),
              showList(),
            ],
          ),
        ),
      ),
    );
  }

  /*------------Booking All List--------------*/
  Widget showList() {
    final list = _getFilteredList();
    return Obx(() {
      if (bookingController.loading.value) {
        return Center(
          heightFactor: 10,
          child: custom.MyIndicator(),
        );
      } else if (bookingController.booking.isEmpty) {
        return Center(
            heightFactor: 5.0, child: Text(text.No_Appointments_moment.tr));
      }
      return SingleChildScrollView(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              var bookingId = list[index].bookingId.toString();
              var userid = list[index].id.toString();
              var status = list[index].status.toString();
              return InkWell(
                onTap: () {
                  bookingController.bookingAppointmentDetails(
                      context, bookingId, list[index].status!, () {
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
                                  color: list[index].status == "Pending"
                                      ? MyColor.statusYellow
                                      : list[index].status == "Cancel"
                                          ? Colors.red
                                          : list[index].status == "Complete"
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
                                  list[index].status == "Pending"
                                      ? text.Pending.tr
                                      : list[index].status == "Cancel"
                                          ? text.Cancel.tr
                                          : list[index].status == "Complete"
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
                        custom.text(list[index].name.toString(), 14.0,
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
                                  Text(list[index].bookingDate.toString(),
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
                                    list[index].time.toString(),
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
                                    list[index].bookID.toString(),
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
            child: Column(
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
                status == "Pending"
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            custom.acceptRejectButton(context, text.reject.tr,
                                () {
                              bookingController
                                  .bookingAppointmentReject(context, id, () {
                                bookingController.bookingAppointment(
                                    context, "Pending", "");
                                Get.back();
                              });
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
                                                  patientName: bookingController
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
                                    child: Text(
                                      text.cancelAppointment.tr,
                                      style: const TextStyle(
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
                        : Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    Text(bookingController.reasonCancel.value,
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
                  height: 20.0,
                ),
              ],
            ),
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
                                          if (cancelReason == "") {
                                            custom.MySnackBar(context, "");
                                          } else {
                                            bookingController
                                                .bookingAppointmentCancel(
                                                    context,
                                                    id,
                                                    cancelId.toString(), () {
                                              Get.offNamed(RouteHelper
                                                  .DCancelAppointSucces());
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
                            child: custom.text(text.accept.tr, 17,
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
                          Row(
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
                                    ? custom.MyIndicator()
                                    : custom.mysButton(
                                        context,
                                        text.Yes_accept.tr,
                                        () {
                                          bookingController
                                              .bookingAppointmentAccept(
                                                  context, bookingId, () {
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

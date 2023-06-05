import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../../../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../controller/DocotorBookingController.dart';
import '../../../../model/booking_list_model.dart';

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
    bookingController.bookingAppointment(context,"", "");
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: ()async {
        Get.back();
         await  bookingController.bookingAppointment(context,"Pending", "");
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white24,
          title: custom.text(
              "Search appointment", 17, FontWeight.bold, MyColor.black),
          leading: IconButton(
            onPressed: () {
              Get.back();
              bookingController.bookingAppointment(context,"Pending", "");
            },
            icon: const Icon(Icons.arrow_back_ios, color: MyColor.black),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
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
                    prefixIconColor: MyColor.primary1,
                    suffixIcon: InkWell(
                        onTap: () {
                          Get.toNamed(RouteHelper.getFilterScreen());
                        },
                        child: const Icon(Icons.filter_list_alt)),
                    suffixIconColor: MyColor.primary1,
                    contentPadding: const EdgeInsets.only(top: 3, left: 20),
                    hintText: "search doctor",
                    hintStyle: const TextStyle(fontSize: 12, color: MyColor.primary1),
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
              const Divider(),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: custom.mysButton(
                      context,
                      "Upcoming",
                      () {
                        setState(() {
                          selectedCard = 0;
                        });
                        bookingController.bookingAppointment(context,"Confirmed", "");
                      },
                      selectedCard == 0 ? MyColor.primary : MyColor.white,
                      const TextStyle(
                          fontFamily: "Poppins", color: MyColor.primary1),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: custom.mysButton(
                      context,
                      "Pending",
                      () {
                        setState(() {
                          selectedCard = 1;
                        });
                        bookingController.bookingAppointment(context,"Pending", "");
                      },
                      selectedCard == 1 ? MyColor.primary : MyColor.white,
                      const TextStyle(
                          fontFamily: "Poppins", color: MyColor.primary1),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: custom.mysButton(
                      context,
                      "Past visits",
                      () {
                        setState(() {
                          selectedCard = 2;
                        });
                        bookingController.bookingAppointment(context,"Complete", "");
                      },
                      selectedCard == 2 ? MyColor.primary : MyColor.white,
                      const TextStyle(
                          fontFamily: "Poppins", color: MyColor.primary1),
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
        return const Center(heightFactor: 5.0,
            child: Text("No Appointment's at the moment!"));
      }
      return SingleChildScrollView(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              var id = list[index].Id.toString();
              var userid = list[index].id.toString();
              var status = list[index].status!;
              return InkWell(
                onTap: () {
                  bookingController.bookingAppointmentDetails(
                      context, id, list[index].status!, () {
                    showBottomSheet(id, userid, status);
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
                                      ? MyColor.statusYellow:list[index].status == "Cancel"
                                      ?Colors.red
                                      : list[index].status == "Complete"? MyColor.primary1:Colors.green,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 7.0,
                            ),
                            Expanded(
                              flex: 1,
                              child: custom.text(list[index].status.toString(),
                                  11.0, FontWeight.w400, Colors.black),
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
                            color: status == "Pending"
                                ? MyColor.statusYellow:status == "Cancel"
                                ?Colors.red
                                :status == "Complete"? MyColor.primary1:Colors.green,
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
                            custom.acceptRejectButton(
                                context,
                                "Reject",
                                () {},
                                MyColor.midgray,
                                const TextStyle(color: MyColor.primary)),
                            custom.acceptRejectButton(context, "Accept", () {
                              acceptPopUp(context);
                            }, MyColor.primary,
                                const TextStyle(color: MyColor.white))
                          ],
                        ),
                      )
                    :status == "Confirmed"? Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
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
                            bookingController
                                .bookingAppointmentDone(context, id, () {
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
                          ),
                        ],
                      ):Container(),
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
                                              .bookingAppointmentCancel(context,
                                                  id, cancelId!, () {
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
  void acceptPopUp(BuildContext context) {
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
                          Row(
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
                                    ? custom.MyIndicator()
                                    : custom.mysButton(
                                        context,
                                        "Yes, accept",
                                        () {
                                          bookingController
                                              .bookingAppointmentAccept(
                                                  context,
                                                  bookingController.bookingId
                                                      .toString(), () {
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

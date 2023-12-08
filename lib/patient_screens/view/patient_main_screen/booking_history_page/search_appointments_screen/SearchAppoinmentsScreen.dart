import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../../language_translator/LanguageTranslate.dart';
import '../../../../controller/booking_controller_list/PBookingController.dart';
import '../../../../model/PBookingListModel.dart';

class SearchAppointmentScreen extends StatefulWidget {
  const SearchAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<SearchAppointmentScreen> createState() =>
      _SearchAppointmentScreenState();
}

class _SearchAppointmentScreenState extends State<SearchAppointmentScreen> {
  CustomView customView = CustomView();
  LocalString text = LocalString();

  TextEditingController searchCtr = TextEditingController();
  PatientBookingController patientBookingController = Get.put(PatientBookingController());
  String _keyword = '';
  int selectedCard = -1;

  String? cancelId = '';
  String? cancelReason = '';

  /*----------For SEARCH Functionality*/
  List<PatinetbookingList> _getFilteredList() {
    if (_keyword.isEmpty) {
      return patientBookingController.booking;
    }
    return patientBookingController.booking
        .where(
            (user) => user.name!.toLowerCase().contains(_keyword.toLowerCase()) || user.surname!.toLowerCase().contains(_keyword.toLowerCase()))
        .toList();
  }

  @override
  void initState() {
    patientBookingController.bookingAppointment("");
    // TODO: implement initState
    super.initState();
  }

  final String _groupValue = '';

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async{
        Get.back();
      await patientBookingController.bookingAppointment("");
     return  true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white24,
            title: customView.text(
                text.searchAppointment.tr, 17, FontWeight.bold, MyColor.black),
            leading: IconButton(
              onPressed: () {
                patientBookingController.bookingAppointment("");
                Get.back();
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
                    decoration:  InputDecoration(
                      prefixIcon: const Icon(Icons.search,color: Colors.white,),
                      prefixIconColor: MyColor.white,
                      contentPadding: const EdgeInsets.only(top: 3, left: 20),
                      hintText: text.searchYourAppointments.tr,
                      hintStyle: const TextStyle(fontSize: 12, color: MyColor.white),
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
                 const Divider(color: Colors.grey),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: customView.mysButton(
                        context,
                        text.upcoming.tr,
                        () {
                          setState(() {
                            selectedCard = 0;
                          });
                          patientBookingController
                              .bookingAppointment("Confirmed");
                        },
                        selectedCard == 0 ? MyColor.primary : MyColor.white,
                         TextStyle(
                            fontFamily: "Poppins",  color: selectedCard == 0 ? MyColor.white : MyColor.primary1,),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: customView.mysButton(
                        context,
                        text.pending.tr,
                        () {
                          setState(() {
                            selectedCard = 1;
                          });
                          patientBookingController.bookingAppointment("Pending");
                        },
                        selectedCard == 1 ? MyColor.primary : MyColor.white,
                         TextStyle(
                            fontFamily: "Poppins",  color: selectedCard == 1 ? MyColor.white : MyColor.primary1,),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: customView.mysButton(
                        context,
                        text.pastVisits.tr,
                        () {
                          setState(() {
                            selectedCard = 2;
                          });
                          patientBookingController.bookingAppointment("Complete");
                        },
                        selectedCard == 2 ? MyColor.primary : MyColor.white,
                         TextStyle(
                            fontFamily: "Poppins", color: selectedCard == 2 ? MyColor.white : MyColor.primary1,),
                      ),
                    ),
                  ],
                ),
                showList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showList() {
    final list = _getFilteredList();
    return Obx(() {
      if (patientBookingController.loading.value) {
        return Center(heightFactor: 10, child: customView.MyIndicator());
      } else if (list.isEmpty) {
        return  Center(heightFactor: 5.0,
          child: Text(
              text.youDonHaveAnyAppointmentRight.tr),
        );
      } else {
        return SingleChildScrollView(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                var Drid = list[index].doctorId;
                var id = list[index].bookingId;
                return InkWell(
                  onTap: () {
                    patientBookingController
                        .bookingAppointmentDetails(context, id!, "", () {
                      showBottomSheet(id,Drid.toString());
                    });
                  },
                  child: Card(
                  surfaceTintColor: Colors.grey,
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
                                        : list[index].status == "Confirmed"
                                            ? Colors.green
                                            : list[index].status == "Complete"
                                                ? MyColor.primary
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
                                    patientBookingController
                                        .booking[index].status ==
                                        "Pending"
                                        ? text.Pending.tr
                                        : patientBookingController
                                        .booking[index]
                                        .status ==
                                        "Confirmed"
                                        ? text.Upcoming.tr
                                        : patientBookingController
                                        .booking[index]
                                        .status ==
                                        "Reject"
                                        ? text.reject.tr
                                        : text.Cancel.tr,
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
                              "${text.visitWith.tr} ${list[index].name} ${list[index].surname}"
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
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
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
                                        patientBookingController
                                            .booking[index].bookId
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.0,
                                            fontFamily: "Poppins")),
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
                customView.text(text.details.tr, 17.0, FontWeight.w500, Colors.black),
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
                            text.doctorInformation.tr,
                            style: const TextStyle(
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
                          Text(
                            text.you.tr,
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
                     Text(
                      text.status.tr,
                      style: const TextStyle(
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
                                  :  patientBookingController.status.value
                                  == "Reject"
                                  ? Colors.red: patientBookingController.status.value == "Cancel"? Colors.red:MyColor.primary,
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

                              patientBookingController.status.value ==
                              "Pending"
                          ? text.Pending.tr
                              :  patientBookingController.status.value ==
                          "Confirmed"
                              ? text.Upcoming.tr
                                  :  patientBookingController.status.value
                               == "Reject"
                          ? text.reject.tr
                              : text.Cancel.tr,
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
                           Text(
                            text.totalCost.tr,
                            style: const TextStyle(
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
                patientBookingController.status.value == "Cancel"?
                Row(
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
                          Text(patientBookingController.reasonCancel.value,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: "Poppins")),
                        ],
                      ),
                    ),
                  ],
                ):Container(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    patientBookingController.status.value == "Pending"
                        ? TextButton(
                      onPressed: () {
                        cancelPopUp(context, id, idDr);
                      },
                      child:  Text(
                        text.cancelAppointment.tr,
                        style: const TextStyle(
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
                      child:  Text(
                        text.cancelAppointment.tr,
                        style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14.0,
                            fontFamily: "Poppins"),
                      ),
                    )
                       /* : TextButton(
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
                        )),*/
                    : const SizedBox(
                      height: 5.0,
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
                            child: customView.text(  text.cancelAppointment.tr, 17,
                                FontWeight.w500, Colors.black),
                          ),
                          const SizedBox(
                            height: 13.0,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 5.0),
                            child: customView.text(
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
                                    child: customView.text(text.Dismiss.tr, 14.0,
                                        FontWeight.w400, MyColor.grey),
                                  )),
                              Expanded(
                                child: patientBookingController
                                    .loadingCancel.value
                                    ? customView.MyIndicator()
                                    : customView.mysButton(
                                  context,
                                  text.cancelAppointment.tr,
                                      () {
                                    if(cancelReason == ""){
                                      customView.MySnackBar(context, "");
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

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../helper/CustomView/CustomView.dart';
import '../../../helper/Shimmer/ChatShimmer.dart';
import '../../../helper/mycolor/mycolor.dart';
import '../../../language_translator/LanguageTranslate.dart';
import '../../controller/appointment_controller/AppointmentController.dart';
import "../../controller/auth_controllers/card_controller's/PatientCardController.dart";
import '../../controller/doctor_list_ctr/DoctorListController.dart';

class PatientCheckOutCard extends StatefulWidget {
  String price, time, date, branchId;

  PatientCheckOutCard(
      {Key? key,
      required this.price,
      required this.time,
      required this.date,
      required this.branchId})
      : super(key: key);

  @override
  State<PatientCheckOutCard> createState() => _PatientCheckOutCardState();
}

class _PatientCheckOutCardState extends State<PatientCheckOutCard> {
  AppointmentController appointmentController = AppointmentController();
  DoctorListCtr doctorListCtr = Get.put(DoctorListCtr());
  LocalString text = LocalString();

  CardCtr cardCtr = Get.put(CardCtr());
  String? price;
  String? time;
  String? doctorid;
  String? date;
  String centerId = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      doctorid = doctorListCtr.doctorid.value;
      price = widget.price;
      time = widget.time;
      date = widget.date;
      centerId = widget.branchId;
      log("center id$centerId");
      log("time slot--$time");
      log("price----$price");
      cardCtr.cardFetch();
    });
  }

  String? payment = '';
  String? cardid = '';
  CustomView custom = CustomView();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Obx(() {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: appointmentController.loadingAdd.value
              ? custom.MyIndicator()
              : custom.MyButton(context, text.confirmAppointment.tr, () {
                  if (cardid == "") {
                    custom.MySnackBar(context, text.selectCard.tr);
                  } else {
                    appointmentController.bookingAppointment(context, doctorid.toString(),
                        cardid.toString(), time.toString(), price.toString(), date.toString(), centerId,"Paid", () {
                      Get.offNamed(RouteHelper.getBookingSuccess());
                    });
                  }
                }, MyColor.primary,
                  const TextStyle(color: MyColor.white, fontFamily: "Poppins")),
        ),
        appBar: AppBar(
          bottom: PreferredSize(child: Divider(),preferredSize: Size.fromHeight(5.0)),
          backgroundColor: Colors.white24,
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back_ios, color: MyColor.black)),
          elevation: 0,
          centerTitle: true,
          title: custom.text(text.checkOut.tr, 17, FontWeight.w500, MyColor.black),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: cardCtr.loadingFetch.value
              ? cardLoadingShimmer(width)
              : Column(
                  children: [
                    SizedBox(
                      height: height * 0.02,
                    ),
                    custom.text(
                        text.pleaseSelectPaymentMethodAlreadyEnteredAddCard.tr,
                        13,
                        FontWeight.normal,
                        MyColor.black),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    GestureDetector(
                      onTap: () {
                         Get.toNamed(RouteHelper.getPatientAddNewCardScreen());
                      },
                      child: Container(
                          height: 50.0,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 2.0),
                          decoration: BoxDecoration(
                            color: MyColor.midgray,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 13.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                custom.text(text.addNewCard.tr, 14.0,
                                    FontWeight.w500, MyColor.black),
                                const Icon(
                                  Icons.arrow_forward,
                                  size: 20.0,
                                  color: MyColor.black,
                                ),
                              ],
                            ),
                          )),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Expanded(child: showCardList(width)),
                    SizedBox(
                      height: height * 0.1,
                    ),
                  ],
                ),
        ),
      );
    });
  }

  Widget showCardList(double width) {
    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(5.0),
        itemCount: cardCtr.cardList.length,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: double.infinity,
            child: Card(
              surfaceTintColor: MyColor.white,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        custom.text(
                            text.cardType.tr, 15.0, FontWeight.w500, Colors.black),
                        Radio<String>(
                          activeColor: MyColor.primary1,
                          value: index.toString(),
                          groupValue: payment,
                          onChanged: (value) {
                            setState(() {
                              payment = value!;
                              print("....$payment");
                              cardid = cardCtr.cardList[index].cardId;
                              print('cardId---------$cardid');
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: width / 17,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            custom.text(text.cardNumber.tr, 12.0, FontWeight.w400,
                                Colors.black),
                            custom.text(cardCtr.cardList[index].cardNumber,
                                10.0, FontWeight.w400, Colors.black),
                          ],
                        ),
                        SizedBox(
                          width: width / 23,
                        ),
                        Column(
                          children: [
                            custom.text(
                                text.expires.tr, 12.0, FontWeight.w400, Colors.black),
                            custom.text(
                                "${cardCtr.cardList[index].expiryMonth}/${cardCtr.cardList[index].expiryYear}",
                                13.0,
                                FontWeight.w400,
                                Colors.black),
                          ],
                        ),
                        SizedBox(
                          width: width / 23,
                        ),
                        Column(
                          children: [
                            custom.text(
                                "CVV", 12.0, FontWeight.w400, Colors.black),
                            custom.text(cardCtr.cardList[index].cvv, 13.0,
                                FontWeight.w400, Colors.black),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: width / 17,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        custom.text(
                            text.cardHolder.tr, 12.0, FontWeight.w400, Colors.black),
                        custom.text(cardCtr.cardList[index].cardHolderName,
                            13.0, FontWeight.w400, Colors.black),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  bool validation() {
    if (cardid == null) {
      custom.MySnackBar(context,text.selectCard.tr);
    } else {
      return true;
    }
    return false;
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/Helper/RoutHelper/RoutHelper.dart';
import 'package:medica/helper/CustomView/CustomView.dart';

import '../../../helper/Shimmer/ChatShimmer.dart';
import '../../../helper/mycolor/mycolor.dart';
import "../../controller/auth_controllers/card_controller's/PatientCardController.dart";

class PatientPaymentScreen extends StatefulWidget {
  const PatientPaymentScreen({Key? key}) : super(key: key);

  @override
  State<PatientPaymentScreen> createState() => _PatientPaymentScreenState();
}

class _PatientPaymentScreenState extends State<PatientPaymentScreen> {
  CustomView customView = CustomView();
  CardCtr cardCtr = Get.put(CardCtr());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cardCtr.cardFetch();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: customView.text(
              "Payment method", 15.0, FontWeight.w500, Colors.black),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: Obx(() {
          if (cardCtr.loadingFetch.value) {
            return cardLoadingShimmer(width); /* Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Center(child: Image(image: AssetImage("assets/images/loader.gif"),height: 100.0,width: 100.0,)),
              ],
            );*/
          }else if(cardCtr.cardList.isEmpty){
            return const Center(
              heightFactor: 10,
              child: Text("Add a new card in order to pay the visits."),
            );
          }
          return Column(
            children: [
              Expanded(child: showCardList(width)),
            ],
          );
        }),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: customView.MyButton(
            context,
            "Add new card",
                () {
              Get.toNamed(RouteHelper.getPatientAddNewCardScreen());
            },
            MyColor.primary,
            const TextStyle(fontFamily: "Poppins", color: Colors.white),
          ),
        ));
  }

  Widget showCardList(double width) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: cardCtr.cardList.length,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: double.infinity,
            child: Card(
              color: MyColor.midgray,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: width / 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customView.text(
                            "Card", 15.0, FontWeight.w500, Colors.black),
                        InkWell(
                            onTap: () {
                              cancelPopUp(context,index);
                            },
                            child: const Icon(
                              Icons.delete, color: MyColor.black, size: 18,))
                      ],
                    ),
                    SizedBox(
                      height: width / 17,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            customView.text("Card number", 12.0,
                                FontWeight.w400, Colors.black),
                            customView.text(cardCtr.cardList[index].cardNumber,
                                12.0, FontWeight.w400, Colors.black),
                          ],
                        ),
                        SizedBox(
                          width: width / 23,
                        ),
                        Column(
                          children: [
                            customView.text(
                                "Expires", 12.0, FontWeight.w400, Colors.black),
                            customView.text(
                                "${cardCtr.cardList[index]
                                    .expiryMonth}/${cardCtr.cardList[index]
                                    .expiryYear}",
                                12.0,
                                FontWeight.w400,
                                Colors.black),
                          ],
                        ),
                        SizedBox(
                          width: width / 23,
                        ),
                        Column(
                          children: [
                            customView.text(
                                "CVV", 12.0, FontWeight.w400, Colors.black),
                            customView.text(cardCtr.cardList[index].cvv, 12.0,
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
                        customView.text(
                            "Card Holder", 12.0, FontWeight.w400, Colors.black),
                        customView.text(cardCtr.cardList[index].cardHolderName,
                            12.0, FontWeight.w400, Colors.black),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void cancelPopUp(BuildContext context,int index) {
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
                            child: customView.text("Remove Card", 17,
                                FontWeight.w500, Colors.black),
                          ),
                          const SizedBox(
                            height: 13.0,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 5.0),
                            child: customView.text(
                                "Are you sure you want to delete your card?",
                                12,
                                FontWeight.w400,
                                Colors.black),
                          ),
                          const SizedBox(
                            height: 13.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: customView.text("Dismiss", 14.0,
                                    FontWeight.w400, MyColor.grey),
                              ),
                              Obx(() {
                                if(cardCtr.loadingDelete.value){
                                  return customView.MyIndicator();
                                }
                                return customView.mysButton(
                                  context,
                                  "Remove",
                                      () {
                                    cardCtr.cardDelete(context, cardCtr.cardList[index].cardId, () {
                                      Get.back();
                                    });
                                  },
                                  MyColor.primary,
                                  const TextStyle(
                                    fontSize: 13.0,
                                    color: MyColor.white,
                                  ),
                                );
                              }),
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

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../mycolor/mycolor.dart';

Widget loadingShimmer() => Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.1),
      highlightColor: MyColor.primary.withOpacity(0.20),
      period: const Duration(seconds: 1),
      child: Container(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, index) {
                return Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                        padding: EdgeInsets.all(11.0),
                        child: CircleAvatar(
                          maxRadius: 30,
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 10.0,
                          width: MediaQuery.of(context).size.width / 1.5,
                          color: Colors.blueGrey.shade200,
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        Container(
                          height: 7.0,
                          width: 100.0,
                          color: Colors.redAccent,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  height: 25,
                                ),
                                Container(
                                  height: 9,
                                  width: 70,
                                  color: Colors.grey,
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );

Widget categoryShimmerEffect(BuildContext context) {
  return Shimmer.fromColors(
      enabled: true,
      baseColor: Colors.grey.withOpacity(0.1),
      highlightColor: MyColor.primary.withOpacity(0.20),
      period: const Duration(seconds: 1),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            width: 80.0,
            height: 85,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          Container(
            width: 80.0,
            height: 85,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          Container(
            width: 80,
            height: 85.0,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          Container(
            width: 80,
            height: 85.0,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ]),
      ));
}

Widget categorysubShimmerEffect(BuildContext context) {
  return Shimmer.fromColors(
      enabled: true,
      baseColor: Colors.grey.withOpacity(0.1),
      highlightColor: MyColor.primary.withOpacity(0.20),
      period: const Duration(seconds: 1),
      child: Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.18,
                width: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                padding: const EdgeInsets.all(8),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10,bottom: 10),
                height: MediaQuery.of(context).size.height * 0.18,
                width: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                padding: const EdgeInsets.all(8),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.18,
                width: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                padding: const EdgeInsets.all(8),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: MediaQuery.of(context).size.height * 0.18,
                width: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                padding: const EdgeInsets.all(8),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: MediaQuery.of(context).size.height * 0.18,
                width: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                padding: const EdgeInsets.all(8),
              ),
            ],
          )));
}

Widget cardLoadingShimmer(double width) => Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.1),
      highlightColor: MyColor.primary.withOpacity(0.20),
      period: const Duration(seconds: 1),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          child: ListView.builder(
            padding: const EdgeInsets.all(5),
            itemCount: 5,
            itemBuilder: (context, index) {
              return ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  return SizedBox(
                    width: double.infinity,
                    child: Card(
                      margin: const EdgeInsets.all(5),
                      color: MyColor.midgray,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 60,
                            ),
                            SizedBox(
                              height: width / 80,
                            ),
                            Container(
                              width: 60,
                              height: 12,
                              color: Colors.blueGrey.shade200,
                            ),
                            // customView.text(
                            //     "Card", 15.0, FontWeight.w500, Colors.black),
                            SizedBox(
                              width: width / 80,
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      width: width / 50,
                                    ),
                                    SizedBox(
                                      height: width / 50,
                                    ),
                                    SizedBox(
                                      height: width / 50,
                                    ),
                                    Container(
                                      width: 30,
                                      height: 12,
                                      color: Colors.blueGrey.shade200,
                                    ),
                                    Container(
                                      width: 80,
                                      height: 12,
                                      color: Colors.blueGrey.shade200,
                                    ),
                                    // c
                                    // customView.text("Card number", 12.0,
                                    //     FontWeight.w400, Colors.black),
                                    // customView.text(cardCtr.cardList[index].cardNumber,
                                    //     12.0, FontWeight.w400, Colors.black),
                                  ],
                                ),
                                SizedBox(
                                  width: width / 23,
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: width / 50,
                                    ),
                                    SizedBox(
                                      height: width / 50,
                                    ),
                                    // customView.text(
                                    //     "Expires", 12.0, FontWeight.w400, Colors.black),
                                    // customView.text(
                                    //     "${cardCtr.cardList[index].expiryMonth}/${cardCtr.cardList[index].expiryYear}",
                                    //     12.0,
                                    //     FontWeight.w400,
                                    //     Colors.black),
                                  ],
                                ),
                                SizedBox(
                                  width: width / 23,
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: width / 50,
                                    ),
                                    SizedBox(
                                      height: width / 50,
                                    ),
                                    // customView.text(
                                    //     "CVV", 12.0, FontWeight.w400, Colors.black),
                                    // customView.text(cardCtr.cardList[index].cvv, 12.0,
                                    //     FontWeight.w400, Colors.black),
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
                                SizedBox(
                                  height: width / 50,
                                ),
                                SizedBox(
                                  height: width / 50,
                                ),
                                // customView.text(
                                //     "Card Holder", 12.0, FontWeight.w400, Colors.black),
                                // customView.text(cardCtr.cardList[index].cardHolderName,
                                //     12.0, FontWeight.w400, Colors.black),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );

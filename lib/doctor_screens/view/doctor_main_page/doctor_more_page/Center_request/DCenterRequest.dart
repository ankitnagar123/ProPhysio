import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:medica/helper/Shimmer/ChatShimmer.dart';

import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../controller/CenterRequestCtr.dart';

class DCenterRequests extends StatefulWidget {
  const DCenterRequests({Key? key}) : super(key: key);

  @override
  State<DCenterRequests> createState() => _DCenterRequestsState();
}

class _DCenterRequestsState extends State<DCenterRequests> {
  int selectedIndex = -1;
  CustomView custom = CustomView();
  CenterRequest centerRequest = Get.put(CenterRequest());
  String wardId = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      centerRequest.CenterRequestListApi(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios, color: Colors.black)),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: custom.text("Center Request", 15, FontWeight.w400, Colors.black),
      ),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Obx(() {
              if (centerRequest.loading.value) {
                return categorysubShimmerEffect(context);
              }
              return Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: centerRequest.centerRequestList.length,
                    itemBuilder: (context, index) {
                      var centerRqList = centerRequest.centerRequestList[index];
                      return Card(
                        margin: EdgeInsets.all(8),
                        color: MyColor.midgray,
                        elevation: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: 70,
                                  height: 70,
                                  // margin: const EdgeInsets.all(6),
                                  child: Image.network(
                                    centerRqList.image.toString(),
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.amber,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'Whoops!',
                                          style: TextStyle(fontSize: 30),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    custom.text(centerRqList.centerName, 13,
                                        FontWeight.w600, MyColor.black),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                            Icons.medical_services_outlined,
                                            size: 18),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: custom.text(
                                              "Ward: ${centerRqList.wardName}",
                                              13,
                                              FontWeight.normal,
                                              MyColor.grey),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on, size: 18),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: custom.text(
                                              centerRqList.address,
                                              13,
                                              FontWeight.normal,
                                              MyColor.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Obx(() {
                                return Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    if(centerRequest.loadingAccept.value)...[
                                      selectedIndex == index ? custom
                                          .MyIndicator() : custom
                                          .acceptRejectButton(
                                          context, "Accept", () {
                                        setState(() {
                                          selectedIndex = index;
                                        });
                                        wardId = centerRqList.wardId;
                                        if (selectedIndex == index) {
                                          centerRequest
                                              .centerRequestAcceptReject(
                                              context, wardId, "Confirm", () {
                                            centerRequest.CenterRequestListApi(context);
                                          });
                                        }
                                      },
                                          MyColor.primary,
                                          const TextStyle(
                                              color: MyColor.white)),
                                    ] else
                                      ...[
                                        custom.acceptRejectButton(
                                            context, "Accept", () {
                                          setState(() {
                                            selectedIndex = index;
                                          });
                                          wardId = centerRqList.wardId;
                                          centerRequest
                                              .centerRequestAcceptReject(
                                              context,
                                              wardId,
                                              "Confirm",
                                                  () {
                                                setState(() {
                                                  selectedIndex = index;
                                                });
                                                if (selectedIndex == index) {
                                                  centerRequest
                                                      .centerRequestAcceptReject(
                                                      context, wardId,
                                                      "Confirm", () {
                                                    centerRequest.CenterRequestListApi(context);
                                                  });
                                                }
                                              });
                                        },
                                            MyColor.primary,
                                            const TextStyle(
                                                color: MyColor.white)),
                                      ],

                                    custom.acceptRejectButton(
                                        context,
                                        "Reject",
                                            () {},
                                        MyColor.midgray,
                                        const TextStyle(
                                            color: MyColor.primary)),
                                  ],
                                );
                              }),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  // ListView.builder(
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   shrinkWrap: true,
                  //   itemCount: 5,
                  //   itemBuilder: (context, index) {
                  //     return Card(
                  //       color: MyColor.midgray,
                  //       child: ListTile(
                  //           contentPadding: const EdgeInsets.all(12),
                  //           title: custom.text("list.medicineName", 16,
                  //               FontWeight.w400, MyColor.primary1),
                  //           subtitle:      Padding(
                  //             padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 custom.acceptRejectButton(
                  //                     context,
                  //                     "Reject",
                  //                         () {
                  //                     },
                  //                     MyColor.midgray,
                  //                     const TextStyle(color: MyColor.primary)),
                  //                 custom.acceptRejectButton(context, "Accept", () {
                  //                 }, MyColor.primary, const TextStyle(color: MyColor
                  //                     .white))
                  //               ],
                  //             ),
                  //           ),
                  //           trailing: Text("list.medicineSlot")),
                  //
                  //     );
                  //   },
                  // )
                ],
              );
            }),
          )),
    );
  }
}

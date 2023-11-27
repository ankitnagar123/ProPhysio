import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../../language_translator/LanguageTranslate.dart';
import '../../../../controller/CaculateEarningCtr.dart';

class DoctorEarning extends StatefulWidget {
  const DoctorEarning({Key? key}) : super(key: key);

  @override
  State<DoctorEarning> createState() => _DoctorEarningState();
}

class _DoctorEarningState extends State<DoctorEarning> {
  DoctorEarningCtr doctorEarningCtr = Get.put(DoctorEarningCtr());
  LocalString text = LocalString();

  CustomView custom = CustomView();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: MyColor.black,
            )),
        elevation: 0,
        centerTitle: true,
        title: custom.text(text.Earnings.tr, 17, FontWeight.w500, MyColor.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Obx(() {
            if (doctorEarningCtr.loading.value) {
              return custom.MyIndicator();
            }
            return Column(
              children: [
                const Divider(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    custom.text(
                        text.totalEarning.tr, 14, FontWeight.w500, MyColor.black),
                    custom.text(
                         "${doctorEarningCtr.earning.value.startDate.month}/"
                            "${doctorEarningCtr.earning.value.startDate.day}/"
                            "${doctorEarningCtr.earning.value.startDate.year}-"
                            "${doctorEarningCtr.earning.value.endDate.month}/"
                            "${doctorEarningCtr.earning.value.endDate.day}/"
                            "${doctorEarningCtr.earning.value.endDate.year}",
                        13,
                        FontWeight.normal,
                        MyColor.black),
                    custom.text(
                        "€${doctorEarningCtr.earning.value.totalAmount}",
                        14,
                        FontWeight.w500,
                        MyColor.lightblue),
                  ],
                ),
                const Divider(height: 25.0),
                SizedBox(
                  height: height * 0.03,
                ),
                showList(),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget showList() {
    return doctorEarningCtr.earning.value.list.isEmpty
        ?  Text(text.noDataOnParticularDate.tr)
        : ListView.builder(
            shrinkWrap: true,
            itemCount: doctorEarningCtr.earning.value.list.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              var list  = doctorEarningCtr.earning.value.list[index];
              return Card(
                color: MyColor.midgray,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: custom.text(
                                list.bookId,
                                14.0,
                                FontWeight.w500,
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
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
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
                                Text(
                                    "${list.date.month.toString()}/${list.date.day.toString()}/${list.date.year.toString()}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.0,
                                        fontFamily: "Poppins")),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
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
                                  "${list.from.toString()} ${text.To.tr} "
                                  "${list.to.toString()}",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0,
                                      fontFamily: "Poppins"),
                                ),
                              ],
                            ),
                          ),
                          // const SizedBox(
                          //   height: 2.0,
                          // ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Text(
                                  text.fees.tr,
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10.0,
                                      fontFamily: "Poppins"),
                                ),
                                const SizedBox(
                                  height: 2.0,
                                ),
                                Text(
                                  list.price,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
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
              );
            });
  }
}

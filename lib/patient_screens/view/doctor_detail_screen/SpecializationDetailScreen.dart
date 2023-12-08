import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/CustomView/CustomView.dart';
import '../../../helper/mycolor/mycolor.dart';
import '../../../language_translator/LanguageTranslate.dart';
import '../../controller/doctor_list_ctr/DoctorListController.dart';
import '../../controller/doctor_list_ctr/PDoctorSpecializationCtr.dart';

class SpecializationScreen extends StatefulWidget {
  const SpecializationScreen({Key? key}) : super(key: key);

  @override
  State<SpecializationScreen> createState() => _SpecializationScreenState();
}

class _SpecializationScreenState extends State<SpecializationScreen> {
  DoctorSpecializationCtr doctorSpecializationCtr = Get.put(DoctorSpecializationCtr());
  DoctorListCtr doctorListCtr = Get.put(DoctorListCtr());
LocalString text = LocalString();
  CustomView custom = CustomView();
  String? catId;
  String? doctorId;

  @override
  void initState() {
    doctorId = Get.arguments["doctorId"];
    print("doctor Id....$doctorId");
    catId = Get.arguments["catId"];
    print("category id $catId");
    doctorSpecializationCtr.specializationDetails(
        doctorId.toString(), catId.toString());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios, color: MyColor.black)),
        elevation: 0,
        centerTitle: true,
        title:
            custom.text(text.specializations.tr, 17, FontWeight.w500, MyColor.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Obx(() {
            if (doctorSpecializationCtr.loadingFetchD.value) {
              return Center(heightFactor: 12, child: custom.MyIndicator());
            }
            return Column(
              children: [
                 const Divider(color: Colors.grey),
                SizedBox(
                  height: height * 0.022,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(
                      text.category.tr, 13, FontWeight.normal, MyColor.black),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(
                      doctorSpecializationCtr.categoryDetails.value.catName
                          .toString(),
                      17,
                      FontWeight.w500,
                      MyColor.black),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(
                      text.subCategory.tr, 13, FontWeight.normal, MyColor.black),
                ),
                SizedBox(
                  height: height * 0.001,
                ),
                 ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: doctorSpecializationCtr
                      .categoryDetails.value.subcategory?.length,
                  itemBuilder: (context, index) {
                    return  Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: custom.text(
                              doctorSpecializationCtr.categoryDetails.value
                                  .subcategory![index].subcatName.toString(),
                              17,
                              FontWeight.w500,
                              MyColor.black),
                        ), ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: doctorSpecializationCtr
                              .categoryDetails.value.subcategory![index].details?.length,
                          itemBuilder: (context, index1) {
                            return      doctorSpecializationCtr
                                .categoryDetails.value.subcategory![index].details?[index1].name ==""|| doctorSpecializationCtr
                                .categoryDetails.value.subcategory![index].details?[index1].price ==""?const Text(""):Container(
                                height: 50.0,
                                width: MediaQuery.of(context).size.width * 0.9,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 2.0),
                                decoration: BoxDecoration(
                                  color: MyColor.midgray,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 13.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      custom.text(
                                          doctorSpecializationCtr.categoryDetails.value.subcategory![index].details![index1].name
                                              .toString(),
                                          14.0,
                                          FontWeight.normal,
                                          MyColor.primary1),
                                      custom.text(
                                          doctorSpecializationCtr.categoryDetails.value.subcategory![index].details![index1].price

                                              .toString(),
                                          12.0,
                                          FontWeight.normal,
                                          MyColor.primary1),
                                    ],
                                  ),
                                ));
                          },
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: height * 0.02,
                ),

                SizedBox(
                  height: height * 0.022,
                ),
                 const Divider(color: Colors.grey),
                SizedBox(
                  height: height * 0.022,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(
                      text.information.tr, 17, FontWeight.w500, MyColor.black),
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /* const Icon(
                      Icons.home,
                      size: 18,
                      color: MyColor.grey,
                    ),
                    SizedBox(
                      width: widht * 0.01,
                    ),*/
                    // custom.text("Private", 12, FontWeight.normal, MyColor.grey),
                    SizedBox(
                      width: widht * 0.03,
                    ),
                    const Icon(Icons.location_on_outlined,
                        size: 18, color: MyColor.grey),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.66,
                        child: custom.text(
                            doctorListCtr.address.value,
                            12,
                            FontWeight.normal,
                            MyColor.grey)),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: custom.text(
                        doctorSpecializationCtr.categoryDetails.value.description
                            .toString(),
                        13,
                        FontWeight.normal,
                        MyColor.black),
                  ),
                ),
                SizedBox(
                  height: height * 0.030,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

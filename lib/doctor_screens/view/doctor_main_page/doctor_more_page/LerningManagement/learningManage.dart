import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prophysio/doctor_screens/controller/LearningManagemnet/learningManagController.dart';
import '../../../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/Shimmer/ChatShimmer.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../../language_translator/LanguageTranslate.dart';
import 'LearningWeb.dart';

class LearningManage extends StatefulWidget {
  const LearningManage({super.key,});

  @override
  State<LearningManage> createState() => _LearningManageState();
}

class _LearningManageState extends State<LearningManage> {
  LearningManageCtr learningManageCtr = Get.put(LearningManageCtr());
  CustomView customView = CustomView();
  LocalString text = LocalString();
  String? selectLearningType;

  @override
  void initState() {
    super.initState();
    learningManageCtr.learningManageTypeFetch(context).then((value) => {
          learningManageCtr.learningManageList(
              context, learningManageCtr.learningType[0].learningType),
          selectLearningType = learningManageCtr.learningType[0].learningType,
        });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white24,
          title:
              customView.text(text.LMS.tr, 15, FontWeight.w500, MyColor.black),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios, color: MyColor.black),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Obx(
              () => Column(
                children: [
                  SizedBox(height: height * 0.02),
                  learningManageCtr.loadingLearningType.value
                      ? customView.MyIndicator()
                      : branch(),
                  SizedBox(height: height * 0.02),

                  /*----------------------Doctor List--------------------------*/

                  learningManageCtr.loadingLearningList.value
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2.0, vertical: 8),
                          child: Column(
                            children: [
                              categorysubShimmerEffect(context),
                            ],
                          ))
                      : SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: learningManageCtr.learningTypeList.isEmpty
                              ? Center(
                                  heightFactor: 10,
                                  child: Text(text.Doctor_Not_Available.tr))
                              : ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      learningManageCtr.learningTypeList.length,
                                  itemBuilder: (context, index) {
                                    var list = learningManageCtr
                                        .learningTypeList[index];
                                    return GestureDetector(
                                      onTap: () {
                                        var data = {
                                          "id":list.trainingId,
                                        };
                                        Get.toNamed(RouteHelper.DLearningManageWebView(),parameters: data);

                                        // Get.toNamed(RouteHelper.getDoctorDetailScreen(id),);
                                      },
                                      child: Card(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 6.0),
                                        color: MyColor.white,
                                        elevation: 1.4,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 60,
                                              height: 60,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                                child: FadeInImage.assetNetwork(
                                                  imageErrorBuilder: (context,
                                                          error, stackTrace) =>
                                                      const Image(
                                                          image: AssetImage(
                                                              "assets/images/dummyprofile.png"),
                                                          height: 70.0,
                                                          width: 70.0),
                                                  width: 70.0,
                                                  height: 70.0,
                                                  fit: BoxFit.cover,
                                                  placeholder:
                                                      "assets/images/loading.gif",
                                                  image: list.bannerImg,
                                                  placeholderFit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                customView.text(
                                                    list.title.toUpperCase(),
                                                    13,
                                                    FontWeight.w500,
                                                    MyColor.primary1),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                        Icons
                                                            .date_range_rounded,
                                                        size: 18),
                                                    SizedBox(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width /
                                                                1.9,
                                                        child: Text(
                                                          list.date.toString(),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 11,
                                                            fontFamily:
                                                                "Poppins",
                                                            color: MyColor.grey,
                                                          ),
                                                        )),
                                                  ],
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /*---------SELECT BRANCH-----*/
  Widget branch() {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return StatefulBuilder(
      builder: (context, StateSetter stateSetter) => Container(
        height: height * 0.05,
        width: widht * 1,
        padding: const EdgeInsets.all(3),
        // margin: const EdgeInsets.fromLTRB(0, 5, 5.0, 0.0),
        decoration: BoxDecoration(
            color: MyColor.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: MyColor.grey)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            menuMaxHeight: MediaQuery.of(context).size.height / 3,
            // Initial Value
            value: selectLearningType,
            // Down Arrow Icon
            icon: const Icon(Icons.keyboard_arrow_down, color: MyColor.primary),
            // Array list of items
            items: learningManageCtr.learningType.map((items) {
              return DropdownMenuItem(
                value: items.learningType,
                child: Text(items.learningName),
              );
            }).toList(),
            hint: Text(text.LMSTYPE.tr),
            onChanged: (newValue) {
              stateSetter(() {
                selectLearningType = newValue;
                log('MY selected learning >>>$selectLearningType');
                learningManageCtr.learningManageList(
                  context,
                  selectLearningType.toString(),
                );
              });
            },
          ),
        ),
      ),
    );
  }
}

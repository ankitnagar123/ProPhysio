import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/Shimmer/ChatShimmer.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../controller/doctor_list_ctr/DoctorListController.dart';
import 'DoctorListwithCategoy.dart';

class PDrSubCategory extends StatefulWidget {
  String categoryId;

  PDrSubCategory({Key? key, required this.categoryId}) : super(key: key);

  @override
  State<PDrSubCategory> createState() => _PDrSubCategoryState();
}

class _PDrSubCategoryState extends State<PDrSubCategory> {
  CustomView customView = CustomView();
  DoctorListCtr doctorListCtr = Get.put(DoctorListCtr());
  String? subCategoryId;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      doctorListCtr.subCatList(widget.categoryId.toString());
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              "Doctor Sub-Category", 15.0, FontWeight.w500, Colors.black),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white24,
        ),
        body: Obx(() {
          if (doctorListCtr.categoryLoadingSub.value) {
            return  Center(heightFactor: 12,child: customView.MyIndicator());/* categoryShimmerEffect(context);*/
          } else if (doctorListCtr.subCategory.isEmpty) {
            return Center(
              heightFactor: 10.0,
              child: customView.text(
                  "No sub-category", 15, FontWeight.w400, MyColor.primary1),
            );
          } else {
            return Column(
              children: [
                const Divider(),
                Expanded(
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    crossAxisCount: 3,
                    children: List.generate(doctorListCtr.subCategory.length,
                        (index) {
                      return GestureDetector(
                        onTap: () {
                          subCategoryId =
                              doctorListCtr.subCategory[index].subcatId;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DoctorListWithCategory(
                                        catId: widget.categoryId,
                                        subCatId: subCategoryId!,
                                      )));
                        },
                        child: Card(
                          margin: const EdgeInsets.only(
                              left: 6, right: 6, bottom: 3, top: 4),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6.0, top: 5),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                      clipBehavior: Clip.antiAlias,
                                      borderRadius: BorderRadius.circular(13.0),
                                      child: FadeInImage.assetNetwork(
                                        imageErrorBuilder: (c, o, s) =>
                                            Image.asset(
                                                "assets/images/noimage.png",
                                                width: 70,
                                                height: 70,
                                                fit: BoxFit.cover),
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                        placeholder:
                                            "assets/images/loading.gif",
                                        image: doctorListCtr
                                            .subCategory[index].subcatImg,
                                        placeholderFit: BoxFit.cover,
                                      )),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        doctorListCtr
                                            .subCategory[index].subcatName,
                                        style: const TextStyle(fontSize: 13,fontWeight: FontWeight.w500),
                                        softWrap: false,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}

import 'dart:developer';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/doctor_screens/controller/RoutCtr.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:medica/helper/mycolor/mycolor.dart';
import 'package:medica/helper/sharedpreference/SharedPrefrenc.dart';

import '../../../../../doctor_screens/controller/DoctorSignUpController.dart';
import '../../../../../helper/Shimmer/ChatShimmer.dart';
import '../../../../../language_translator/LanguageTranslate.dart';
import '../../../../../signin_screen/signin_controller/SignInController.dart';
import '../../../../controller/doctor_list_ctr/DoctorListController.dart';
import '../category_sub-category/DoctorListwithCategoy.dart';
import '../category_sub-category/PDoctorSubCat.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  MyRoute myRoute = Get.put(MyRoute());
  CustomView customView = CustomView();
  LocalString text = LocalString();
  SharedPreferenceProvider sp = SharedPreferenceProvider();

  LoginCtr loginCtr = LoginCtr();

  DoctorListCtr doctorListCtr = Get.put(DoctorListCtr());
  DoctorSignUpCtr doctorSignUpCtr = Get.put(DoctorSignUpCtr());
  TextEditingController searchCtr = TextEditingController();
  TabController? tabController;
  String? categoryId;
  String? subCategoryId;
  String? catWithSubCatId;

  String? id;
  String? userTyp;
  String? deviceId;
  String? deviceTyp;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getValuee();
      doctorListCtr.catSubCatList();
      doctorSignUpCtr.DoctorCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Obx(() {
        if (doctorListCtr.categoryLoading.value) {
          customView.MyIndicator();
        }
        return Column(
          children: [
            SizedBox(height: height * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12.0, top: 5.0, bottom: 5),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: customView.text(text.Choos_Top_Specialist.tr, 13,
                          FontWeight.w500, MyColor.primary1)),
                ),
                GestureDetector(
                  onTap: () {
                    myRoute.setValue(4);
                    print("object");
                    /*Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const PDrAllCategory()));*/
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.0, top: 5.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          text.SeeAll.tr,
                          style: const TextStyle(
                              decoration: TextDecoration.underline,
                              color: MyColor.primary1),
                        )),
                  ),
                ),
              ],
            ),
            /*  doctorSignUpCtr.categoryloding.value?customView.MyIndicator():*/
            doctorSignUpCtr.categoryloding.value
                ? categoryShimmerEffect(context)
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: doctorSignUpCtr.category.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // myRoute.setValue(5);
                            categoryId =
                                doctorSignUpCtr.category[index].categoryId;
                            print("Selected Category$categoryId");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PDrSubCategory(
                                          categoryId: categoryId.toString(),
                                        )));
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: MyColor.primary1,
                                  offset: Offset(0, 0),
                                  blurRadius: 1,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  ClipRRect(
                                      clipBehavior: ui.Clip.antiAlias,
                                      borderRadius: BorderRadius.circular(13.0),
                                      child: FadeInImage.assetNetwork(
                                        imageErrorBuilder: (c, o, s) =>
                                            Image.asset(
                                                color: MyColor.midgray,
                                                "assets/images/noimage.png",
                                                width: 65,
                                                height: 65,
                                                fit: BoxFit.cover),
                                        width: 65,
                                        height: 65,
                                        fit: BoxFit.cover,
                                        placeholder:
                                            "assets/images/loading.gif",
                                        image: doctorSignUpCtr
                                            .category[index].catImg,
                                        placeholderFit: BoxFit.cover,
                                      )),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        doctorSignUpCtr
                                            .category[index].categoryName,
                                        style: const TextStyle(fontSize: 12),
                                        softWrap: false,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            SizedBox(
              height: height * 0.03,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: customView.text(text.TopSpecialization.tr, 15,
                    FontWeight.w500, MyColor.primary1)),
            doctorListCtr.categoryLoading.value
                ? categorysubShimmerEffect(context)
                : doctorListCtr.catSubCat.isEmpty
                    ? customView.text(text.NoTopSpecialization.tr, 13,
                        FontWeight.w500, MyColor.primary1)
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: doctorListCtr.catSubCat.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Card(
                            color: MyColor.bcolor,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: customView.text(
                                        doctorListCtr
                                            .catSubCat[index].categoryName,
                                        13,
                                        FontWeight.w500,
                                        MyColor.primary1),
                                  ),
                                ),
                                doctorListCtr
                                        .catSubCat[index].subCatDetail.isEmpty
                                    ? Center(
                                        child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(text.NoSubCat.tr,
                                            style: TextStyle(
                                                color: MyColor.primary1,
                                                letterSpacing: 1.1)),
                                      ))
                                    : Align(
                                        alignment: Alignment.topLeft,
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            itemCount: doctorListCtr
                                                .catSubCat[index]
                                                .subCatDetail
                                                .length,
                                            itemBuilder: (context, index1) {
                                              return GestureDetector(
                                                onTap: () {
                                                  subCategoryId = doctorListCtr
                                                      .catSubCat[index]
                                                      .subCatDetail[index1]
                                                      .subcatId;
                                                  catWithSubCatId =
                                                      doctorListCtr
                                                          .catSubCat[index]
                                                          .categoryId;
                                                  log("sub category Id=>${subCategoryId}with category Id=>$catWithSubCatId");
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              DoctorListWithCategory(
                                                                catId: catWithSubCatId
                                                                    .toString(),
                                                                subCatId:
                                                                    subCategoryId
                                                                        .toString(), rating: '', startPrice: '', EndPrice: '',
                                                              )));
                                                },
                                                child: Container(
                                                  margin:
                                                      const EdgeInsets.all(8),
                                                  height: 90,
                                                  width: 90,
                                                  decoration: BoxDecoration(
                                                    color: MyColor.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: MyColor.primary1,
                                                        offset: Offset(0, 0),
                                                        blurRadius: 1.5,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        ClipRRect(
                                                            clipBehavior: ui
                                                                .Clip.antiAlias,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        13.0),
                                                            child: FadeInImage
                                                                .assetNetwork(
                                                              imageErrorBuilder: (c,
                                                                      o, s) =>
                                                                  Image.asset(
                                                                      "assets/images/noimage.png",
                                                                      width: 60,
                                                                      height:
                                                                          60,
                                                                      fit: BoxFit
                                                                          .cover),
                                                              width: 65,
                                                              height: 65,
                                                              fit: BoxFit.cover,
                                                              placeholder:
                                                                  "assets/images/loading.gif",
                                                              image: doctorListCtr
                                                                  .catSubCat[
                                                                      index]
                                                                  .subCatDetail[
                                                                      index1]
                                                                  .subcatImg,
                                                              placeholderFit:
                                                                  BoxFit.cover,
                                                            )),
                                                        Expanded(
                                                          child: Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              doctorListCtr
                                                                  .catSubCat[
                                                                      index]
                                                                  .subCatDetail[
                                                                      index1]
                                                                  .subcatName,
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          10),
                                                              softWrap: true,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      )
                              ],
                            ),
                          );
                        },
                      ),
          ],
        );
      }),
    );
  }

  void getValuee() async {
    id = await sp.getStringValue(sp.PATIENT_ID_KEY);
    deviceTyp = await sp.getStringValue(sp.CURRENT_DEVICE_KEY);
    deviceId = await sp.getStringValue(sp.FIREBASE_TOKEN_KEY);
    // userTyp = await sp.getStringValue(sp.CURRENT_DEVICE_KEY);

    loginCtr.updateToken(context, id!, "User", deviceId!, deviceTyp!);
  }
}

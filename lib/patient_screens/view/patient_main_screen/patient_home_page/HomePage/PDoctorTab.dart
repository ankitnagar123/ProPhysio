import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prophysio/helper/AppConst.dart';

import '../../../../../doctor_screens/controller/DoctorSignUpController.dart';
import '../../../../../doctor_screens/controller/RoutCtr.dart';
import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../../../../language_translator/LanguageTranslate.dart';
import '../../../../../signin_screen/signin_controller/SignInController.dart';
import '../../../../controller/auth_controllers/PatientProfileController.dart';
import '../../../../controller/doctor_list_ctr/DoctorListController.dart';
import '../category_sub-category/DoctorListTab.dart';


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
  PatientProfileCtr profileCtr = Get.put(PatientProfileCtr());

  TabController? tabController;
  String? categoryId;

  String? id;
  String? userTyp;
  String? deviceId;
  String? deviceTyp;

  @override
  void initState() {
    super.initState();
    profileCtr.patientProfile(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getValuee();
      // doctorListCtr.catSubCatList();
      doctorSignUpCtr.DoctorCategory();
      doctorListCtr.doctorlistfetch(
        context,
        "114",
        "",
        "",
        "",
        "",
        "",
      );
    });
  }

  String getTimeOfDay(DateTime currentTime) {
    int hour = currentTime.hour;

    if (hour >= 5 && hour < 12) {
      return 'Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Afternoon';
    } else {
      return 'Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String timeOfDay = getTimeOfDay(now);
    final height = MediaQuery
        .of(context)
        .size
        .height;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Obx(() {
        if (doctorListCtr.categoryLoading.value) {
          customView.MyIndicator();
        }
        return Column(
          children: [
            SizedBox(height: height * 0.05),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Obx(() {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(80.0),
                          child: FadeInImage.assetNetwork(
                            imageErrorBuilder: (c, o, s) =>
                                Image.asset(
                                    "assets/images/dummyprofile.png",
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover),
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            placeholder: "assets/images/loading.gif",
                            image: profileCtr.image.value,
                            placeholderFit: BoxFit.cover,
                          ),
                        ),
 const Divider(color: Colors.grey),
                        const SizedBox(
                          width: 15,
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              customView.text("Good $timeOfDay ☺", 13,
                                  FontWeight.normal, MyColor.grey),
                              customView.text(
                                  "${AppConst.Patient_Name} ${AppConst.Patinet_Surname}".toUpperCase(), 14,
                                  FontWeight.w500, MyColor.primary1)
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.notifications_none_outlined,
                      color: Colors.black54,
                    )
                  ],
                );
              }),
            ),
            SizedBox(height: height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                  const EdgeInsets.only(left: 10.0, top: 5.0,),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: customView.text(
                          text.Choos_Top_Specialist.tr.toUpperCase(),
                          13,
                          FontWeight.w500,
                          MyColor.primary1)),
                ),
                // GestureDetector(
                //   onTap: () {
                //     // Navigator.push(context, MaterialPageRoute(builder: (context) => PrintScreen(),));
                //     myRoute.setValue(4);
                //     log("object");
                //     /*Navigator.push(context, MaterialPageRoute(
                //         builder: (context) => const PDrAllCategory()));*/
                //   },
                //   child: Padding(
                //     padding: const EdgeInsets.only(
                //       right: 8.0,
                //     ),
                //     child: Align(
                //         alignment: Alignment.centerLeft,
                //         child: Text(
                //           "${text.SeeAll.tr}>>",
                //           style: const TextStyle(
                //               decoration: TextDecoration.underline,
                //               color: MyColor.primary1),
                //         )),
                //   ),
                // ),
              ],
            ),
            /*  doctorSignUpCtr.categoryloding.value?customView.MyIndicator():*/
        /*    doctorSignUpCtr.categoryloding.value
                ? categoryShimmerEffect(context)
                : SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.145,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: doctorSignUpCtr.category.length > 4
                    ? 4
                    : doctorSignUpCtr.category.length,
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
                              builder: (context) =>
                                  PDrSubCategory(
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
                                // borderRadius: BorderRadius.circular(13.0),
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
                                      .category[index].categoryName
                                      .toUpperCase(),
                                  style: const TextStyle(fontSize: 10),
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
            ),*/
            doctorSignUpCtr.categoryloding.value?Center(
            heightFactor: 16,
        child: customView.MyIndicator(),
        ):doctorSignUpCtr.category.isEmpty?Center(
            heightFactor: 10.0,
        child: customView.text(
        text.NoCat.tr, 15, FontWeight.w400, MyColor.primary1),
        ):GridView.count(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          crossAxisCount: 3,
          children: List.generate(
              doctorSignUpCtr.category.length, (index) {
            return GestureDetector(
              onTap: () {
                categoryId =
                    doctorSignUpCtr.category[index].categoryId;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DoctorListTab(
                          catId: categoryId,
                          SubCatId: "",
                        )));
              },
              child: Container(
                margin: const EdgeInsets.all(6),
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
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
                          child: FadeInImage.assetNetwork(
                            imageErrorBuilder: (c, o, s) =>
                                Image.asset(
                                    color: MyColor.midgray,
                                    "assets/images/noimage.png",
                                    width: 65,
                                    height: 65,
                                    fit: BoxFit.cover),
                            width: 70,
                            height: 70,
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
                                .category[index].categoryName
                                .toUpperCase(),
                            style: const TextStyle(fontSize: 10,
                              fontFamily: "Poppins",
                            ),
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
          }),
        ),
            Divider(thickness: 2,
                color: MyColor.primary1.withOpacity(0.1),
                height: 30),

       /*     Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: customView.text("Top Rated Doctors", 15,
                      FontWeight.w500, MyColor.primary1)),
            ),
            Obx(() {
              if (doctorListCtr.loadingFetch.value) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 2.0,
                  ),
                  child: Column(
                    children: [
                      categorysubShimmerEffect(context),
                    ],
                  ),
                );
              } else {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: doctorListCtr.doctorList.isEmpty
                      ? Center(
                      heightFactor: 10,
                      child: Text(text.Doctor_Not_Available.tr))
                      : ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: list.length > 3 ? 3 : list.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DoctorDetailScreen(
                                        id: list[index]
                                            .doctorId
                                            .toString(),
                                        centerId: '',
                                        drImg: list[index]
                                            .doctorProfile
                                            .toString(), cat: '', subCat: '',
                                      )));
                          // Get.toNamed(RouteHelper.getDoctorDetailScreen(id),);
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 6.0),
                          color: MyColor.white,
                          elevation: 1.4,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100.0,
                                height: 100.0,
                                // margin: const EdgeInsets.all(6),
                                child: FadeInImage.assetNetwork(
                                    placeholder:
                                    "assets/images/loading.gif",
                                    // placeholderCacheHeight: 20,
                                    // placeholderCacheWidth: 20,
                                    *//*"assets/images/YlWC.gif",*//*
                                    alignment: Alignment.center,
                                    image: list[index]
                                        .doctorProfile
                                        .toString(),
                                    fit: BoxFit.fitWidth,
                                    width: double.infinity,
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/images/noimage.png',
                                        fit: BoxFit.cover,
                                      );
                                    }),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  customView.text(
                                      list[index].name.toUpperCase(),
                                      13,
                                      FontWeight.w500,
                                      MyColor.primary1),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  SizedBox(
                                      width: widht * 0.50,
                                      child: customView.text(
                                          list[index]
                                              .subcategory
                                              .toString(),
                                          12,
                                          FontWeight.w500,
                                          MyColor.black)),
                               *//*   list[index].serviceStatus == "Free"
                                      ? Row(
                                    children: [
                                      const Icon(
                                        Icons.local_hospital,
                                        color: Colors.red,
                                        size: 17,
                                      ),
                                      Align(
                                        alignment:
                                        Alignment.topLeft,
                                        child: customView.text(
                                            "FIRST CONSULTANT FREE",
                                            11,
                                            FontWeight.normal,
                                            Colors.green),
                                      ),
                                    ],
                                  )
                                      : Row(
                                    children: [
                                      *//**//*  const Icon(
                                          Icons.monetization_on,
                                          size: 18),*//**//*
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      customView.text(
                                          "₹ ${list[index].fees.toString()}",
                                          12,
                                          FontWeight.w500,
                                          MyColor.grey),
                                    ],
                                  ),*//*
                                  Row(
                                    children: [
                                      const Icon(
                                          Icons.location_on_outlined,
                                          size: 17,
                                          color: MyColor.grey),
                                      SizedBox(
                                          width:
                                          MediaQuery
                                              .sizeOf(context)
                                              .width /
                                              1.9,
                                          child: Text(
                                            list[index].location,
                                            maxLines: 1,
                                            overflow:
                                            TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 11,
                                              fontFamily: "Poppins",
                                              color: MyColor.grey,
                                            ),
                                          )),
                                    ],
                                  ),
                                  RatingBar(
                                    ignoreGestures: true,
                                    itemSize: 16,
                                    initialRating: double.parse(
                                        list[index].rating.toString()),
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    ratingWidget: RatingWidget(
                                        full: const Icon(Icons.star,
                                            color: Colors.orange),
                                        half: const Icon(Icons.star_half,
                                            color: Colors.orange),
                                        empty: const Icon(
                                            Icons
                                                .star_border_purple500_outlined,
                                            color: Colors.orange)),
                                    itemPadding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 2.0),
                                    onRatingUpdate: (rating) {
                                      log("$rating");
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            }),*/


            /*----------------------------------------------------------------------------------*/
          /*  Divider(thickness: 2,
                color: MyColor.primary1.withOpacity(0.1),
                height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: customView.text("Doctor Speciality", 15,
                      FontWeight.w500, MyColor.primary1)),
            ),
            doctorListCtr.categoryLoading.value
                ? categorysubShimmerEffect(context)
                : doctorListCtr.catSubCat.isEmpty
                ? customView.text(text.NoTopSpecialization.tr, 13,
                FontWeight.w500, MyColor.primary1)
                : ListView.builder(
              padding: EdgeInsets.all(5),
              shrinkWrap: true,
              itemCount: doctorListCtr.catSubCat.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Card(
                  // margin: EdgeInsets.all(5),
                  color: Colors.white,

                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: customView.text(
                              doctorListCtr
                                  .catSubCat[index].categoryName
                                  .toUpperCase(),
                              13,

                              FontWeight.w500,
                              MyColor.primary1),
                        ),
                      ),
                      doctorListCtr
                          .catSubCat[index].subCatDetail.isEmpty
                          ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(text.NoSubCat.tr,
                                style: const TextStyle(
                                    color: MyColor.primary1,
                                    letterSpacing: 1.1)),
                          ))
                          : Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height *
                              0.13,
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
                                  log(
                                      "sub category Id=>${subCategoryId}with category Id=>$catWithSubCatId");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DoctorListTab(
                                                catId: catWithSubCatId
                                                    .toString(),
                                                SubCatId:
                                                subCategoryId
                                                    .toString(),
                                              )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 33,
                                        backgroundImage: NetworkImage(
                                          doctorListCtr
                                              .catSubCat[
                                          index]
                                              .subCatDetail[
                                          index1]
                                              .subcatImg,),
                                      ),
                                      const SizedBox(height: 5,),
                                      SizedBox(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width / 5,
                                        child: Text(doctorListCtr
                                            .catSubCat[
                                        index]
                                            .subCatDetail[
                                        index1]
                                            .subcatName.toUpperCase(),
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 10.5)),
                                      ),
                                    ],
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
            ),*/
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

/*  Widget pageView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 200,
        child: PageView.builder(
          controller: _pageController,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Image.asset(images[index], fit: BoxFit.cover);
          },
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
        ),
      ),
    );
  }*/
}

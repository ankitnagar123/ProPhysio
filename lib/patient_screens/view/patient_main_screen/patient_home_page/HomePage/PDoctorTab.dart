import 'dart:async';
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
                      child: customView.text("Choose from top Specialist", 13,
                          FontWeight.w500, MyColor.primary1)),
                ),
                GestureDetector(
                  onTap: () {
                    myRoute.setValue(4);
                    print("object");
                    /*Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const PDrAllCategory()));*/
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 12.0, top: 5.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "see all",
                          style: TextStyle(
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
                      physics: BouncingScrollPhysics(),
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
                                          categoryId: categoryId!,
                                        )));
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: MyColor.midgray,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: MyColor.primary1,
                                  offset: Offset(0, 0),
                                  blurRadius: 2,
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
                                    height: 5,
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        doctorSignUpCtr
                                            .category[index].categoryName,
                                        style: TextStyle(fontSize: 12),
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
                child: customView.text("Top Specialization ", 15,
                    FontWeight.w500, MyColor.primary1)),
            doctorListCtr.categoryLoading.value
                ? categorysubShimmerEffect(context)
                : doctorListCtr.catSubCat.isEmpty
                    ? const Text("No Top Specification")
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: doctorListCtr.catSubCat.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Card(
                            color: MyColor.midgray,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10.0),
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
                                    ? const Center(
                                        child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("No Sub-Category",
                                            style: TextStyle(
                                                color: MyColor.primary1,
                                                letterSpacing: 1.1)),
                                      ))
                                    : Align(
                                        alignment: Alignment.topLeft,
                                        child: SizedBox(
                                          height: MediaQuery.of(context).size.height*0.14,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            physics: const BouncingScrollPhysics(),
                                            itemCount: doctorListCtr
                                                .catSubCat[index]
                                                .subCatDetail
                                                .length,
                                            itemBuilder: (context, index1) {
                                              return GestureDetector(
                                                onTap: () {
                                                  subCategoryId = doctorListCtr.catSubCat[index].subCatDetail[index1].subcatId;
                                                  catWithSubCatId = doctorListCtr.catSubCat[index].categoryId;
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
                                                                        .toString(),
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
                                                        // Align(
                                                        //   alignment: Alignment.center,
                                                        //   child: customView.text(, 10, FontWeight.normal,
                                                        //       MyColor.black),
                                                        // )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                /*Container(
                                      alignment: Alignment.topLeft,
                                margin: const EdgeInsets.all(8),
                                height: 40,
                                width: 70,
                                decoration: BoxDecoration(
                                    color:  Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: MyColor.primary1,
                                        offset: Offset(0, 0),
                                        blurRadius: 2,
                                      ),
                                    ],
                                ),
                                child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: FadeInImage.assetNetwork(
                                              placeholder: "assets/images/YlWC.gif",
                                              alignment: Alignment.center,
                                              image: doctorListCtr.catSubCat[index]
                                                  .subCatDetail[index1].subcatImg,
                                              height: 50,
                                              // fit: BoxFit.contain,
                                              width: double.infinity,
                                              imageErrorBuilder: (context, error,
                                                  stackTrace) {
                                                return Image.asset(
                                                  'assets/images/MEDICAlogo.png',
                                                  fit: BoxFit.cover,
                                                );
                                              }),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              doctorListCtr.catSubCat[index]
                                                  .subCatDetail[index1].subcatName,
                                              style: TextStyle(fontSize: 12),
                                              softWrap: false,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        // Align(
                                        //   alignment: Alignment.center,
                                        //   child: customView.text(, 10, FontWeight.normal,
                                        //       MyColor.black),
                                        // )
                                      ],
                                    ),
                                ),
                              ),*/
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

            /*----------------------Doctor List--------------------------*/
            //   Obx(() {
            //   if (doctorListCtr.loadingFetch.value) {
            //     return Center(heightFactor: 10,child: customView.MyIndicator());
            //   }
            //   return SingleChildScrollView(
            //     physics: const BouncingScrollPhysics(),
            //     child: doctorListCtr.doctorList.isEmpty
            //         ? const Center(
            //         heightFactor: 10,child: Text("Doctor Not Available at the Moment"))
            //         : ListView.builder(
            //             physics: const NeverScrollableScrollPhysics(),
            //             shrinkWrap: true,
            //             itemCount: list.length,
            //             itemBuilder: (context, index) {
            //               return GestureDetector(
            //                 onTap: () {
            //                    var id = {
            //               "data": doctorListCtr.doctorList[index].doctorId
            //             };
            //                   Navigator.push(
            //                       context,
            //                       MaterialPageRoute(
            //                           builder: (context) => DoctorDetailScreen(
            //                                 id: list[index].doctorId.toString(),
            //                               )));
            //                   // Get.toNamed(RouteHelper.getDoctorDetailScreen(id),);
            //                 },
            //                 child: Card(
            //                   color: MyColor.midgray,
            //                   elevation: 2,
            //                   child: Row(
            //                     children: [
            //                       SizedBox(
            //                         width: 100,
            //                         height: 100,
            //                         // margin: const EdgeInsets.all(6),
            //                         child:    FadeInImage.assetNetwork(
            //                             placeholder:"assets/images/YlWC.gif",
            //                             alignment: Alignment.center,
            //                             image: list[index].doctorProfile
            //                                 .toString(),
            //                             fit: BoxFit.fitWidth,
            //                             width: double.infinity,
            //                             imageErrorBuilder: (context, error, stackTrace) {
            //                               return Image.asset(
            //                                 'assets/images/MEDICAlogo.png',
            //                                 fit: BoxFit.cover,
            //                               );
            //                             }), /*Image.network(
            //                           list[index].doctorProfile
            //                               .toString(),
            //                           fit: BoxFit.cover,
            //                           errorBuilder: (context, error, stackTrace) {
            //                             return Container(
            //                               color: Colors.amber,
            //                               alignment: Alignment.center,
            //                               child: const Text(
            //                                 'Whoops!',
            //                                 style: TextStyle(fontSize: 30),
            //                               ),
            //                             );
            //                           },
            //                         ),*/
            //                       ),
            //                       const SizedBox(
            //                         width: 5,
            //                       ),
            //                       Column(
            //                         crossAxisAlignment: CrossAxisAlignment.start,
            //                         children: [
            //                           customView.text(
            //                               list[index].name
            //                                   .toString(),
            //                               13,
            //                               FontWeight.w600,
            //                               MyColor.black),
            //                           const SizedBox(
            //                             height: 3,
            //                           ),
            //                           Row(
            //                             children: [
            //                               const Icon(Icons.location_on_outlined,
            //                                   size: 18),
            //                               SizedBox(
            //                                 width: 150,
            //                                 child: customView.text(
            //                                     list[index].location
            //                                         .toString(),
            //                                     12,
            //                                     FontWeight.normal,
            //                                     MyColor.grey),
            //                               ),
            //                             ],
            //                           ),
            //                           const SizedBox(
            //                             height: 2,
            //                           ),
            //                           Row(
            //                             children: [
            //                               const Icon(Icons.monetization_on,
            //                                   size: 18),
            //                               customView.text(
            //                                   list[index].code
            //                                       .toString(),
            //                                   12,
            //                                   FontWeight.normal,
            //                                   MyColor.grey),
            //                             ],
            //                           ),
            //                           SizedBox(
            //                               width: widht * 0.50,
            //                               child: customView.text(
            //                                   list[index].category
            //                                       .toString(),
            //                                   12,
            //                                   FontWeight.w500,
            //                                   MyColor.black)),
            //                         ],
            //                       )
            //                     ],
            //                   ),
            //                 ),
            //               );
            //             },
            //           ),
            //   );
            // }),
          ],
        );
      }),
    );
  }

  Future shortBy() {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25.0,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: customView.text(
                      "Sort by:", 19, FontWeight.w600, MyColor.black),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print("tap");
                      },
                      child: customView.text(
                          "Relevance", 17, FontWeight.normal, MyColor.black),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child:
                          Icon(Icons.check_outlined, color: MyColor.lightblue),
                    )
                  ],
                ),
                const Divider(thickness: 1.5, height: 34),
                GestureDetector(
                  onTap: () {},
                  child: customView.text(
                      "Rating", 15, FontWeight.normal, MyColor.black),
                ),
                const Divider(thickness: 1.5, height: 34),
                GestureDetector(
                  onTap: () {},
                  child: customView.text(
                      "Distance", 15, FontWeight.normal, MyColor.black),
                ),
                const Divider(thickness: 1.5, height: 34),
                GestureDetector(
                  onTap: () {},
                  child: customView.text(
                      "Name: A-Z", 15, FontWeight.normal, MyColor.black),
                ),
                const Divider(thickness: 1.5, height: 34),
                GestureDetector(
                  onTap: () {},
                  child: customView.text(
                      "Name: Z-A", 15, FontWeight.normal, MyColor.black),
                ),
                const SizedBox(
                  height: 5,
                )
              ],
            ),
          ),
        );
      },
    );
  }
  void getValuee()async{
    id = await  sp.getStringValue(sp.PATIENT_ID_KEY);
    deviceTyp = await sp.getStringValue(sp.CURRENT_DEVICE_KEY);
    deviceId = await sp.getStringValue(sp.FIREBASE_TOKEN_KEY);
    // userTyp = await sp.getStringValue(sp.CURRENT_DEVICE_KEY);

    loginCtr.updateToken(context, id!, "User", deviceId!, deviceTyp!);
  }
}
// context, id!, "User", deviceId!, deviceTyp!
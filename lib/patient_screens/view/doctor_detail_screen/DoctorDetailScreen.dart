import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../helper/CustomView/CustomView.dart';
import '../../../helper/mycolor/mycolor.dart';
import '../../../language_translator/LanguageTranslate.dart';
import '../../controller/appointment_controller/AppointmentController.dart';
import '../../controller/doctor_list_ctr/DoctorListController.dart';
import '../../controller/doctor_list_ctr/PDoctorSpecializationCtr.dart';
import '../../controller/rating_controller/PatinetRatingController.dart';
import '../book_appointment/AppointmentCalender.dart';

class DoctorDetailScreen extends StatefulWidget {
  final String id, centerId,drImg,cat,subCat;

  const DoctorDetailScreen({Key? key, required this.id, required this.centerId, required this.drImg, required this.cat, required this.subCat})
      : super(key: key);

  @override
  State<DoctorDetailScreen> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  DoctorListCtr doctorListCtr = Get.put(DoctorListCtr());
  PatientRatingCtr patientRatingCtr = Get.put(PatientRatingCtr());
  LocalString text = LocalString();
  AppointmentController appointmentController =
      Get.put(AppointmentController());
  DoctorSpecializationCtr doctorSpecializationCtr =
      Get.put(DoctorSpecializationCtr());
  CustomView custom = CustomView();
  String doctorId = '';
  String CenterId = '';

  String img = "";
  String address = "";
  String fee = "";
  String cat = "";
  String doc = "";
  String latitude = "";
  String longitude = "";
  String branchId = "";

  @override
  void initState() {
    super.initState();
    doctorId = widget.id.toString();
    CenterId = widget.centerId.toString();
    log("doctor my  id$doctorId");
    log("center id ${widget.centerId} ==$CenterId");
    appointmentController.dateCalender(doctorId,branchId);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
      patientRatingCtr.fetchRating(doctorId);
      doctorListCtr.doctorDetialsfetch(doctorId);
      doctorSpecializationCtr.specializationFetch(doctorId);
    // });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Obx(() {
      if(doctorListCtr.resultVar.value == 1){
        doctorListCtr.resultVar.value = 0;

        img = doctorListCtr.image.value.toString();
        doc = doctorListCtr.doc.value.toString();
        log("doctor =img${doctorListCtr.image.value.toString()}");
        log("doctor =doc${doctorListCtr.doc.value.toString()}");
        latitude = doctorListCtr.latitude.value.toString();
        longitude = doctorListCtr.longitude.value.toString();
        branchId = doctorListCtr.branchId.value.toString();
        log("branchId my  id$branchId");
        address = doctorListCtr.address.value;
      }
      return Scaffold(
        body: doctorListCtr.loadingFetchD.value
            ? Center(heightFactor: 16, child: custom.MyIndicator())
            : CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: MyColor.midgray,
              elevation: 0.0,
              expandedHeight: 350.0,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(

                background: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/runlogo.png',
                    alignment: Alignment.center,
                    image: widget.drImg,
                     fit: BoxFit.fitWidth,

                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/noimage.png',
                        fit: BoxFit.cover,
                      );
                    }),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (_, int index) {
                  return  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment:  CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * 0.010,
                        ),
                       Padding(
                         padding: const EdgeInsets.all(5.0),
                         child: custom.text(
                                "${doctorListCtr.doctorname.value.toUpperCase()} ${doctorListCtr.drSurname.value.toString()}",
                                18,
                                FontWeight.w500,
                                MyColor.primary1),
                       ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.location_on_outlined,
                                size: 20, color: MyColor.primary1),
                            SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    0.80,
                                child: custom.text(
                                    doctorListCtr.address.value,
                                    11,
                                    FontWeight.normal,
                                    MyColor.grey)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: custom.text(
                              "BRANCH : ${doctorListCtr.branchName.value.toUpperCase()}",
                              13,
                              FontWeight.normal,
                              MyColor.grey),
                        ),
                        doctorListCtr.serviceStatus =="Free"?   Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              Icon(Icons.local_hospital,color: Colors.red,),
                              custom.text(
                                  "FIRST CONSULTANT FREE",
                                  14,
                                  FontWeight.normal,
                                  Colors.green),
                            ],
                          ),
                        ):SizedBox(),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  var latlong = {
                                    "lat": doctorListCtr.latitude.value,
                                    "long": doctorListCtr.longitude.value,
                                    "name":doctorListCtr.doctorname.value,
                                    "surname":doctorListCtr.drSurname.value,
                                    "address":address,
                                    "img":img,
                                    "doctorId":doctorListCtr.doctorid.value,
                                  };
                                  print(latlong);
                                  Get.toNamed(
                                      RouteHelper.getNavigateDoctor(),
                                      parameters: latlong);
                                },
                                child: Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: MyColor.primary,
                                          width: 2),
                                      borderRadius:
                                      BorderRadius.circular(30)),
                                  child: const Center(
                                    child: Icon(Icons.navigation_outlined,
                                        color: MyColor.primary),
                                  ),
                                ),
                              ),
                              custom.mysButton(context, text.bookAppointment.tr,
                                      () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => calender(
                                              branchId:branchId,
                                              firstConslt: doctorListCtr.serviceStatus.toString(), cat: widget.cat, subCat: widget.subCat,
                                            )));
                                  },
                                  MyColor.primary,
                                  const TextStyle(
                                      fontSize: 14,
                                      color: MyColor.white,
                                      fontFamily: "Poppins")),
                            ],
                          ),
                        ),
                         const Divider(color: Colors.grey),
                        custom.text(text.information.tr, 15,
                            FontWeight.w500, MyColor.black),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                var data = {
                                  "doctorid": doctorId,
                                };
                                Get.toNamed(RouteHelper.getReviewsScreen(),
                                    arguments: data);
                              },
                              child: Wrap(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    size: 20.0,
                                    color: Colors.orange,
                                  ),
                                  custom.text(
                                      patientRatingCtr
                                          .address.value.aveRating
                                          .toString(),
                                      15.0,
                                      FontWeight.w500,
                                      MyColor.primary1),
                                ],
                              ),
                            ),
                            doctorListCtr.fee.value == ""
                                ? Padding(
                              padding:
                              const EdgeInsets.only(right: 25.0),
                              child: custom.text("0", 15,
                                  FontWeight.w500, MyColor.primary1),
                            )
                                : Padding(
                              padding:
                              const EdgeInsets.only(right: 25.0),
                              child: custom.text(
                                  doctorListCtr.fee.value,
                                  15,
                                  FontWeight.w500,
                                  MyColor.primary1),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                var data = {
                                  "doctorid": doctorId,
                                };
                                Get.toNamed(RouteHelper.getReviewsScreen(),
                                    arguments: data);
                              },
                              child: custom.text(
                                  "${patientRatingCtr.address.value.totalReview.toString()} ${text.reviews.tr}",
                                  13,
                                  FontWeight.normal,
                                  MyColor.grey),
                            ),
                            custom.text(text.mediumPrice.tr, 14,
                                FontWeight.normal, MyColor.grey),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: custom.text(
                              "About",
                              13,
                              FontWeight.normal,
                              MyColor.grey),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0,top: 4),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: custom.text(
                                doctorListCtr.biography.value,
                                12,
                                FontWeight.normal,
                                MyColor.primary1),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),

                        GestureDetector(
                          onTap: () {
                            Get.toNamed(
                                RouteHelper.getViewCertificateScreen());
                          },
                          child: Container(
                              height: 45.0,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 2.0),
                              decoration: BoxDecoration(
                                color: MyColor.primary,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 13.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    custom.text(text.viewCertificate.tr, 15.0,
                                        FontWeight.w500, MyColor.white),
                                    const Icon(
                                      Icons.arrow_forward,
                                      size: 20.0,
                                      color:MyColor.white,
                                    ),
                                  ],
                                ),
                              )),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        custom.text(text.specializations.tr, 15,
                            FontWeight.w500, MyColor.primary1),
                        doctorSpecializationCtr.category.isEmpty
                            ?  SizedBox(
                            height: 50,
                            child: Center(
                                child: Text(
                                  text.noSpecializationAddedDoctor.tr,
                                  style: const TextStyle(
                                      color: MyColor.primary1,
                                      fontSize: 12),
                                )))
                            : ListView.builder(
                          physics:
                          const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                          doctorSpecializationCtr.category.length,
                          itemBuilder: (context, index) {
                            var list = doctorSpecializationCtr
                                .category[index];
                            return GestureDetector(
                              onTap: () {
                                var categoryId = list.categoryId;
                                var data = {
                                  "doctorId": doctorId,
                                  "catId": categoryId,
                                };
                                Get.toNamed(
                                    RouteHelper
                                        .getSpecializationDetailsScreen(),
                                    arguments: data);
                              },
                              child: Container(
                                  height: 45.0,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 7.0,
                                      vertical: 5.0),
                                  decoration: BoxDecoration(
                                    color: MyColor.primary,
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 13.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        custom.text(
                                            list.categoryName,
                                            14.0,
                                            FontWeight.w500,
                                            MyColor.white),
                                        const Icon(
                                          Icons.arrow_forward,
                                          size: 20.0,
                                          color: MyColor.white,
                                        ),
                                      ],
                                    ),
                                  )),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
                 childCount: 1,
              ),
            ),
          ],
         ),
      );
    });
  }
}

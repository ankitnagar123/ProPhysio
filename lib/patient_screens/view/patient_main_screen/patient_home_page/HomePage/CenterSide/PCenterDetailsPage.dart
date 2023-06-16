import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:medica/helper/mycolor/mycolor.dart';
import 'package:medica/medica_center/center_controller/CenterAuthController.dart';

import '../../../../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../../../../medica_center/center_controller/CenterHomeController.dart';


class PCenterDetailScreen extends StatefulWidget {
  final String id;

  const PCenterDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<PCenterDetailScreen> createState() => _PCenterDetailScreenState();
}

class _PCenterDetailScreenState extends State<PCenterDetailScreen> {

 /* DoctorListCtr doctorListCtr = Get.put(DoctorListCtr());
  PatientRatingCtr patientRatingCtr = Get.put(PatientRatingCtr());
  AppointmentController appointmentController = Get.put(AppointmentController());
  DoctorSpecializationCtr doctorSpecializationCtr = Get.put(DoctorSpecializationCtr());*/
  CustomView custom = CustomView();
  CenterAuthCtr centerAuthCtr = CenterAuthCtr();
  CenterHomeCtr centerHomeCtr = CenterHomeCtr();
  String centerId = '';

  String img = "";
  String address = "";
  String fee = "";
  String cat = "";
  String doc = "";
  String latitude = "";
  String longitude = "";
  String wardId = "";
  String wardName = "";
  @override
  void initState() {
    centerId = widget.id.toString();
    print("doctor my  id$centerId");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      centerHomeCtr.centerWardListPatient(context,centerId);
centerAuthCtr.centerDetails(context, centerId.toString());
   /*   patientRatingCtr.fetchRating(doctorId);
      doctorListCtr.doctorDetialsfetch(doctorId);
      appointmentController.dateCalender(doctorId);
      doctorSpecializationCtr.specializationFetch(doctorId);*/
    });

   /* img = doctorListCtr.image.value.toString();
    doc = doctorListCtr.doc.value.toString();
    print("doctor =img${doctorListCtr.image.value.toString()}");
    print("doctor =doc${doctorListCtr.doc.value.toString()}");
    latitude = doctorListCtr.latitude.value.toString();
    longitude = doctorListCtr.longitude.value.toString();
    address = doctorListCtr.address.value;*/
    // fee = doctorListCtr.fee.value;
    // cat = doctorListCtr.category.value;

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return Obx(() {
      return Scaffold(
        body:  centerAuthCtr.loadingDetails.value?Center(heightFactor: 16, child: custom.MyIndicator()):NestedScrollView(
          floatHeaderSlivers: false,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              leading: InkWell(
                  onTap: () {
                    Get.back();
                  },child: const Icon(Icons.arrow_back_ios,color: MyColor.black)),
              backgroundColor: MyColor.midgray,
              elevation: 0.0,
              expandedHeight: 320.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: custom.text(
                    centerAuthCtr.name.value,
                    15,
                    FontWeight.w500,
                    MyColor.primary1),
                background: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/loading.gif',
                    alignment: Alignment.center,
                    image: centerAuthCtr.image.value,
                    fit: BoxFit.fitWidth,
                    width: double.infinity,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/noimage.png',
                        fit: BoxFit.cover,
                      );
                    }),
              ),
            )
          ],
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Stack(
                //   children: [
                //     FadeInImage.assetNetwork(
                //         placeholder: 'assets/images/loading.gif',
                //         alignment: Alignment.center,
                //         image: doctorListCtr.image.value,
                //         fit: BoxFit.fitWidth,
                //         width: double.infinity,
                //         imageErrorBuilder: (context, error, stackTrace) {
                //           return Image.asset(
                //             'assets/images/MEDICAlogo.png',
                //             fit: BoxFit.cover,
                //           );
                //         }),
                //     Positioned(
                //         top: 40.0,
                //         left: 30,
                //         child: InkWell(
                //             onTap: () {
                //               Get.back();
                //             },
                //             child: const Icon(
                //               Icons.arrow_back_ios,
                //               color: MyColor.black,
                //             )))
                //   ],
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.015,
                      ),
                      custom.text(cat, 16, FontWeight.w500, MyColor.black),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.home,
                            size: 18,
                            color: MyColor.grey,
                          ),
                          custom.text(
                              "Private", 12, FontWeight.normal, MyColor.grey),
                          SizedBox(
                            width: widht * 0.03,
                          ),
                          const Icon(Icons.location_on_outlined,
                              size: 18, color: MyColor.grey),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.66,
                              child: custom.text(centerAuthCtr.location.value,
                                  12, FontWeight.normal, MyColor.grey)),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                   /*   Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            spacing: 10.0,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  var latlong = {
                                    "lat":latitude,
                                    "long":longitude,
                                  };
                                  print(latlong);
                                  // Get.toNamed(RouteHelper.getNavigateDoctor(),parameters: latlong);
                                },
                                child: Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: MyColor.primary, width: 2),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: const Center(
                                    child: Icon(Icons.navigation_outlined,
                                        color: MyColor.primary),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // var data = {"doctorId": doctorId};
                                 *//* Get.toNamed(RouteHelper.getChatScreen(),
                                      arguments: data);*//*
                                },
                                child: Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: MyColor.primary, width: 2),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: const Center(
                                    child: Icon(Icons.chat_bubble_outline,
                                        color: MyColor.primary),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      *//*    custom.mysButton(context, "Book Appointment", () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  calender(centerId: centerId,)));
                          },
                              MyColor.primary,
                              const TextStyle(
                                  fontSize: 14,
                                  color: MyColor.white,
                                  fontFamily: "Poppins")),*//*
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),*/
                      const Divider(),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: custom.text(
                            "Information", 15, FontWeight.w500, MyColor.black),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Icon(
                            Icons.home,
                            size: 20.0,
                            color: MyColor.primary1,
                          ),
                          InkWell(
                            onTap: () {
                         /*     var data = {
                                "doctorid": doctorId,
                              };
                              Get.toNamed(RouteHelper.getReviewsScreen(),
                                  arguments: data);*/
                            },
                            child: Wrap(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 20.0,
                                  color: MyColor.primary1,
                                ),
                                custom.text("2.2"
                                    /*patientRatingCtr.address.value.aveRating*/
                                        .toString(),
                                    15.0,
                                    FontWeight.w500,
                                    MyColor.primary1),
                              ],
                            ),
                          ),
                         /* doctorListCtr.fee.value == ""
                              ? Padding(
                            padding: const EdgeInsets.only(right: 28.0),
                            child: custom.text("0", 15, FontWeight.w500,
                                MyColor.primary1),
                          )
                              : Padding(
                            padding: const EdgeInsets.only(right: 25.0),
                            child: custom.text(doctorListCtr.fee.value,
                                15, FontWeight.w500, MyColor.primary1),
                          ),*/
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          custom.text(
                              "2 place", 13, FontWeight.normal, MyColor.grey),
                         /* custom.text(
                              "${patientRatingCtr.address.value.totalReview.toString()} reviews",
                              13,
                              FontWeight.normal,
                              MyColor.grey),*/
                          custom.text("Medium price", 14, FontWeight.normal,
                              MyColor.grey),
                        ],
                      ),
                     /* Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: custom.text(doctorListCtr.biography.value, 11,
                              FontWeight.normal, MyColor.grey),
                        ),
                      ),*/
                      SizedBox(
                        height: height * 0.03,
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => const PatinetOfficeAddress()));
                      //     // Get.toNamed(RouteHelper.getViewCertificateScreen());
                      //   },
                      //   child: Container(
                      //       height: 50.0,
                      //       margin: const EdgeInsets.symmetric(
                      //           horizontal: 10.0, vertical: 2.0),
                      //       decoration: BoxDecoration(
                      //         color: MyColor.lightcolor,
                      //         borderRadius: BorderRadius.circular(10.0),
                      //       ),
                      //       child: Padding(
                      //         padding:
                      //         const EdgeInsets.symmetric(horizontal: 13.0),
                      //         child: Row(
                      //           mainAxisAlignment:
                      //           MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             custom.text("Offices address", 14.0,
                      //                 FontWeight.w500, MyColor.primary1),
                      //             const Icon(
                      //               Icons.arrow_forward,
                      //               size: 20.0,
                      //               color: MyColor.primary1,
                      //             ),
                      //           ],
                      //         ),
                      //       )),
                      // ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: custom.text("Center ward", 15,
                            FontWeight.w500, MyColor.primary1),
                      ),
                      centerHomeCtr.loadingFetchW.value?custom.MyIndicator():centerHomeCtr.selectedWardList.isEmpty?
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: custom.text("No ward added by center", 14,
                            FontWeight.w400, MyColor.black),
                      ): ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: centerHomeCtr.selectedWardList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Card(
                            color: MyColor.midgray,
                            child: ListTile(
                              onTap: () {
                                wardId = centerHomeCtr.selectedWardList[index].wardId;
                                wardName = centerHomeCtr.selectedWardList[index].wardName;

                                var data ={
                                  "wardId":wardId,
                                  "wardName":wardName,
                                  "centerId":centerId
                                };
                                Get.toNamed(RouteHelper.getCenterWardDrList(),parameters: data);
                                // Get.toNamed(RouteHelper.getPatientSettingsScreen());
                              },
                              title: custom.text(
                                  centerHomeCtr.selectedWardList[index].wardName, 14.0,
                                  FontWeight.w500, Colors.black),
                              subtitle: Row(
                                children: [
                                  const Icon(Icons.person_outline_outlined,
                                      size: 17, color: Colors.black),
                                  const SizedBox(
                                    width: 4.0,
                                  ),
                                  custom.text(
                                      "${centerHomeCtr.selectedWardList[index].totalDoctor} doctors", 11.0, FontWeight.normal, Colors.black),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

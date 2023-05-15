import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:medica/helper/mycolor/mycolor.dart';

import '../../../Helper/RoutHelper/RoutHelper.dart';
import '../../controller/appointment_controller/AppointmentController.dart';
import '../../controller/doctor_list_ctr/DoctorListController.dart';
import '../../controller/doctor_list_ctr/PDoctorSpecializationCtr.dart';
import '../../controller/rating_controller/PatinetRatingController.dart';
import '../book_appointment/AppointmentCalender.dart';
import 'PatinetOfficeAddress.dart';

class DoctorDetailScreen extends StatefulWidget {
  final String id;

  const DoctorDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<DoctorDetailScreen> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {

  DoctorListCtr doctorListCtr = Get.put(DoctorListCtr());
  PatientRatingCtr patientRatingCtr = Get.put(PatientRatingCtr());
  AppointmentController appointmentController = Get.put(AppointmentController());
  DoctorSpecializationCtr doctorSpecializationCtr = Get.put(DoctorSpecializationCtr());
  CustomView custom = CustomView();
  String doctorId = '';

  String img = "";
  String address = "";
  String fee = "";
  String cat = "";
  String doc = "";
String latitude = "";
String longitude = "";
  @override
  void initState() {
    doctorId = widget.id.toString();
    print("doctor my  id$doctorId");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      patientRatingCtr.fetchRating(doctorId);
      doctorListCtr.doctorDetialsfetch(doctorId);
      appointmentController.dateCalender(doctorId);
      doctorSpecializationCtr.specializationFetch(doctorId);
    });

    img = doctorListCtr.image.value.toString();
    doc = doctorListCtr.doc.value.toString();
    print("doctor =img${doctorListCtr.image.value.toString()}");
    print("doctor =doc${doctorListCtr.doc.value.toString()}");
latitude = doctorListCtr.latitude.value.toString();
longitude = doctorListCtr.longitude.value.toString();
    address = doctorListCtr.address.value;
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
        body:  doctorListCtr.loadingFetchD.value?Center(heightFactor: 16, child: custom.MyIndicator()):NestedScrollView(
floatHeaderSlivers: false,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              backgroundColor: MyColor.midgray,
              elevation: 0.0,
              expandedHeight: 320.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: custom.text(
                    "${doctorListCtr.doctorname.value} ${doctorListCtr.drSurname.value}",
                    15,
                    FontWeight.w500,
                    MyColor.primary1),
                background: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/loading.gif',
                    alignment: Alignment.center,
                    image: doctorListCtr.image.value,
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
            child: Container(
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
                                child: custom.text(doctorListCtr.address.value,
                                    12, FontWeight.normal, MyColor.grey)),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
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
                                    Get.toNamed(RouteHelper.getNavigateDoctor(),parameters: latlong);
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
                                    var data = {"doctorId": doctorId};
                                    Get.toNamed(RouteHelper.getChatScreen(),
                                        arguments: data);
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
                            custom.mysButton(context, "Book Appointment", () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const calender()));
                            },
                                MyColor.primary,
                                const TextStyle(
                                    fontSize: 14,
                                    color: MyColor.white,
                                    fontFamily: "Poppins")),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
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
                                    color: MyColor.primary1,
                                  ),
                                  custom.text(
                                      patientRatingCtr.address.value.aveRating
                                          .toString(),
                                      15.0,
                                      FontWeight.w500,
                                      MyColor.primary1),
                                ],
                              ),
                            ),
                            doctorListCtr.fee.value == ""
                                ? Padding(
                                    padding: const EdgeInsets.only(right: 28.0),
                                    child: custom.text("0", 15, FontWeight.w500,
                                        MyColor.primary1),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(right: 25.0),
                                    child: custom.text(doctorListCtr.fee.value,
                                        15, FontWeight.w500, MyColor.primary1),
                                  ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            custom.text(
                                "2 place", 13, FontWeight.normal, MyColor.grey),
                            custom.text(
                                "${patientRatingCtr.address.value.totalReview.toString()} reviews",
                                13,
                                FontWeight.normal,
                                MyColor.grey),
                            custom.text("Medium price", 14, FontWeight.normal,
                                MyColor.grey),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: custom.text(doctorListCtr.biography.value, 11,
                                FontWeight.normal, MyColor.grey),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getViewCertificateScreen());
                          },
                          child: Container(
                              height: 50.0,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 2.0),
                              decoration: BoxDecoration(
                                color: MyColor.lightcolor,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 13.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    custom.text("View certificate", 14.0,
                                        FontWeight.w500, MyColor.primary1),
                                    const Icon(
                                      Icons.arrow_forward,
                                      size: 20.0,
                                      color: MyColor.primary1,
                                    ),
                                  ],
                                ),
                              )),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PatinetOfficeAddress()));
                            // Get.toNamed(RouteHelper.getViewCertificateScreen());
                          },
                          child: Container(
                              height: 50.0,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 2.0),
                              decoration: BoxDecoration(
                                color: MyColor.lightcolor,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 13.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    custom.text("Offices address", 14.0,
                                        FontWeight.w500, MyColor.primary1),
                                    const Icon(
                                      Icons.arrow_forward,
                                      size: 20.0,
                                      color: MyColor.primary1,
                                    ),
                                  ],
                                ),
                              )),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: custom.text("Specializations", 15,
                              FontWeight.w500, MyColor.primary1),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        doctorSpecializationCtr.category.isEmpty
                            ? const SizedBox(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  "No  Specialization Added by Doctor",
                                  style: TextStyle(
                                      color: MyColor.primary1, fontSize: 12),
                                )))
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    doctorSpecializationCtr.category.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      var categoryId = doctorSpecializationCtr
                                          .category[index].categoryId;
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
                                        height: 50.0,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 5.0),
                                        decoration: BoxDecoration(
                                          color: MyColor.lightcolor,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 13.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              custom.text(
                                                  doctorSpecializationCtr
                                                      .category[index]
                                                      .categoryName,
                                                  14.0,
                                                  FontWeight.w500,
                                                  MyColor.primary1),
                                              const Icon(
                                                Icons.arrow_forward,
                                                size: 20.0,
                                                color: MyColor.primary1,
                                              ),
                                            ],
                                          ),
                                        )),
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
        ),
      );
    });
  }
}

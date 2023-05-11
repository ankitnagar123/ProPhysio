import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/doctor_screens/controller/DoctorProfileController.dart';
import 'package:medica/doctor_screens/view/doctor_main_page/doctor_more_page/doctor_availability/DoctorAddAvailability.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:medica/helper/mycolor/mycolor.dart';
import 'package:medica/helper/sharedpreference/SharedPrefrenc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Helper/RoutHelper/RoutHelper.dart';
import 'add_prescriptiona&medicalTest/Past_Appointment_Prescription.dart';

class DoctorMorePage extends StatefulWidget {
  const DoctorMorePage({Key? key}) : super(key: key);

  @override
  State<DoctorMorePage> createState() => _DoctorMorePageState();
}

class _DoctorMorePageState extends State<DoctorMorePage> {
  DoctorProfileCtr doctorProfileCtr = Get.put(DoctorProfileCtr());
  CustomView customView = CustomView();
  SharedPreferenceProvider sp = SharedPreferenceProvider();

  @override
  void initState() {
    doctorProfileCtr.doctorProfile(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                customView.text("Hi @${doctorProfileCtr.name.value}", 17.0,
                    FontWeight.w500, Colors.black),
                const SizedBox(
                  height: 30.0,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(RouteHelper.DPersonalData());
                        },
                        child: Container(
                          height: MediaQuery
                              .of(context)
                              .size
                              .shortestSide / 3.2,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [MyColor.primary, MyColor.secondary],
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .shortestSide / 8,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: MyColor.midgray,
                                  borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(10.0),
                                  ),
                                ),
                                child: Center(
                                    child: customView.text("Profile settings",
                                        12.0, FontWeight.w400, Colors.black)),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 7.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(RouteHelper.DEarningCalculate());
                          // Get.toNamed(RouteHelper.getPatientPaymentScreen());
                        },
                        child: Container(
                          height: MediaQuery
                              .of(context)
                              .size
                              .shortestSide / 3.2,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [MyColor.primary, MyColor.secondary],
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .shortestSide / 8,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: MyColor.midgray,
                                  borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(10.0),
                                  ),
                                ),
                                child: Center(
                                    child: customView.text("Earnings", 12.0,
                                        FontWeight.w400, Colors.black)),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 30.0,
                ),
                ListTile(
                  onTap: () {
                    Get.toNamed(RouteHelper.DSettingScreen());
                  },
                  leading: const Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                  title: customView.text(
                      "Settings", 14.0, FontWeight.w500, Colors.black),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 20.0,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyAvailability()));
                    // Get.toNamed(RouteHelper.DSettingScreen());
                  },
                  leading: const Icon(
                    Icons.event_available,
                    color: Colors.black,
                  ),
                  title: customView.text(
                      "Add Availability", 14.0, FontWeight.w500, Colors.black),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 20.0,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (
                                context) => const CompleteAppointPrescription()));
                    // Get.toNamed(RouteHelper.DSettingScreen());
                  },
                  leading: const Icon(
                    Icons.medical_information,
                    color: Colors.black,
                  ),
                  title: customView.text(
                      "Past Appointment Prescription", 13.0, FontWeight.w500,
                      Colors.black),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 20.0,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.toNamed(RouteHelper.DTandCScreen());
                  },
                  leading: const Icon(
                    Icons.note_alt,
                    color: Colors.black,
                  ),
                  title: customView.text(
                      "Terms & conditions", 14.0, FontWeight.w500,
                      Colors.black),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 20.0,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.toNamed(RouteHelper.DAboutScreen());
                  },
                  leading: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  title: customView.text(
                      "About", 14.0, FontWeight.w500, Colors.black),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 20.0,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.toNamed(RouteHelper.DSupportScreen());
                  },
                  leading: const Icon(
                    Icons.person_outline,
                    color: Colors.black,
                  ),
                  title: customView.text(
                      "Support", 14.0, FontWeight.w500, Colors.black),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 20.0,
                  ),
                ),
                const Divider(
                  height: 30.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      deletePopUp(context);
                    },
                    child: customView.text(
                        "Logout", 15.0, FontWeight.w500, Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  void deletePopUp(BuildContext context) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
        MaterialLocalizations
            .of(context)
            .modalBarrierDismissLabel,
        barrierColor: Colors.black54,
        pageBuilder: (context, anim1, anim2) {
          return Center(
            child: SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 1,
              child: StatefulBuilder(
                builder: (context, StateSetter setState) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 5.0),
                            child: customView.text(
                                "Logout", 17, FontWeight.w500, Colors.black),
                          ),
                          const SizedBox(
                            height: 14.0,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 5.0),
                            child: customView.text(
                                "Are you sure you want to log out?",
                                13,
                                FontWeight.w400,
                                Colors.black),
                          ),
                          const SizedBox(
                            height: 13.0,
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: customView.text("Dismiss", 14.0,
                                        FontWeight.w500, MyColor.grey),
                                  )),
                              Expanded(
                                child: customView.mysButton(
                                  context,
                                  "Logout",
                                      () async {
                                    SharedPreferences preferences = await SharedPreferences
                                        .getInstance();
                                    preferences.remove("DOCTOR_LOGIN_KEY");
                                    print(
                                        preferences.remove("DOCTOR_LOGIN_KEY"));
                                    sp.setBoolValue(sp.ON_BOARDING_KEY, true);

                                    Get.offAllNamed(
                                        RouteHelper.getLoginScreen());
                                  },
                                  Colors.red,
                                  const TextStyle(
                                    color: MyColor.white,
                                  ),
                                ),
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
          );
        });
  }
}

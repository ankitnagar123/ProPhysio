import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../../ZegoCallService/ZegoCallService.dart';
import '../../../../helper/CustomView/CustomView.dart';
import '../../../../helper/mycolor/mycolor.dart';
import '../../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../../../language_translator/LanguageTranslate.dart';
import '../../../controller/CenterRequestCtr.dart';
import '../../../controller/DoctorProfileController.dart';
import 'LerningManagement/learningManage.dart';
import 'add_prescriptiona&medicalTest/Past_Appointment_Prescription.dart';
import 'doctor_availability/doctorViewAvailability/DoctorViewCalenderSlot.dart';

class DoctorMorePage extends StatefulWidget {
  const DoctorMorePage({super.key});

  @override
  State<DoctorMorePage> createState() => _DoctorMorePageState();
}

class _DoctorMorePageState extends State<DoctorMorePage> {
  DoctorProfileCtr doctorProfileCtr = Get.put(DoctorProfileCtr());
  CustomView customView = CustomView();
  LocalString text = LocalString();
  SharedPreferenceProvider sp = SharedPreferenceProvider();
  CenterRequest centerRequest = Get.put(CenterRequest());

  @override
  void initState() {
    doctorProfileCtr.doctorProfile(context);
    centerRequest.CenterRequestListApi(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage("assets/images/runlogo.png"),
                  height: 40,
                  width: 40,
                ),
              ),
              customView.text("${text.hii.tr} @${doctorProfileCtr.name.value}",
                  17.0, FontWeight.w500, Colors.black),
              const SizedBox(
                height: 20.0,
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(RouteHelper.DPersonalData());
                },
                child: Container(
                  height: MediaQuery.of(context).size.shortestSide / 3.2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [MyColor.primary, MyColor.primary1],
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 18.0),
                        child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius:  BorderRadius.circular(20),
                                border: Border.all(color: Colors.white)
                            ),
                            child: const Icon(Icons.person_outline_sharp,color: Colors.white)),
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height:
                                MediaQuery.of(context).size.shortestSide / 8,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: MyColor.midgray,
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(10.0),
                              ),
                            ),
                            child: Center(
                                child: customView.text(
                                    text.ProfileSettings.tr,
                                    12.0,
                                    FontWeight.w400,
                                    Colors.black)),
                          )),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 7.0,
              ),
              Divider(
                color: MyColor.grey.withOpacity(0.5),
                height: 30.0,
              ),
              ListTile(
                subtitle: customView.text(text.addAvailabilitySelfCenter.tr,
                    11.0, FontWeight.w400, Colors.black),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DoctorViewCalender(centerId: ""),));
                  // Get.toNamed(RouteHelper.DSettingScreen());
                },
                leading: const Icon(
                  Icons.event_available,
                  color: Colors.black,
                ),
                title: customView.text(text.addAvailability.tr, 14.0,
                    FontWeight.w500, Colors.black),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 20.0,
                ),
              ),
              ListTile(
                // subtitle: customView.text(text.LMS.tr,
                //     11.0, FontWeight.w400, Colors.black),
                onTap: () {
                  Get.toNamed(RouteHelper.DLearningManage());

                  // Get.toNamed(RouteHelper.DSettingScreen());
                },
                leading: const Icon(
                  Icons.check_box,
                  color: Colors.black,
                ),
                title: customView.text(text.LMS.tr, 14.0,
                    FontWeight.w500, Colors.black),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 20.0,
                ),
              ),
              /*----------------prescription----------------*/
              ListTile(
                subtitle: customView.text(text.prescriptionAndMedicalReports.tr,
                    11.0, FontWeight.w400, Colors.black),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const CompleteAppointPrescription()));
                  // Get.toNamed(RouteHelper.DSettingScreen());
                },
                leading: const Icon(
                  Icons.medical_information,
                  color: Colors.black,
                ),
                title: customView.text(
                    text.reports.tr, 13.0, FontWeight.w500, Colors.black),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 20.0,
                ),
              ),

              // ListTile(
              //   subtitle: customView.text(text.viewYourMedicalRequest.tr, 11.0,
              //       FontWeight.w400, Colors.black),
              //   onTap: () {
              //     Get.toNamed(RouteHelper.DCenterRequest());
              //   },
              //   leading: Badge(
              //     backgroundColor: centerRequest.centerRequestList.isEmpty?Colors.transparent:Colors.red,
              //     label:centerRequest.centerRequestList.isEmpty?const Text(""): Text("${centerRequest.centerRequestList.length}"),
              //     child: const Icon(
              //       Icons.medical_services_outlined,
              //       color: Colors.black,
              //     ),
              //   ),
              //   title: customView.text(
              //       text.centerRequest.tr, 14.0, FontWeight.w500, Colors.black),
              //   trailing: const Icon(
              //     Icons.arrow_forward_ios,
              //     color: Colors.black,
              //     size: 20.0,
              //   ),
              // ),

              ListTile(
                onTap: () {

                  Get.toNamed(RouteHelper.DMyTask());
                },
                leading: const Icon(
                  Icons.task_alt,
                  color: Colors.black,
                ),
                title: customView.text(
                    text.MYTASK.tr, 14.0, FontWeight.w500, Colors.black),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 20.0,
                ),
                subtitle: customView.text(
                    text.TASKVIEW.tr, 10.0, FontWeight.normal, Colors.black),
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
                    text.Settings.tr, 14.0, FontWeight.w500, Colors.black),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 20.0,
                ),
              ),

             /* ListTile(
                onTap: () {
                  Get.toNamed(RouteHelper.DTandCScreen());
                },
                leading: const Icon(
                  Icons.note_alt,
                  color: Colors.black,
                ),
                title: customView.text(
                    text.TermCondition.tr, 14.0, FontWeight.w500, Colors.black),
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
                    text.About.tr, 14.0, FontWeight.w500, Colors.black),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 20.0,
                ),
              ),*/
              // ListTile(
              //   onTap: () {
              //     Get.toNamed(RouteHelper.DSupportScreen());
              //   },
              //   leading: const Icon(
              //     Icons.person_outline,
              //     color: Colors.black,
              //   ),
              //   title: customView.text(
              //       text.Support.tr, 14.0, FontWeight.w500, Colors.black),
              //   trailing: const Icon(
              //     Icons.arrow_forward_ios,
              //     color: Colors.black,
              //     size: 20.0,
              //   ),
              // ),
              Divider(
                color: MyColor.grey.withOpacity(0.5),
                height: 20.0,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    deletePopUp(context);
                  },
                  child: customView.text(
                      text.Logout.tr, 15.0, FontWeight.w500, Colors.red),
                ),
              ),
            ],
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
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black54,
        pageBuilder: (context, anim1, anim2) {
          return Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1,
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
                            child: customView.text(text.Logout.tr, 17,
                                FontWeight.w500, Colors.black),
                          ),
                          const SizedBox(
                            height: 14.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: customView.text(text.AreyouSureExit.tr, 13,
                                FontWeight.w400, Colors.black),
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
                                    child: customView.text(text.Dismiss.tr,
                                        14.0, FontWeight.w500, MyColor.grey),
                                  )),
                              Expanded(
                                child: customView.mysButton(
                                  context,
                                  text.Logout.tr,
                                  () async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    preferences.remove("DOCTOR_LOGIN_KEY");
                                    preferences.remove("DOCTOR_ID_KEY");
                                    sp.clearSharedPreference();
                                    onUserLogout();
                                    log("${preferences.remove("DOCTOR_LOGIN_KEY")}");
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

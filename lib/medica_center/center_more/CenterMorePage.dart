import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Helper/RoutHelper/RoutHelper.dart';
import '../../helper/CustomView/CustomView.dart';
import '../../helper/mycolor/mycolor.dart';
import '../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../language_translator/LanguageTranslate.dart';
import '../center_controller/CenterAuthController.dart';

class CenterMorePage extends StatefulWidget {
  const CenterMorePage({Key? key}) : super(key: key);

  @override
  State<CenterMorePage> createState() => _CenterMorePageState();
}

class _CenterMorePageState extends State<CenterMorePage> {
  CustomView customView = CustomView();
  SharedPreferenceProvider sp = SharedPreferenceProvider();
  CenterAuthCtr centerAuthCtr = CenterAuthCtr();
  LocalString text = LocalString();
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    centerAuthCtr.centerProfile(context);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
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
              customView.text("${text.hii.tr} @ ${centerAuthCtr.name.value}", 17.0,
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
                        Get.toNamed(RouteHelper.CProfile());
                      },
                      child: Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .shortestSide / 3.2,
                        decoration: BoxDecoration(
                          gradient:  LinearGradient(
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
                                  child: customView.text(text.ProfileSettings.tr,
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
                        Get.toNamed(RouteHelper.cEarningCal());
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
                                  child: customView.text(text.Earnings.tr, 12.0,
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
                  Get.toNamed(RouteHelper.cSettings());
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
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const MyAvailability()));
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
                ),*/
              ListTile(
                onTap: () {
                  Get.toNamed(RouteHelper.DTandCScreen());
                },
                leading: const Icon(
                  Icons.note_alt,
                  color: Colors.black,
                ),
                title: customView.text(
                    text.TermCondition.tr, 14.0, FontWeight.w500,
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
                    text.About.tr, 14.0, FontWeight.w500, Colors.black),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 20.0,
                ),
              ),
              ListTile(
                onTap: () {
                  Get.toNamed(RouteHelper.cSupports());
                },
                leading: const Icon(
                  Icons.person_outline,
                  color: Colors.black,
                ),
                title: customView.text(
                    text.Support.tr, 14.0, FontWeight.w500, Colors.black),
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
                                text.Logout.tr, 17, FontWeight.w500, Colors.black),
                          ),
                          const SizedBox(
                            height: 14.0,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 5.0),
                            child: customView.text(
                               text.AreyouSureExit.tr,
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
                                    child: customView.text(text.Dismiss.tr, 14.0,
                                        FontWeight.w500, MyColor.grey),
                                  )),
                              Expanded(
                                child: customView.mysButton(
                                  context,
                                  text.Logout.tr,
                                      () async {
                                    SharedPreferences preferences = await SharedPreferences
                                        .getInstance();
                                     preferences.remove("CENTER_LOGIN_KEY");
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

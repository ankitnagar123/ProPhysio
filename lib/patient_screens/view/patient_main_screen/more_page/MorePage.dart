import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/Helper/RoutHelper/RoutHelper.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:medica/helper/mycolor/mycolor.dart';
import 'package:medica/helper/sharedpreference/SharedPrefrenc.dart';
import 'package:medica/patient_screens/view/patient_main_screen/more_page/term_condition_page/PatientTermCondition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controller/auth_controllers/PatientProfileController.dart';
import "../../../controller/auth_controllers/card_controller's/PatientCardController.dart";
import 'Ratings_and_reviews/Rating&ReviewPage.dart';
import 'about_page/PatinetAboutPage.dart';
import 'my_past_chekup/PatientPastChekups.dart';
import 'my_past_chekup/PatientQRCodeShow.dart';

class MorePage extends StatefulWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  PatientProfileCtr patientProfileCtr = Get.put(PatientProfileCtr());
  CardCtr cardCtr = Get.put(CardCtr());

  CustomView customView = CustomView();
  SharedPreferenceProvider sp = SharedPreferenceProvider();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      patientProfileCtr.patientProfile(context);
      cardCtr.cardFetch();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white24,
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*const SizedBox(
                  height: 5.0,
                ),*/
                customView.text("Hi @${patientProfileCtr.name.value}", 17.0,
                    FontWeight.w500, Colors.black),
                const SizedBox(
                  height: 15.0,
                ),
                cardCtr.cardList.isEmpty
                    ? Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: MyColor.primary),
                            color: MyColor.lightcolor,
                            borderRadius: BorderRadius.circular(15)),
                        child: ListTile(
                          onTap: () {
                            Get.toNamed(
                                RouteHelper.getPatientAddNewCardScreen());
                          },
                          title: customView.text("Add a credit card", 16,
                              FontWeight.w500, MyColor.primary1),
                          subtitle: const Row(
                            children: [
                              Text("Go to ",
                                  style: TextStyle(color: MyColor.primary1)),
                              Text("Payment ",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: MyColor.primary1,
                                      fontWeight: FontWeight.w500)),
                              Text("to complete it.",
                                  style: TextStyle(color: MyColor.primary1)),
                            ],
                          ),
                          trailing: const Icon(
                            Icons.lightbulb,
                            size: 25,
                            color: Colors.yellow,
                          ),
                        ),
                      )
                    : const SizedBox(height: 10),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(RouteHelper.getPatientProfileScreen());
                        },
                        child: Container(
                          height:
                              MediaQuery.of(context).size.shortestSide / 3.2,
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
                                    MediaQuery.of(context).size.shortestSide /
                                        8,
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
                          Get.toNamed(RouteHelper.getPatientPaymentScreen());
                        },
                        child: Container(
                          height:
                              MediaQuery.of(context).size.shortestSide / 3.2,
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
                                    MediaQuery.of(context).size.shortestSide /
                                        8,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: MyColor.midgray,
                                  borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(10.0),
                                  ),
                                ),
                                child: Center(
                                    child: customView.text("Payment", 12.0,
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
                  subtitle: customView.text("Rate those appointment u did",
                      10.0, FontWeight.w500, Colors.black),
                  visualDensity: VisualDensity.compact,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const PastAppointmentsRating()));
                    // Get.toNamed(RouteHelper.getPatientSupportScreen());
                  },
                  leading: const Icon(
                    Icons.star_border_purple500_sharp,
                    color: Colors.black,
                  ),
                  title: customView.text("Ratings and reviews", 14.0,
                      FontWeight.w500, Colors.black),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 20.0,
                  ),
                ),
                ListTile(
                  visualDensity: VisualDensity.compact,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const PPrescriptionMedicalTab()));
                    // Get.toNamed(RouteHelper.getPatientSupportScreen());
                  },
                  leading: const Icon(
                    Icons.content_paste_search_sharp,
                    color: Colors.black,
                  ),
                  title: customView.text(
                      "Reports", 14.0, FontWeight.w500, Colors.black),
                  subtitle: customView.text(
                      "View your prescription,medical test & medicines",
                      10.0,
                      FontWeight.w500,
                      Colors.black),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 20.0,
                  ),
                ),
                ListTile(
                  visualDensity: VisualDensity.compact,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PatientQRShow()));
                  },
                  leading: const Icon(
                    Icons.qr_code_scanner_sharp,
                    color: Colors.black,
                  ),
                  title: customView.text(
                      "OR code", 14.0, FontWeight.w500, Colors.black),
                  subtitle: customView.text(
                      "View your QR code", 10.0, FontWeight.w500, Colors.black),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 20.0,
                  ),
                ),
                ListTile(
                  visualDensity: VisualDensity.compact,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const PatientTermCondition()));
                  },
                  leading: const Icon(
                    Icons.note_alt,
                    color: Colors.black,
                  ),
                  title: customView.text("Terms & conditions", 14.0,
                      FontWeight.w500, Colors.black),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 20.0,
                  ),
                ),
                ListTile(
                  visualDensity: VisualDensity.compact,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PatinetAboutScreen()));
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
                  visualDensity: VisualDensity.compact,
                  onTap: () {
                    Get.toNamed(RouteHelper.getPatientSupportScreen());
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
                ListTile(
                  visualDensity: VisualDensity.compact,
                  onTap: () {
                    Get.toNamed(RouteHelper.getPatientSettingsScreen());
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
                const Divider(
                  height: 20.0,
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
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    preferences.remove("LOGIN_KEY");
                                    print(preferences.remove("LOGIN_KEY"));
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

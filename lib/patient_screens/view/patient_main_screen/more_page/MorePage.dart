import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prophysio/helper/AppConst.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../../ZegoCallService/ZegoCallService.dart';
import '../../../../helper/CustomView/CustomView.dart';
import '../../../../helper/mycolor/mycolor.dart';
import '../../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../../../language_translator/LanguageTranslate.dart';
import '../../../controller/auth_controllers/PatientProfileController.dart';
import "../../../controller/auth_controllers/card_controller's/PatientCardController.dart";
import '../../IntakeForm/intake_form_screen.dart';
import 'Ratings_and_reviews/Rating&ReviewPage.dart';
import 'my_past_chekup/PatientPastChekups.dart';

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
  LocalString text = LocalString();

  @override
  void initState() {
    // cardCtr.cardFetch();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      patientProfileCtr.patientProfile(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Align(
                  alignment: Alignment.center,
                  child: Image(
                    image: AssetImage("assets/images/runlogo.png"),
                    height: 40,
                    width: 40,
                  ),
                ),
                customView.text(
                    "${text.hii.tr} @${AppConst.Patient_Name}",
                    17.0,
                    FontWeight.w500,
                    Colors.black),
                const SizedBox(
                  height: 8.0,
                ),
                cardCtr.cardList.isEmpty
                    ? Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: MyColor.primary),
                            color: MyColor.lightcolor,
                            borderRadius: BorderRadius.circular(15)),
                        child: ListTile(
                          visualDensity: VisualDensity.compact,
                          onTap: () {
                            Get.toNamed(
                                RouteHelper.getPatientAddNewCardScreen());
                          },
                          title: customView.text(text.addCreditCard.tr, 16,
                              FontWeight.w500, MyColor.white),
                          subtitle: Row(
                            children: [
                              Text(text.goto.tr,
                                  style: const TextStyle(color: MyColor.white)),
                              SizedBox(width: 2,),
                              Text(text.payment.tr,
                                  style: const TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: MyColor.primary1,
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(text.toCompleteIt.tr,
                                  style: TextStyle(color: MyColor.white)),
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
                              colors: [MyColor.primary, MyColor.primary1],
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                               Column(
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
                                        child: Icon(Icons.person_outline_sharp,color: Colors.white)),
                                                                 ),
                                 ],
                               ),
                              Align(
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
                                    child: Icon(Icons.payment,color: Colors.white)),
                              ),
                              Align(
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
                                        child: customView.text(text.payment.tr,
                                            12.0, FontWeight.w400, Colors.black)),
                                  )),
                            ],
                          )

                        ),
                      ),
                    ),
                  ],
                ),
               Divider(
                    color: MyColor.grey.withOpacity(0.5),
                    height: 30,
                  ),
                ListTile(
                  subtitle: customView.text(text.rateAppointmentYouDid.tr, 10.0,
                      FontWeight.w500, Colors.black),
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
                  title: customView.text(text.ratingsAndReviews.tr, 14.0,
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
                      text.reports.tr, 14.0, FontWeight.w500, Colors.black),
                  subtitle: customView.text(
                      text.viewYourPrescriptionMedicalTestMedicines.tr,
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
                            builder: (context) =>
                            const IntakeFormScreen()));
                    // Get.toNamed(RouteHelper.getPatientSupportScreen());
                  },
                  leading: const Icon(
                    Icons.file_copy_outlined,
                    color: Colors.black,
                  ),
                  title: customView.text(
                      "Intake Form", 14.0, FontWeight.w500, Colors.black),
                  subtitle: customView.text(
                      "Intake form for general details",
                      10.0,
                      FontWeight.w500,
                      Colors.black),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 20.0,
                  ),
                ),

                // ListTile(
                //   visualDensity: VisualDensity.compact,
                //   onTap: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => const PatientQRShow()));
                //   },
                //   leading: const Icon(
                //     Icons.qr_code_scanner_sharp,
                //     color: Colors.black,
                //   ),
                //   title: customView.text(
                //       text.qrCode.tr, 14.0, FontWeight.w500, Colors.black),
                //   subtitle: customView.text(text.viewYourQrCode.tr, 10.0,
                //       FontWeight.w500, Colors.black),
                //   trailing: const Icon(
                //     Icons.arrow_forward_ios,
                //     color: Colors.black,
                //     size: 20.0,
                //   ),
                // ),

               /* ListTile(
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
                  title: customView.text(text.TermCondition.tr, 14.0,
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
                      text.About.tr, 14.0, FontWeight.w500, Colors.black),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 20.0,
                  ),
                ),*/

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
                      text.Support.tr, 14.0, FontWeight.w500, Colors.black),
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
                      text.Settings.tr, 14.0, FontWeight.w500, Colors.black),
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
                        text.Logout.tr, 15.0, FontWeight.w500, Colors.red),
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
                                    preferences.remove("LOGIN_KEY");
                                    preferences.remove("PATIENT_ID_KEY");
                                    print(preferences.remove("LOGIN_KEY"));
                                    sp.clearSharedPreference();
                                    sp.setBoolValue(sp.ON_BOARDING_KEY, true);
                                    onUserLogout();

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

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:prophysio/patient_screens/view/patient_main_screen/more_page/IntakeForm/IntakePainDisablity.dart';
import '../../../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../../language_translator/LanguageTranslate.dart';
import '../../../../controller/auth_controllers/PatientChangePasswordCtr.dart';
import '../../../IntakeForm/intake_form_screen.dart';
import '../about_page/PatinetAboutPage.dart';
import '../term_condition_page/PatientTermCondition.dart';
import 'IntakeDisablity.dart';
import 'IntakeHand.dart';
import 'IntakeQuickdash.dart';

class IntakeTypeScreen extends StatefulWidget {
  final id;
  const IntakeTypeScreen({super.key, this.id});

  @override
  State<IntakeTypeScreen> createState() => _IntakeTypeScreenState();
}

class _IntakeTypeScreenState extends State<IntakeTypeScreen> {
  CustomView customView = CustomView();
  LocalString text = LocalString();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: customView.text(
              "Intake Form", 15.0, FontWeight.w500, Colors.black),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          const IntakeFormScreen()));
                  // Get.toNamed(
                  //   RouteHelper.getPatientChangePasswordScreen(),
                  // );
                },
                title: customView.text("General Details", 14.0,
                    FontWeight.w500, Colors.black),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 20.0,
                ),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                           IntakeDisablity(id: widget.id,)));
                },
                title: customView.text("For Neck Disability", 12.0,
                    FontWeight.w500, Colors.black),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 20.0,
                ),
              ),
              Divider(),

              ListTile(
                visualDensity: VisualDensity.compact,
                onTap: () {

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                           IntakePainDisablity(id: widget.id,)));
                },
                title: customView.text(
                    "For Oswestry Low Back Pain Disability", 14.0, FontWeight.w500, Colors.black),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 20.0,
                ),
              ),
              Divider(),

              ListTile(
                visualDensity: VisualDensity.compact,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          const IntakeHandDisablity()));
                  },

                title: customView.text(
                    "For Michigan Hand", 14.0, FontWeight.w500, Colors.black),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 20.0,
                ),
              ),
              Divider(),

              ListTile(
                visualDensity: VisualDensity.compact,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                           IntakeQuickDASHDisablity(id: widget.id,)));
                },

                title: customView.text(
                    "For QuickDASH", 12.0, FontWeight.w500, Colors.black),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 20.0,
                ),
              ),
              Divider(),

            ],
          ),
        ),
      ),
    );
  }

}

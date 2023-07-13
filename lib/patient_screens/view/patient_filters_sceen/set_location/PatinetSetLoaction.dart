import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

import '../../../../helper/CustomView/CustomView.dart';
import '../../../../helper/mycolor/mycolor.dart';
import '../../../../language_translator/LanguageTranslate.dart';
import '../../../controller/filter_controller/PatientFilterController.dart';

class PatientSetLocation extends StatefulWidget {
  const PatientSetLocation({Key? key}) : super(key: key);

  @override
  State<PatientSetLocation> createState() => _PatientSetLocationState();
}

class _PatientSetLocationState extends State<PatientSetLocation> {
  TextEditingController labelCtr = TextEditingController();
  TextEditingController addressCtr = TextEditingController();
  TextEditingController capCtr = TextEditingController();

  PatientFilterCtr patientFilterCtr = Get.put(PatientFilterCtr());
  LocalString text = LocalString();

  CustomView custom = CustomView();
  String latitude = "";
  String longitude = "";
  String label = "";

  @override
  void initState() {
    labelCtr.text = patientFilterCtr.lables.value;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white24,
        title: custom.text(text.setLocation.tr, 17, FontWeight.bold, MyColor.black),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.close_outlined, color: MyColor.black),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Obx(() {
          if (patientFilterCtr.loading.value) {
            return custom.MyIndicator();
          }
          return custom.MyButton(context, text.setLocation.tr, () async {
            if (await validation()) {
              patientFilterCtr.setLocation(context, labelCtr.text, capCtr.text,
                  addressCtr.text, latitude, longitude);
            }

            // Get.back();
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>const PatientEditLocation()));
          }, MyColor.primary,
              const TextStyle(color: MyColor.white, fontFamily: "Poppins"));
        }),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              const Divider(),
              SizedBox(
                height: height * 0.03,
              ),
              custom.text("Add a new address to calculate the distance\n from.",
                  13, FontWeight.w500, MyColor.black),
              SizedBox(
                height: height * 0.04,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: custom.text(
                    text.setLabel.tr, 13.0, FontWeight.w500, Colors.black),
              ),
              SizedBox(
                height: height * 0.005,
              ),
              custom.myField(
                  context, labelCtr,text.setLabel.tr, TextInputType.text),
              SizedBox(
                height: height * 0.04,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: custom.text(
                    text.enterAddress.tr, 13.0, FontWeight.w500, Colors.black),
              ),
              SizedBox(
                height: height * 0.005,
              ),
              custom.myField(
                  context, addressCtr, text.yourAddres.tr, TextInputType.text),
              SizedBox(
                height: height * 0.04,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: custom.text(
                    text.enterCAP.tr, 13.0, FontWeight.w500, Colors.black),
              ),
              SizedBox(
                height: height * 0.005,
              ),
              custom.myField(context, capCtr,text.yourCap.tr, TextInputType.text),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> validation() async {
    if (labelCtr.text.toString().isEmpty) {
      custom.MySnackBar(context, text.requiredLabel.tr);
    } else if (addressCtr.text.toString().isEmpty) {
      custom.MySnackBar(context,text.enterAddress.tr);
    } else if (capCtr.text.toString().isEmpty) {
      custom.MySnackBar(context,text.enterCAP.tr);
    } else {
      return await latLong(addressCtr.text);
    }
    return false;
  }

  Future<bool> latLong(String address) async {
    try {
      List<Location> locationsList = await locationFromAddress(address);
      print(locationsList[0].latitude);
      print(locationsList[0].longitude);

      latitude = locationsList[0].latitude.toString();
      longitude = locationsList[0].longitude.toString();
      return true;
    } catch (e) {
      log("Exception :-", error: e.toString());
      custom.MySnackBar(context, text.invalidAddress.tr);
      return false;
    }
  }
}


import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:medica/helper/Shimmer/ChatShimmer.dart';

import '../../../../../doctor_screens/controller/prescriptionAddFetchCtr/DoctorPrescriptionCtr.dart';
import '../../../../../helper/mycolor/mycolor.dart';

class PatientMedicalReport extends StatefulWidget {
  const PatientMedicalReport({Key? key}) : super(key: key);

  @override
  State<PatientMedicalReport> createState() => _PatientMedicalReportState();
}

class _PatientMedicalReportState extends State<PatientMedicalReport> {
  TextEditingController titleCtr = TextEditingController();
  TextEditingController discCtr = TextEditingController();
  CustomView custom = CustomView();
  String image = "";
  DoctorPrescriptionCtr doctorPrescriptionCtr =
  Get.put(DoctorPrescriptionCtr());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      doctorPrescriptionCtr.fetchPatientPrescription("medical");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    return Obx(() {
      return SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: custom.text(
                  "Title", 13, FontWeight.w500, MyColor.primary1),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            custom.myField(
                context, titleCtr, "Enter Title", TextInputType.emailAddress),
            SizedBox(
              height: height * 0.03,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: custom.text("Upload Medical report", 13.0, FontWeight.w500,
                  MyColor.primary1),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                  color: MyColor.white,
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(
                    color: Colors.black38,
                  ),
                ),
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 1,
                height: 48,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Icon(Icons.upload, color: MyColor.primary1),
                    ),
                    Text(
                      filename.toString(),
                      style: const TextStyle(
                          fontSize: 10, color: Colors.black45),
                    ),
                  ],
                ),
              ),
              onTap: () {
                // AdharIdCtr.toString();
                _chooseDegree();
              },
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: custom.text(
                  "Write Description", 13.0, FontWeight.w500, MyColor.primary1),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            custom.HField(
              context,
              discCtr,
              "Enter Description...",
              TextInputType.text,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            doctorPrescriptionCtr.loadingAddP.value
                ? custom.MyIndicator()
                : custom.mysButton(context, "Submit", () {

                  if(validation()){
                    doctorPrescriptionCtr.addPrescriptionPatient(
                        context,
                        "medical",
                        titleCtr.text,
                        discCtr.text,
                        filename,
                        baseimage, () {
                      doctorPrescriptionCtr.fetchPatientPrescription("medical");
                    });
                  }

            }, MyColor.primary, const TextStyle(color: MyColor.white)),
            const Divider(
              height: 50,
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                custom.text(
                    "Past Medical report's", 13.0, FontWeight.w500,
                    MyColor.primary1),
                TextButton(
                    onPressed: () {
                      doctorPrescriptionCtr.fetchPatientPrescription("medical");
                    },
                    child: const Text(
                      "Refresh",
                      style: TextStyle(color: MyColor.primary1),
                    )),
              ],
            ),
            doctorPrescriptionCtr.loadingPFetch.value
                ? SingleChildScrollView(
                child: categorysubShimmerEffect(context))
                : SingleChildScrollView(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount:
                doctorPrescriptionCtr.patientPrescriptionList.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: MyColor.midgray,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      title: custom.text(
                          doctorPrescriptionCtr
                              .patientPrescriptionList[index].title,
                          16,
                          FontWeight.w400,
                          MyColor.primary1),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: "Poppins",
                            ),
                            doctorPrescriptionCtr
                                .patientPrescriptionList[index].description,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 3,),
                          custom.text(
                              "${doctorPrescriptionCtr
                                  .patientPrescriptionList[index].result}${doctorPrescriptionCtr
                                  .patientPrescriptionList[index].doctorName}",
                              12,
                              FontWeight.w400,
                              MyColor.primary1),
                        ],
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          image = doctorPrescriptionCtr
                              .patientPrescriptionList[index].image;
                          imagePopUp(context, image);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: FadeInImage.assetNetwork(
                            imageErrorBuilder:
                                (context, error, stackTrace) =>
                            const Image(
                              image:
                              AssetImage("assets/images/noimage.png"),
                            ),
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            placeholder: "assets/images/loading.gif",
                            image: doctorPrescriptionCtr
                                .patientPrescriptionList[index].image,
                            placeholderFit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  //******************prescription add VALIDATION (IF/ELSE CONDITIONS.)*****************//
  bool validation() {
    if (titleCtr.text
        .toString()
        .isEmpty) {
      custom.MySnackBar(context, "Enter title");
    } else if (degreefilePath == null) {
      custom.MySnackBar(context, "Upload prescription");
    } else if (discCtr.text
        .toString()
        .isEmpty) {
      custom.MySnackBar(context, "Enter description");
    } else {
      return true;
    }
    return false;
  }


  File? degreefilePath;
  final degreepicker = ImagePicker();
  String baseimage = "";
  String filename = "";

  void _chooseDegree() async {
    final pickedFile = await degreepicker.getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 200,
        maxWidth: 200);
    setState(() {
      if (pickedFile != null) {
        degreefilePath = File(pickedFile.path);
        List<int> imageBytes = degreefilePath!.readAsBytesSync();
        baseimage = base64Encode(imageBytes);
        filename = DateTime.now().toString() + ".jpeg".toString();
        print(baseimage);
        print(filename);
      } else {
        print('No image selected.');
      }
    });
  }

  void imagePopUp(BuildContext context, String image) {
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
                          InteractiveViewer(
                            panEnabled: false,
                            // Set it to false
                            boundaryMargin: EdgeInsets.all(100),
                            minScale: 0.5,
                            maxScale: 2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: FadeInImage.assetNetwork(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                height:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.5,
                                fit: BoxFit.cover,
                                placeholder: "assets/images/loading.gif",
                                image: image,
                                placeholderFit: BoxFit.cover,
                              ),
                            ),
                          ),
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

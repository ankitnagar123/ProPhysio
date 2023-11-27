
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


import '../../../../../doctor_screens/controller/prescriptionAddFetchCtr/DoctorPrescriptionCtr.dart';
import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/Shimmer/ChatShimmer.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../../language_translator/LanguageTranslate.dart';

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
  LocalString text = LocalString();

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
                  text.title.tr, 13, FontWeight.w500, MyColor.primary1),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            custom.myField(
                context, titleCtr,text.enterTitle.tr, TextInputType.emailAddress),
            SizedBox(
              height: height * 0.03,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: custom.text(text.uploadPrescription.tr, 13.0, FontWeight.w500,
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
                  text.writeDescription.tr, 13.0, FontWeight.w500, MyColor.primary1),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            custom.HField(
              context,
              discCtr,
              text.writeDescription.tr,
              TextInputType.text,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            doctorPrescriptionCtr.loadingAddP.value
                ? custom.MyIndicator()
                : custom.mysButton(context, text.Submit.tr, () {

                  if(validation()){
                    doctorPrescriptionCtr.addPrescriptionPatient(
                        context,
                        "medical",
                        titleCtr.text,
                        discCtr.text,
                        filename,
                        baseimage, () {
                      titleCtr.clear();
                      discCtr.clear();
                      filename = "";
                      baseimage = "";
                      degreefilePath = null;
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
                    text.pastMedicalReport.tr, 13.0, FontWeight.w500,
                    MyColor.primary1),
                TextButton(
                    onPressed: () {
                      doctorPrescriptionCtr.fetchPatientPrescription("medical");
                    },
                    child:  Text(
                      text.refresh.tr,
                      style: const TextStyle(color: MyColor.primary1),
                    )),
              ],
            ),
            doctorPrescriptionCtr.loadingPFetch.value
                ? SingleChildScrollView(
                child: categorysubShimmerEffect(context))
                : doctorPrescriptionCtr.patientPrescriptionList.isEmpty? Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(text.noMedicalReportRightKnow.tr),
            ):SingleChildScrollView(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount:
                doctorPrescriptionCtr.patientPrescriptionList.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: MyColor.midgray,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
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
                          const SizedBox(height: 3,),
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
      custom.MySnackBar(context, text.enterTitle.tr);
    } else if (degreefilePath == null) {
      custom.MySnackBar(context, text.uploadMedicalReport.tr);
    } else if (discCtr.text
        .toString()
        .isEmpty) {
      custom.MySnackBar(context, text.writeDescription.tr);
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
        imageQuality: 100,);
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
                  return  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InteractiveViewer(
                      panEnabled: false,
                      // Set it to false
                      boundaryMargin: const EdgeInsets.all(100),
                      minScale: 0.5,
                      maxScale: 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: FadeInImage.assetNetwork(
                          imageErrorBuilder:
                              (context, error, stackTrace) {
                            return const Image(
                                image: AssetImage(
                                    "assets/images/noimage.png"));
                          },
                          width: MediaQuery.of(context).size.width,
                          height:
                          MediaQuery.of(context).size.height * 0.5,
                          fit: BoxFit.cover,
                          placeholder: "assets/images/loading.gif",
                          image: image,
                          placeholderFit: BoxFit.cover,
                        ),
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

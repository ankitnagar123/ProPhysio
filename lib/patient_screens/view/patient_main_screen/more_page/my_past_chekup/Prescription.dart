import 'dart:developer';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';

import 'package:file_picker/file_picker.dart';

import '../../../../../../helper/CustomView/CustomView.dart';
import '../../../../../doctor_screens/controller/prescriptionAddFetchCtr/DoctorPrescriptionCtr.dart';
import '../../../../../doctor_screens/view/doctor_main_page/doctor_more_page/add_prescriptiona&medicalTest/AddPrescriptionandMedicalReport/ReportPdfView.dart';
import '../../../../../helper/Shimmer/ChatShimmer.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

import '../../../../../language_translator/LanguageTranslate.dart';

class PatientPrescription extends StatefulWidget {
  const PatientPrescription({Key? key}) : super(key: key);

  @override
  State<PatientPrescription> createState() => _PatientPrescriptionState();
}

class _PatientPrescriptionState extends State<PatientPrescription> {

  TextEditingController titleCtr = TextEditingController();
  TextEditingController discCtr = TextEditingController();
  CustomView custom = CustomView();
  String image = "";
  LocalString text = LocalString();

  DoctorPrescriptionCtr doctorPrescriptionCtr = Get.put(DoctorPrescriptionCtr());

  bool isPDF(String url) {
    return url.contains('.pdf');
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      doctorPrescriptionCtr.fetchPatientPrescription("prescription");
    });
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
                context, titleCtr, text.enterTitle.tr, TextInputType.text),
            SizedBox(
              height: height * 0.03,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: custom.text(
                  text.uploadPrescription.tr, 13.0, FontWeight.w500,
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
                        "prescription",
                        titleCtr.text,
                        discCtr.text,
                        filename,
                        baseImage, () {
                          titleCtr.clear();
                          discCtr.clear();
                          filename = "";
                          baseImage = "";
                          degreefilePath = null;
                      doctorPrescriptionCtr.fetchPatientPrescription("prescription");
                    });
                  }
            }, MyColor.primary, const TextStyle(color: MyColor.white)),

            const Divider(
              height: 50,

            ),
            Align(
              alignment: Alignment.topLeft,
              child: custom.text(
                  text.yourPrescription.tr, 14.0, FontWeight.w500,
                  MyColor.primary1),
            ),
            const SizedBox(height: 5.0,),
              doctorPrescriptionCtr.loadingPFetch.value?SingleChildScrollView(
                    child: categorysubShimmerEffect(context)):doctorPrescriptionCtr.patientPrescriptionList.isEmpty? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(text.noPrescription.tr),
                    ):
              SingleChildScrollView(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: doctorPrescriptionCtr.patientPrescriptionList
                      .length,
                  itemBuilder: (context, index) {
                    var list = doctorPrescriptionCtr.patientPrescriptionList[index];
                    return Card(
                      surfaceTintColor: Colors.grey,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10),
                        title: custom.text(
                            list.title,
                            16, FontWeight.w400, MyColor.primary1),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              style: const TextStyle(
                                fontSize: 12,
                                fontFamily: "Poppins",
                              ),
                              list.description,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,

                            ),
                            /*   custom.text(doctorPrescriptionCtr.patientPrescriptionList[index].result,
                              12,
                              FontWeight.w400,
                              MyColor.primary1),*/
                            custom.text("${list.result} ${list.doctorName}", 13,
                                FontWeight.w400, MyColor.primary1
                            ),
                          ],
                        ),
                        trailing: isPDF(list.image)
                            ? InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>  ReportPdfView(url: list.image, name:"",),));

                            },
                            child:  const Icon(
                              Icons.download_for_offline,
                              color: MyColor.primary1,
                            ))

                            :Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                image = doctorPrescriptionCtr
                                    .patientPrescriptionList[index]
                                    .image;
                                imagePopUp(context, image);
                              },
                              child: ClipRRect(
                                borderRadius:
                                BorderRadius.circular(8.0),
                                child: FadeInImage.assetNetwork(
                                  imageErrorBuilder: (context, error,
                                      stackTrace) => const Image(image: AssetImage(
                                      "assets/images/noimage.png"),),
                                  width: 80,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  placeholder:
                                  "assets/images/loading.gif",
                                  image: doctorPrescriptionCtr
                                      .patientPrescriptionList[index]
                                      .image,
                                  placeholderFit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 2,
                              child: InkWell(
                                  onTap: () {
                                    doctorPrescriptionCtr.downLoadFileRepost(
                                        context,list.image,
                                        "Prescription");
                                  },
                                  child:  const Icon(
                                    Icons.download_for_offline,
                                    color: MyColor.primary1,
                                  )),
                            )                          ],

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
    } else if (baseImage.isEmpty) {
      custom.MySnackBar(context, text.uploadPrescription.tr);
    } else if (discCtr.text
        .toString()
        .isEmpty) {
      custom.MySnackBar(context, text.writeDescription.tr);
    } else {
      return true;
    }
    return false;
  }


  File? degreefilePath; // Used to store the selected file
  String baseImage = ""; // Base64 representation for image
  String filename = ""; // Filename for the selected file (image or PDF)

// ...

  Future<void> _chooseDegree() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result != null) {
      final pickedFile = result.files.first;
      final filePath = pickedFile.path!;
      final extension = filePath.split('.').last.toLowerCase();

      // Check if the picked file is a PDF
      if (extension == 'pdf') {
        log('Selected file is a PDF');

        try {
          final file = File(filePath);
          final fileBytes = await file.readAsBytes();

          if (fileBytes.isNotEmpty) {
            // Convert the bytes to a base64 string
            baseImage = base64Encode(fileBytes);
            filename = "${DateTime.now()}.$extension";
            setState(() {});

            log('PDF file converted to base64: $baseImage');
            log('Filename: $filename');
          } else {
            log('Error: File bytes are empty');
          }
        } catch (e) {
          log('Error reading PDF file: $e');
        }
      } else if (extension == 'jpg' ||
          extension == 'jpeg' ||
          extension == 'png') {
        // If the picked file is an image, process it similarly as before
        log('Selected file is an image');

        degreefilePath = File(filePath);
        final fileBytes = degreefilePath!.readAsBytesSync();
        baseImage = base64Encode(fileBytes);
        filename = DateTime.now().toString() + ".$extension";
        setState(() {});

        print('Image file converted to base64: $baseImage');
        print('Filename: $filename');
      } else {
        print('Unsupported file type: $extension');
      }
    } else {
      print('No file selected.');
    }
  }

  void imagePopUp(BuildContext context, String image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: FadeInImage.assetNetwork(
                      imageErrorBuilder: (context, error, stackTrace) {
                        return const Image(
                            image: AssetImage("assets/images/noimage.png"));
                      },
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.5,
                      fit: BoxFit.contain,
                      placeholder: "assets/images/loading.gif",
                      image: image,
                      placeholderFit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                    right:1,
                    child: InkWell(
                        onTap:() {
                          Get.back();
                        },
                        child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: MyColor.primary1,
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            child: const Icon(Icons.close,color: Colors.white,))))
              ]
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../doctor_screens/controller/prescriptionAddFetchCtr/DoctorPrescriptionCtr.dart';
import '../../../../../helper/Shimmer/ChatShimmer.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class PatientPrescription extends StatefulWidget {
  const PatientPrescription({Key? key}) : super(key: key);

  @override
  State<PatientPrescription> createState() => _PatientPrescriptionState();
}

class _PatientPrescriptionState extends State<PatientPrescription> {
  MobileScannerController mobileScannerController = MobileScannerController();

  TextEditingController titleCtr = TextEditingController();
  TextEditingController discCtr = TextEditingController();
  CustomView custom = CustomView();
  String image = "";
  DoctorPrescriptionCtr doctorPrescriptionCtr = Get.put(DoctorPrescriptionCtr());


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
              child: custom.text(
                  "Upload Prescription", 13.0, FontWeight.w500,
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
              "Enter description...",
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
                        "prescription",
                        titleCtr.text,
                        discCtr.text,
                        filename,
                        baseimage, () {
                          titleCtr.clear();
                          discCtr.clear();
                          filename = "";
                          baseimage = "";
                          degreefilePath = null;
                      doctorPrescriptionCtr.fetchPatientPrescription("prescription");
                    });
                  }
            }, MyColor.primary, const TextStyle(color: MyColor.white)),

            const Divider(
              height: 50,
              thickness: 2,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: custom.text(
                  "Your Prescription", 14.0, FontWeight.w500,
                  MyColor.primary1),
            ),
            const SizedBox(height: 5.0,),
              doctorPrescriptionCtr.loadingPFetch.value?SingleChildScrollView(
                    child: categorysubShimmerEffect(context)):
              SingleChildScrollView(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: doctorPrescriptionCtr.patientPrescriptionList
                      .length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: MyColor.midgray,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10),
                        title: custom.text(
                            doctorPrescriptionCtr.patientPrescriptionList[index]
                                .title,
                            16, FontWeight.w400, MyColor.primary1),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              style: const TextStyle(
                                fontSize: 12,
                                fontFamily: "Poppins",
                              ),
                              doctorPrescriptionCtr
                                  .patientPrescriptionList[index]
                                  .description,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,

                            ),
                            /*   custom.text(doctorPrescriptionCtr.patientPrescriptionList[index].result,
                              12,
                              FontWeight.w400,
                              MyColor.primary1),*/
                            custom.text("${doctorPrescriptionCtr
                                .patientPrescriptionList[index]
                                .result} ${doctorPrescriptionCtr
                                .patientPrescriptionList[index].doctorName}",
                                13,
                                FontWeight.w400,
                                MyColor.primary1),
                          ],
                        ),
                        trailing: GestureDetector(
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
        imageQuality: 100,
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
                              borderRadius:
                              BorderRadius.circular(8.0),
                              child: FadeInImage.assetNetwork(
                                imageErrorBuilder: (context, error,
                                    stackTrace) => const Center(
                                      child: Image(image: AssetImage(
                                      "assets/images/noimage.png"),height: 60,width: 60),
                                    ),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.5,
                                fit: BoxFit.cover,
                                placeholder:
                                "assets/images/loading.gif",
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

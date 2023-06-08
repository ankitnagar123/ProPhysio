import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medica/doctor_screens/controller/prescriptionAddFetchCtr/DoctorPrescriptionCtr.dart';

import '../../../../../../helper/CustomView/CustomView.dart';
import '../../../../../../helper/mycolor/mycolor.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../QRScannerReports/QRScannerPage.dart';
import 'AddMedicines/AddMedicinesTab.dart';

class PrescriptionAddAndList extends StatefulWidget {
  String patientId;

  PrescriptionAddAndList({
    Key? key,
    required this.patientId,
  }) : super(key: key);

  @override
  State<PrescriptionAddAndList> createState() => _PrescriptionAddAndListState();
}

class _PrescriptionAddAndListState extends State<PrescriptionAddAndList> {
  TextEditingController titleCtr = TextEditingController();
  TextEditingController discCtr = TextEditingController();
  CustomView custom = CustomView();
  DoctorPrescriptionCtr doctorPrescriptionCtr = Get.put(DoctorPrescriptionCtr());
  String image = "";
  MobileScannerController mobileScannerController = MobileScannerController();


  @override
  void initState() {
    doctorPrescriptionCtr.fetchPrescription(widget.patientId, "prescription");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Obx(() {

        if (doctorPrescriptionCtr.loadingFetch.value) {
          return Center(
              heightFactor: 12,child: custom.MyIndicator());
        }else{
          var details = doctorPrescriptionCtr.prescriptionList.value;
          return Column(children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                 onTap: () {
                   Navigator.push(context,MaterialPageRoute(builder: (context)=>AddMedicinesTab(patientId: widget.patientId,)));
                 },
                child: Card(
                    elevation: 2,child: custom.text("Add Medicine", 13, FontWeight.w500, MyColor.primary1)),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: custom.text("Title", 13, FontWeight.w500, MyColor.primary1),
            ),
            SizedBox(
              height: height * 0.005,
            ),
            custom.myField(
                context, titleCtr, "Enter Title", TextInputType.emailAddress),
            SizedBox(
              height: height * 0.02,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: custom.text(
                  "Upload Prescription", 13.0, FontWeight.w500, MyColor.primary1),
            ),
            SizedBox(
              height: height * 0.005,
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
                width: MediaQuery.of(context).size.width * 1,
                height: 48,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Icon(Icons.upload, color: MyColor.primary1),
                    ),
                    Text(
                      filename.toString(),
                      style: const TextStyle(fontSize: 10, color: Colors.black45),
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
              height: height * 0.02,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: custom.text(
                  "Write Description", 13.0, FontWeight.w500, MyColor.primary1),
            ),
            SizedBox(
              height: height * 0.005,
            ),
            custom.HField(
              context,
              discCtr,
              "Enter description",
              TextInputType.text,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            doctorPrescriptionCtr.loadingAdd.value == true
                ? custom.MyIndicator()
                : custom.mysButton(context, "Submit", () {
              if(titleCtr.text.isEmpty){
                custom.MySnackBar(context, "Enter title");
              }else if(discCtr.text.isEmpty){
                custom.MySnackBar(context, "Enter description");
              }else if(filename.isEmpty){
                custom.MySnackBar(context, "Upload prescription");
              }else{
                doctorPrescriptionCtr.addPrescription(
                  context,
                  widget.patientId,
                  'prescription',
                  titleCtr.text,
                  discCtr.text,
                  filename,
                  baseimage,
                      () {
                    doctorPrescriptionCtr.fetchPrescription(
                        widget.patientId, "prescription");
                  },
                );
              }

            }, MyColor.primary, const TextStyle(color: MyColor.white)),
            const Divider(
              height: 10,
              thickness: 1.5,
            ),
            const SizedBox(height: 10,),
            Align(
              alignment: Alignment.topLeft,
              child: custom.text(
                  "Patient Medical Record",
                  18,
                  FontWeight.w500,
                  MyColor.primary1),
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      const Text(
                        "Patient Information",
                        style: TextStyle(
                            color: MyColor.primary1,
                            fontSize: 15.0,
                            fontFamily: "Poppins"),
                      ),
                      const SizedBox(
                        height: 2.0,
                      ),
                      Text(details!.username,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontFamily: "Poppins")),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      const Text(
                        "Birth Date",
                        style: TextStyle(
                            color: MyColor.primary1,
                            fontSize: 15.0,
                            fontFamily: "Poppins"),
                      ),
                      const SizedBox(
                        height: 2.0,
                      ),
                      Text(
                        details.birthPlace,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontFamily: "Poppins"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: 1.0,
              height: 20.0,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      const Text(
                        "Contact",
                        style: TextStyle(
                            color: MyColor.primary1,
                            fontSize: 15.0,
                            fontFamily: "Poppins"),
                      ),
                      SizedBox(
                        height: 2.0,
                      ),
                      Text(
                          details!.contact,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontFamily: "Poppins")),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      const Text(
                        "Weight",
                        style: TextStyle(
                            color: MyColor.primary1,
                            fontSize: 15.0,
                            fontFamily: "Poppins"),
                      ),
                      const SizedBox(
                        height: 2.0,
                      ),
                      Text(
                          details.weight,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontFamily: "Poppins")),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: 1,
              height: 20.0,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text(
                        "Address",
                        style: TextStyle(
                            color: MyColor.primary1,
                            fontSize: 15.0,
                            fontFamily: "Poppins"),
                      ),
                      const SizedBox(
                        height: 2.0,
                      ),
                      Text(
                          details.location,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontFamily: "Poppins")),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      const Text(
                        "Height",
                        style: TextStyle(
                            color: MyColor.primary1,
                            fontSize: 14.0,
                            fontFamily: "Poppins"),
                      ),
                      const SizedBox(
                        height: 2.0,
                      ),
                      Text(
                          details.height,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontFamily: "Poppins")),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: 1,
              height: 40.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: custom.text(
                  "General Medical History",
                  18,
                  FontWeight.w500,
                  MyColor.primary1),
            ),
            const Divider(
              color: MyColor.primary1,
              thickness: 1,
              height: 20.0,
            ),
            doctorPrescriptionCtr.prescriptionList.value!.details.length == 0
                ?  const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text("No Past Prescription at the moment!"),
            )
                :  ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: doctorPrescriptionCtr.prescriptionList.value!.details.length,
              itemBuilder: (context, index) {
                var list = doctorPrescriptionCtr.prescriptionList.value!.details[index];
                return Card(
                  color: MyColor.midgray,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    title: custom.text(
                        list.title,
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
                          list.description,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5,),
                        custom.text(
                            "consult with Dr.${list.doctorName}",
                            12,
                            FontWeight.w400,
                            MyColor.primary1),
                      ],
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        image =
                            list.image;
                        imagePopUp(context, image);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: FadeInImage.assetNetwork(
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image(image: AssetImage("assets/images/noimage.png"));
                          },
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          placeholder: "assets/images/loading.gif",
                          image:
                          list.image,
                          placeholderFit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ]);
        }


      }),
    );
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
                          InteractiveViewer(
                            panEnabled: false,
                            // Set it to false
                            boundaryMargin: const EdgeInsets.all(100),
                            minScale: 0.5,
                            maxScale: 2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: FadeInImage.assetNetwork(
                                imageErrorBuilder: (context, error, stackTrace) {
                                  return Image(image: AssetImage("assets/images/noimage.png"));
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

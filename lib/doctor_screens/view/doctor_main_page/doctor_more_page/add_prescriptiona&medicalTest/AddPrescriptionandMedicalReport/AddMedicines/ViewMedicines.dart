import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

import '../../../../../../../helper/CustomView/CustomView.dart';
import '../../../../../../../helper/mycolor/mycolor.dart';
import '../../../../../../../language_translator/LanguageTranslate.dart';
import '../../../../../../controller/prescriptionAddFetchCtr/DoctorPrescriptionCtr.dart';
import 'PDF/medicinePDFVIew.dart';
import 'PDF/pdf_viewer_page.dart';

class DrViewMedicines extends StatefulWidget {
  String patientId;

  DrViewMedicines({
    Key? key,
    required this.patientId,
  }) : super(key: key);

  @override
  State<DrViewMedicines> createState() => _DrViewMedicinesState();
}

class _DrViewMedicinesState extends State<DrViewMedicines> {
  TextEditingController titleCtr = TextEditingController();
  TextEditingController discCtr = TextEditingController();
  CustomView custom = CustomView();
  LocalString text = LocalString();
  DoctorPrescriptionCtr doctorPrescriptionCtr =
      Get.put(DoctorPrescriptionCtr());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      doctorPrescriptionCtr.AddFetchmedicineListAll(widget.patientId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: SingleChildScrollView(
            child: Column(
          children: [
            doctorPrescriptionCtr.loadingMedicineFetch.value
                ? Center(heightFactor: 13, child: custom.MyIndicator())
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: doctorPrescriptionCtr.fetchMedicineList.value!.details.length,
                    itemBuilder: (context, index) {
                      var list = doctorPrescriptionCtr.fetchMedicineList.value!.details[index];
                      var medicineName = list.medicineName;
                      var medicineTime = list.medicineTiming;
                      var medicineSlot = list.medicineSlot;
                      var medicineDisc = list.description;
                   /*   var medicineDrName = list.;
                      var medicineDrSurname = list.doctorSurname;*/
                      return InkWell(
                        onTap: () => showBottomSheet(context,medicineName.toString(),medicineSlot.toString(),medicineTime.toString(),/*medicineDrName.toString(),medicineDrSurname.toString(),*/medicineDisc.toString()),
                        child: Card(
                          color: MyColor.midgray,
                          child: ListTile(
                              contentPadding: const EdgeInsets.all(12),
                              title: custom.text(list.medicineName.toString(), 16,
                                  FontWeight.w400, MyColor.primary1),
                              subtitle: Text(
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: "Poppins",
                                ),
                                list.description,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: Text(list.medicineSlot)),
                        ),
                      );
                    },
                  )
          ],
        )),
      );
    });
  }
  showBottomSheet(BuildContext context ,String medicneName,String slot,String time,/*String drName,String drSurname,*/String dic ) {
    showModalBottomSheet(
      context: context,
        isDismissible: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(7.0))),
        builder: (BuildContext context) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 15.0,
                ),
                custom.text(text.details.tr, 17.0, FontWeight.w500, Colors.black),
                const SizedBox(
                  height: 7.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>const PDF()));
                  },
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                              text.medicinesInformation.tr,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11.0,
                                  fontFamily: "Poppins"),
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Text(
                                medicneName,
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
                          children: [
                             Text(
                              text.slot.tr,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11.0,
                                  fontFamily: "Poppins"),
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Text(
                              slot,
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
                ),
               Divider(
                    color: MyColor.grey.withOpacity(0.5),
                    height: 30,
                  ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            text.timingTake.tr,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 11.0,
                                fontFamily: "Poppins"),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(time,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: "Poppins")),
                        ],
                      ),
                    ),
                  ],
                ),
               Divider(
                    color: MyColor.grey.withOpacity(0.5),
                    height: 30,
                  ),
                // Row(
                //   children: [
                //     Expanded(
                //       flex: 1,
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           const Text(
                //             "Submitted by",
                //             style: TextStyle(
                //                 color: Colors.grey,
                //                 fontSize: 11.0,
                //                 fontFamily: "Poppins"),
                //           ),
                //          /* const SizedBox(
                //             height: 2.0,
                //           ),
                //           Text(
                //               drName+drSurname,
                //               style: const TextStyle(
                //                   color: Colors.black,
                //                   fontSize: 14.0,
                //                   fontFamily: "Poppins")),*/
                //         ],
                //       ),
                //     ),
                //
                //   ],
                // ),
              /* Divider(
                    color: MyColor.grey.withOpacity(0.5),
                    height: 30,
                  ),*/
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            text.description.tr,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 11.0,
                                fontFamily: "Poppins"),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(
                              dic,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: "Poppins")),
                        ],
                      ),
                    ),

                  ],
                ),
               Divider(
                    color: MyColor.grey.withOpacity(0.5),
                    height: 30,
                  ),
              ],
            ),
          );
        });
  }

/*
  Future<File?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['.php'],
    );
    if (result == null) return null;
    return File(result.paths.first ?? '');
  }

  Future<File> loadPdfFromNetwork(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    return _storeFile(url, bytes);
  }

  Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    if (kDebugMode) {
      print('$file');
    }
    return file;
  }*/

  //final file = File('example.pdf');
  //await file.writeAsBytes(await pdf.save());

/*  void openPdf(BuildContext context, File file, String url) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PdfViewerPage(
            file: file,
            url: url,
          ),
        ),
      );*/
}

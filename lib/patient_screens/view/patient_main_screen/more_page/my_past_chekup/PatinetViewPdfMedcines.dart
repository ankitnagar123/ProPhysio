import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../../../../../../../helper/CustomView/CustomView.dart';
import '../../../../../../../helper/mycolor/mycolor.dart';
import '../../../../../../../language_translator/LanguageTranslate.dart';
import '../../../../../doctor_screens/controller/prescriptionAddFetchCtr/DoctorPrescriptionCtr.dart';
import '../../../../../doctor_screens/view/doctor_main_page/doctor_more_page/add_prescriptiona&medicalTest/AddPrescriptionandMedicalReport/AddMedicines/PDF/medicinePDFVIew.dart';

class PatientViewMedicinesPdf extends StatefulWidget {
 String  drId;

   PatientViewMedicinesPdf({
    Key? key,
     required this.drId,
  }) : super(key: key);

  @override
  State<PatientViewMedicinesPdf> createState() => _PatientViewMedicinesPdfState();
}

class _PatientViewMedicinesPdfState extends State<PatientViewMedicinesPdf> {
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
      doctorPrescriptionCtr.AddFetchmedicinePatinet(widget.drId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white24,
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back_ios, color: MyColor.black)),
          elevation: 0,
          centerTitle: true,
          title: custom.text(text.View_Medicine.tr, 17, FontWeight.w500, MyColor.black),
        ),
        body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      var url ="${doctorPrescriptionCtr.fetchMedicineList.value?.pdf}";
                      final file = await loadPdfFromNetwork(url);
                      // openPdf(context, file, url);
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width/2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                               custom.text(text.View_Medicine.tr, 14, FontWeight.w500, MyColor.black),
                              const Icon(Icons.download,color: MyColor.primary1,size: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
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
                              contentPadding: const EdgeInsets.all(7),
                              title: custom.text(list.medicineName.toString(), 16,
                                  FontWeight.w400, MyColor.primary1),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Poppins",
                                    ),
                                    list.medicineSlot,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Poppins",
                                    ),
                                    list.description,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              trailing: const Icon(Icons.details,color: MyColor.primary1,)),
                        ),
                      );
                    },
                  )
                ],
              ),
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
  }

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

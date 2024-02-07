import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';
import 'package:file_picker/file_picker.dart';

import '../../../../../../helper/CustomView/CustomView.dart';
import '../../../../../../helper/mycolor/mycolor.dart';
import '../../../../../../language_translator/LanguageTranslate.dart';
import '../../../../../controller/prescriptionAddFetchCtr/DoctorPrescriptionCtr.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';


class MedicalAddAndList extends StatefulWidget {
  String patientId;

  MedicalAddAndList({
    Key? key,
    required this.patientId,
  }) : super(key: key);

  @override
  State<MedicalAddAndList> createState() => _MedicalAddAndListState();
}

class _MedicalAddAndListState extends State<MedicalAddAndList> {
  TextEditingController titleCtr = TextEditingController();
  TextEditingController discCtr = TextEditingController();
  DoctorPrescriptionCtr doctorPrescriptionCtr = DoctorPrescriptionCtr();
  CustomView custom = CustomView();
  String image = "";
  LocalString text = LocalString();


  bool isPDF(String url) {
    return url.contains('.pdf');
  }
  @override
  void initState() {
    super.initState();
    doctorPrescriptionCtr.fetchPrescription(widget.patientId, "medical");

  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Obx(() {
        if (doctorPrescriptionCtr.loadingFetch.value) {
          return Center(heightFactor: 13,child: custom.MyIndicator());
        }
        var details = doctorPrescriptionCtr.prescriptionList.value;

        return Column(children: [

          Align(
            alignment: Alignment.topLeft,
            child: custom.text(text.title.tr, 13, FontWeight.w500, MyColor.primary1),
          ),
          SizedBox(
            height: height * 0.005,
          ),
          custom.myField(
              context, titleCtr,text.enterTitle.tr, TextInputType.emailAddress),
          SizedBox(
            height: height * 0.02,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: custom.text(text.uploadPrescription.tr, 13.0, FontWeight.w500,
                MyColor.primary1),
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
                text.writeDescription.tr, 13.0, FontWeight.w500, MyColor.primary1),
          ),
          SizedBox(
            height: height  * 0.005,
          ),
          custom.HField(
            context,
            discCtr,
            text.writeDescription.tr,
            TextInputType.text,
          ),
          SizedBox(
            height: height * 0.01,
          ),
          doctorPrescriptionCtr.loadingAdd.value == true
              ? custom.MyIndicator()
              : custom.mysButton(context,  text.Submit.tr, () {
            if(titleCtr.text.isEmpty){
              custom.MySnackBar(context, text.enterTitle.tr);
            }else if(discCtr.text.isEmpty){
              custom.MySnackBar(context,text.writeDescription.tr);
            }else if(filename.isEmpty){
              custom.MySnackBar(context,text.uploadPrescription.tr);
            }else{
              doctorPrescriptionCtr.addPrescription(
                  context,
                  widget.patientId,
                  'medical',
                  titleCtr.text,
                  discCtr.text,
                  filename,
                  baseImage, () {
                doctorPrescriptionCtr.fetchPrescription(
                    widget.patientId, "medical");
              });
            }

                }, MyColor.primary, const TextStyle(color: MyColor.white)),
          const Divider(
            height: 50,
            thickness: 2,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: custom.text(text.pastMedicalReport.tr, 15.0,
                FontWeight.w500, MyColor.primary1),
          ),
          doctorPrescriptionCtr.prescriptionList.value!.details.isEmpty
              ?   Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(text.noMedicalReportRightKnow.tr),
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
                   list.result =="Submitted by Doctor"?  custom.text(
                          "${text.consult_Dr.tr}.${list.doctorName}",
                          12,
                          FontWeight.w400,
                          MyColor.primary1):  custom.text(
                       "${list.result}",
                       12,
                       FontWeight.w400,
                       MyColor.primary1)
                    ],
                  ),
                  trailing: isPDF(list.image)
                      ? InkWell(
                      onTap: () {
                        doctorPrescriptionCtr.downLoadFileRepost(
                            context,list.image,
                            "${details?.name} ${details?.surname}");
                      },
                      child:  const Icon(
                        Icons.download_for_offline,
                        color: MyColor.primary1,
                      ))

                      :Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              image =
                                  list.image;
                              imagePopUp(context, image);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: FadeInImage.assetNetwork(
                                imageErrorBuilder: (context, error, stackTrace) {
                                  return const Image(image: AssetImage("assets/images/noimage.png"));
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
                          Positioned(
                            right: 2,
                            child: InkWell(
                                onTap: () {
                                  doctorPrescriptionCtr.downLoadFileRepost(
                                      context,list.image,
                                      "${details?.name} ${details?.surname}");
                                },
                                child:  const Icon(
                                  Icons.download_for_offline,
                                  color: MyColor.primary1,
                                )),
                          )
                        ],
                      ),
                ),
              );
            },
          )
        ]);
      }),
    );
  }

  File? degreefilePath; // Used to store the selected file
  String baseImage = ""; // Base64 representation for image
  String filename = ""; // Filename for the selected file (image or PDF)
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
                      placeholderFit: BoxFit.contain,
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


  void downLoadFile(String fileurl, String patientName) async {
    FileDownloader.downloadFile(
        url: fileurl,
        name: "$patientName Prescription Report.pdf",
        //THE FILE NAME AFTER DOWNLOADING,
        onProgress: (String? fileName, double? progress) {
          log('FILE fileName HAS PROGRESS $progress');
        },
        onDownloadCompleted: (String path) {
          log('FILE DOWNLOADED TO PATH: $path');
          // startDate.value = "Select";
          // endDate.value = "Select";
          // customSnackBar("file downloaded check download folder");
          // receiptLoader.value = false;
        },
        onDownloadError: (String error) {
          // startDate.value = "Select";
          // endDate.value = "Select";
          log('DOWNLOAD ERROR: $error');
          // receiptLoader.value = false;
        },
        notificationType: NotificationType.all);
  }
}

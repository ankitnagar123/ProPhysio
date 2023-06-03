import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medica/doctor_screens/controller/prescriptionAddFetchCtr/DoctorPrescriptionCtr.dart';

import '../../../../../../helper/CustomView/CustomView.dart';
import '../../../../../../helper/mycolor/mycolor.dart';

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

  @override
  void initState() {

    super.initState();
    doctorPrescriptionCtr.fetchPrescription(widget.patientId, "medical");
    // TODO: implement initState

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
        return Column(children: [

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
            child: custom.text("Upload Medical report", 13.0, FontWeight.w500,
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
                "Write Description", 13.0, FontWeight.w500, MyColor.primary1),
          ),
          SizedBox(
            height: height  * 0.005,
          ),
          custom.HField(
            context,
            discCtr,
            "Enter description...",
            TextInputType.text,
          ),
          SizedBox(
            height: height * 0.01,
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
                'medical',
                titleCtr.text,
                discCtr.text,
                filename,
                baseimage,() {
                doctorPrescriptionCtr.fetchPrescription(widget.patientId, "medical");
              },);
            }

                }, MyColor.primary, const TextStyle(color: MyColor.white)),
          const Divider(
            height: 50,
            thickness: 2,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: custom.text("Patient past Medical report's", 15.0,
                FontWeight.w500, MyColor.primary1),
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
                            boundaryMargin: EdgeInsets.all(100),
                            minScale: 0.5,
                            maxScale: 2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: FadeInImage.assetNetwork(
                                imageErrorBuilder: (context, error, stackTrace) {
                                  return const Image(image: AssetImage("assets/images/noimage.png"));
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

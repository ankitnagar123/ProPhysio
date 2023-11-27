import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../helper/CustomView/CustomView.dart';
import '../../../../../../helper/mycolor/mycolor.dart';
import '../../../../../controller/prescriptionAddFetchCtr/DoctorPrescriptionCtr.dart';

class QRPrescriptionList extends StatefulWidget {
  String patientId;

  QRPrescriptionList({
    Key? key,
    required this.patientId,
  }) : super(key: key);

  @override
  State<QRPrescriptionList> createState() => _QRPrescriptionListState();
}

class _QRPrescriptionListState extends State<QRPrescriptionList> {
  DoctorPrescriptionCtr doctorPrescriptionCtr =
      Get.put(DoctorPrescriptionCtr());

  int selectedCard = 0;
  String image = "";
  CustomView custom = CustomView();
@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      doctorPrescriptionCtr.fetchQrPrescription(widget.patientId, "prescription");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios, color: MyColor.black)),
        centerTitle: true,
        elevation: 0.0,
        title: custom.text("Prescription & Medical reports", 15,
            FontWeight.w500, MyColor.black),
      ),
      body: Obx(() {
        if (doctorPrescriptionCtr.loadingFetchQR.value) {
          return Center(
            heightFactor: 12,
            child: custom.MyIndicator(),
          );
        }else{
          var details = doctorPrescriptionCtr.prescriptionReportQrList.value;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: custom.mysButton(
                          context,
                          "Prescription",
                              () {
                            setState(() {
                              selectedCard = 0;
                            });
                            doctorPrescriptionCtr.fetchQrPrescription(
                                widget.patientId, "prescription");
                          },
                          selectedCard == 0 ? MyColor.primary : MyColor.white,
                          const TextStyle(
                              fontFamily: "Poppins", color: MyColor.primary1),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: custom.mysButton(
                          context,
                          "Medical reports",
                              () {
                            setState(() {
                              selectedCard = 1;
                            });
                            doctorPrescriptionCtr.fetchQrPrescription(
                                widget.patientId, "medical");
                          },
                          selectedCard == 1 ? MyColor.primary : MyColor.white,
                          const TextStyle(
                              fontFamily: "Poppins", color: MyColor.primary1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                /*  Align(
                    alignment: Alignment.topRight,
                    child: custom.text(
                        "12/12/22",
                        14,
                        FontWeight.w400,
                        MyColor.black),
                  ),*/
                  const SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: custom.text(
                        "Patient Medical Record",
                        20,
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
                            Text("${details?.name}${details?.surname}",
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
                              "Birth place",
                              style: TextStyle(
                                  color: MyColor.primary1,
                                  fontSize: 15.0,
                                  fontFamily: "Poppins"),
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Text(
                              details!.birthPlace,
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
                            const SizedBox(
                              height: 2.0,
                            ),
                            Text(
                                details.contact,
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
                                details.surname,
                                style: const TextStyle(
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
                            const Text(
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
                  const SizedBox(
                    height: 8.0,
                  ),
                  doctorPrescriptionCtr.prescriptionReportQrList.value!.details.isEmpty
                      ? const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text("No reports at the moment!"),
                  )
                      : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                    doctorPrescriptionCtr.prescriptionReportQrList.value!.details.length,
                    itemBuilder: (context, index) {
                      var list =  doctorPrescriptionCtr.prescriptionReportQrList.value!.details[index];
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
                              const SizedBox(
                                height: 5,
                              ),
                              custom.text(
                                  "consult with Dr.${list.doctorName}",
                                  12,
                                  FontWeight.w400,
                                  MyColor.primary1),
                            ],
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              image = list.image;
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
                                image: list.image,
                                placeholderFit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        }

      }),
    );
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';

import '../../controller/doctor_list_ctr/DoctorListController.dart';

class ViewCertificateScreen extends StatefulWidget {
  const ViewCertificateScreen({Key? key}) : super(key: key);

  @override
  State<ViewCertificateScreen> createState() => _ViewCertificateScreenState();
}

class _ViewCertificateScreenState extends State<ViewCertificateScreen> {
  DoctorListCtr doctorListCtr = Get.put(DoctorListCtr());
  CustomView customView = CustomView();
  String doc = "";

  @override
  void initState() {
    doc = doctorListCtr.doc.value.toString();
    print("doctor =doc${doctorListCtr.doc.value.toString()}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios, color: Colors.black)),
        backgroundColor: Colors.white24,
        elevation: 0,
        title: const Text(""),
      ),
      body: Obx(() {
        if (doctorListCtr.loadingFetchD.value) {
          return Center(
            child: customView.MyIndicator(),
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InteractiveViewer(
              constrained: true,

              panEnabled: true,
              // Set it to false
              boundaryMargin: const EdgeInsets.all(100),
              minScale: 0.5,
              maxScale: 2,
              child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/loading.gif',
                  alignment: Alignment.center,
                  image: doctorListCtr.doc.value,
                  fit: BoxFit.contain,
                  height: 500,
                  width: double.infinity,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/MEDICAlogo.png',
                      fit: BoxFit.contain,
                    );
                  }),
            ),
          ],
        );
      }),
    );
  }
}

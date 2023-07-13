import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../../language_translator/LanguageTranslate.dart';
import '../../../../controller/auth_controllers/PatientProfileController.dart';

class PatientQRShow extends StatefulWidget {
  const PatientQRShow({Key? key}) : super(key: key);

  @override
  State<PatientQRShow> createState() => _PatientQRShowState();
}

class _PatientQRShowState extends State<PatientQRShow> {
  CustomView custom = CustomView();
  PatientProfileCtr profileCtr = Get.put(PatientProfileCtr());
LocalString text =LocalString();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileCtr.patientProfile(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        title: custom.text(text.qrCode.tr, 17, FontWeight.w500, MyColor.black),
      ),
      body: Obx(() {
        if (profileCtr.loading.value) {
          return Center(
            child: custom.MyIndicator(),
          );
        }
        return Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: FadeInImage.assetNetwork(
                  imageErrorBuilder: (context, error, stackTrace) =>
                      const Image(
                    image: AssetImage("assets/images/noimage.png"),
                  ),
                  width: 80,
                  height: 100,
                  fit: BoxFit.cover,
                  placeholder: "assets/images/loading.gif",
                  image: profileCtr.qrCode.value,
                  placeholderFit: BoxFit.cover,
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}

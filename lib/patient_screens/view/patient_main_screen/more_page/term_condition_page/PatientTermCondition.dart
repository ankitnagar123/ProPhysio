import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../language_translator/LanguageTranslate.dart';

class PatientTermCondition extends StatefulWidget {
  const PatientTermCondition({Key? key}) : super(key: key);

  @override
  State<PatientTermCondition> createState() => _PatientTermConditionState();
}

class _PatientTermConditionState extends State<PatientTermCondition> {
  CustomView custom = CustomView();
  bool loding = true;
  LocalString text = LocalString();

  @override
  void initState() {
    super.initState();
    loding = true;
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
        title: custom.text(text.TermCondition.tr, 17, FontWeight.w500, MyColor.black),
      ),
      body: Stack(
        children: [
          WebView(
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finishd){
              setState(() {
                loding = false;
              });
            },
            initialUrl: "https://sicparvismagna.it/Medica/Apis/terms_conditions.php",zoomEnabled: true,
          ),loding == true ? Center(
            child: custom.MyIndicator(),
          ): const SizedBox(),
        ],
      ),
    );
  }
}

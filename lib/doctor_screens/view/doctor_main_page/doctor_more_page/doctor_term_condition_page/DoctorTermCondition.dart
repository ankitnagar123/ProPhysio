import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../../language_translator/LanguageTranslate.dart';

class DoctorTermCondition extends StatefulWidget {
  const DoctorTermCondition({Key? key}) : super(key: key);

  @override
  State<DoctorTermCondition> createState() => _DoctorTermConditionState();
}

class _DoctorTermConditionState extends State<DoctorTermCondition> {
  CustomView custom = CustomView();
  LocalString text= LocalString();

  bool loding = true;

  @override
  void initState() {
    super.initState();
    loding = true;
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
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
        title: custom.text(
            text.TermCondition.tr, 17, FontWeight.w500, MyColor.black),
      ),
      body: Stack(
        children: [
          WebView(
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finishd) {
              setState(() {
                loding = false;
              });
            },
            initialUrl:
                "https://cisswork.com/Android/Medica/Apis/terms_conditions.php",
            zoomEnabled: true,
          ),
          loding == true
              ? Center(
                  child: custom.MyIndicator(),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

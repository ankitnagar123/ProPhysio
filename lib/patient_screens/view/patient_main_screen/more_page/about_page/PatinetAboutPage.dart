import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import 'package:webview_flutter/webview_flutter.dart';
class PatinetAboutScreen extends StatefulWidget {
  const PatinetAboutScreen({Key? key}) : super(key: key);

  @override
  State<PatinetAboutScreen> createState() => _PatinetAboutScreenState();
}

class _PatinetAboutScreenState extends State<PatinetAboutScreen> {
  CustomView custom = CustomView();
  bool loding = true;

  @override
  void initState() {
    super.initState();
    loding = true;
    // if (Platform.isAndroid) WebView.platform = AndroidWebView();
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
        title: custom.text("About", 17, FontWeight.w500, MyColor.black),
      ),
      body:  Stack(
        children: [
          WebView(
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finishd){
              setState(() {
                loding = false;
              });
            },
            initialUrl: "https://cisswork.com/Android/Medica/Apis/about.php",zoomEnabled: true,
          ),loding == true ? Center(
            child: custom.MyIndicator(),
          ): const SizedBox(),
        ],
      ),
    );
  }
}

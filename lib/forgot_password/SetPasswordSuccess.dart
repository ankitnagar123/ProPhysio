import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Helper/RoutHelper/RoutHelper.dart';
import '../helper/CustomView/CustomView.dart';
import '../helper/mycolor/mycolor.dart';
import '../language_translator/LanguageTranslate.dart';
class SetPasswordSuccess extends StatefulWidget {
  const SetPasswordSuccess({Key? key}) : super(key: key);

  @override
  State<SetPasswordSuccess> createState() => _SetPasswordSuccessState();
}

class _SetPasswordSuccessState extends State<SetPasswordSuccess> {
  CustomView custom = CustomView();
  LocalString text = LocalString();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop:  () async => false,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.all(12),
          child: custom.MyButton(context, text.letGo.tr, () {
            Get.offAllNamed(RouteHelper.getLoginScreen());
          }, MyColor.white,
              const TextStyle(color: MyColor.primary,fontSize: 16,fontFamily: "Poppins",letterSpacing: 0.8))
            ,
        ),
        body: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          decoration:  const BoxDecoration(
            gradient: LinearGradient(
                begin:  Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  MyColor.primary,
                  MyColor.primary1
                ]
            ),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: const AssetImage('assets/images/prologo.png'),
                  height: height*0.2,
                  width: widht*0.6,
                ),
                SizedBox(height: height*0.04,),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Align(
                      alignment: Alignment.center,
                      child: custom.text(text.PasswordChangedSuccess.tr, 17, FontWeight.w500, MyColor.white)),
                ),
                SizedBox(height: height*0.02,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.center,
                  child: custom.text(text.easilylogback.tr, 13, FontWeight.normal, MyColor.white)),
            ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

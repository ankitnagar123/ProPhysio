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
        body: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          decoration:  const BoxDecoration(
            gradient: LinearGradient(
                begin:  Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  MyColor.primary,
                  MyColor.secondary
                ]
            ),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: const AssetImage('assets/images/MEDICAlogo.png'),
                  height: height*0.2,
                  width: widht*0.4,
                ),
                SizedBox(height: height*0.04,),
                Align(
                    alignment: Alignment.center,
                    child: custom.text(text.PasswordChangedSuccess.tr, 20, FontWeight.w500, MyColor.white)),
                SizedBox(height: height*0.02,),
            Align(
              alignment: Alignment.center,
                child: custom.text(text.easilylogback.tr, 13, FontWeight.normal, MyColor.white)),
                custom.MyButton(context, text.letGo.tr, () {
                  Get.offAllNamed(RouteHelper.getLoginScreen());
                }, MyColor.white,
                    const TextStyle(color: MyColor.primary,fontSize: 16,fontFamily: "Poppins",letterSpacing: 0.8))

              ],
            ),
          ),
        ),
      ),
    );
  }
}

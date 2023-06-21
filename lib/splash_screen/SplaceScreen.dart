import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Helper/RoutHelper/RoutHelper.dart';
import '../helper/mycolor/mycolor.dart';
import '../helper/sharedpreference/SharedPrefrenc.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferenceProvider sp = SharedPreferenceProvider();
  bool onBoarding = false;
  bool patientLogin = false;
  bool doctorLogin = false;
  bool centerLogin = false;

  String token = "";
  @override
  void initState() {
    if (GetPlatform.isAndroid) {
      print("isAndroid");
      FirebaseMessaging.instance.getToken().then((value) {
        token = value!;
        sp.setStringValue(sp.FIREBASE_TOKEN_KEY, token);
        print("Firebase Token :-- $token");
      });
      sp.setStringValue(sp.CURRENT_DEVICE_KEY, "Android");
    }
    else if (GetPlatform.isIOS) {
      print("IOS");
      sp.setStringValue(sp.CURRENT_DEVICE_KEY, "IOS");
      FirebaseMessaging.instance.getToken(vapidKey: "").then((value) {
        token = value!;
        sp.setStringValue(sp.FIREBASE_TOKEN_KEY, token);
        print("Firebase Token :-- $token");
      });
    }
    getValue();
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration:  const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  tileMode: TileMode.repeated,
                  stops: [
                    0.1,
                    0.7,
                    0.2,
                  ],
                  colors: [
                    MyColor.secondary,
                    MyColor.primary,
                    MyColor.secondary,
                  ])),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Image(
                  image: AssetImage("assets/images/MEDICAlogo.png"),
                  color: MyColor.white,

                  // image: AssetImage("assets/images/welcome0.png"),
                  height: 150,
                  width: 150,
                ),
              ],
            ),
          ),
        ));
  }

 getValue() async {
   onBoarding = await sp.getBoolValue(sp.ON_BOARDING_KEY) ?? false;
   patientLogin = await sp.getBoolValue(sp.PATIENT_LOGIN_KEY) ?? false;
   doctorLogin = await sp.getBoolValue(sp.DOCTOR_LOGIN_KEY) ?? false;
   centerLogin = await sp.getBoolValue(sp.CENTER_LOGIN_KEY) ?? false;

   print("OnBoarding Key = $onBoarding");
   print("patinetLogin Key = $patientLogin");
   print("doctorLogin Key = $doctorLogin");
   print("CenterLogin Key = $centerLogin");

   Timer(const Duration(seconds: 3), () {
     Get.offNamed(RouteHelper.getOnBoardingScreen());
     if (onBoarding == true) {
       if (patientLogin == true) {
         Get.offNamed(RouteHelper.getBottomNavigation());
       } else if (doctorLogin == true) {
         Get.offNamed(RouteHelper.DHomePage());
       } else if (centerLogin == true) {
         Get.offNamed(RouteHelper.CBottomNavigation());
       } else {
         Get.offNamed(RouteHelper.getLoginScreen());
       }
     } else {
       Get.offNamed(RouteHelper.getOnBoardingScreen());
     }
   });
}
}

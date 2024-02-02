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
    super.initState();
    if (GetPlatform.isAndroid) {
      print("isAndroid");
      FirebaseMessaging.instance.getToken().then((value) {
        token = value!;
        sp.setStringValue(sp.FIREBASE_TOKEN_KEY, token);
        print("Firebase Token :-- $token");

      });
      sp.setStringValue(sp.CURRENT_DEVICE_KEY, "Android");
    } else if (GetPlatform.isIOS) {
      print("IOS");
      sp.setStringValue(sp.CURRENT_DEVICE_KEY, "IOS");
      FirebaseMessaging.instance.getToken(vapidKey: "").then((value) {
        token = value!;
        sp.setStringValue(sp.FIREBASE_TOKEN_KEY, token);
        print("Firebase Token :-- $token");
      });
    }
    getValue();
    // getLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Image(
          image: AssetImage("assets/images/splace_logo.png"),
          fit: BoxFit.fill,
          height: double.infinity,
          width: double.infinity,
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

    Timer(const Duration(seconds: 5), () {
      Get.offNamed(RouteHelper.getOnBoardingScreen());
      if (onBoarding == true) {
        if (patientLogin == true) {
          Get.offNamed(RouteHelper.getBottomNavigation());
        } else if (doctorLogin == true) {
          Get.offNamed(RouteHelper.DHomePage());
        }  else {
          Get.offNamed(RouteHelper.getLoginScreen());
        }
      } else {
        Get.offNamed(RouteHelper.getOnBoardingScreen());
      }
    });
  }

/*
  void getLanguage() async {
    if (await sp.getStringValue(sp.LANGUAGE) == "it") {
      var Itlocal = const Locale('it', 'IT');
      Get.updateLocale(Itlocal);
    } else {
      var enlocal = const Locale('en', 'US');
      Get.updateLocale(enlocal);
    }
  }
*/

}

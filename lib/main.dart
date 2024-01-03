import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:prophysio/ZegoCallService/ZegoCallService.dart';
import 'package:prophysio/helper/AppConst.dart';
import 'package:prophysio/helper/sharedpreference/SharedPrefrenc.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';


import 'Helper/RoutHelper/RoutHelper.dart';
import 'firebase_options.dart';
import 'firebase_service/NotificationService.dart';

import 'language_translator/LanguageTranslate.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
SharedPreferenceProvider sp = SharedPreferenceProvider();
Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.initialize(flutterLocalNotificationsPlugin);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  /// 1.1.2: set navigator key to ZegoUIKitPrebuiltCallInvitationService
  final navigatorKey = GlobalKey<NavigatorState>();

  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
  ZegoUIKit().initLog().then((value) {
    ///  Call the `useSystemCallingUI` method
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );
  });

  runApp( MyApp(navigatorKey: navigatorKey));
}

class MyApp extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const MyApp({super.key, required this.navigatorKey});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String userID = "";
  String drID = "";
  String dName = "";
  String name = "";
  String dSurname = "";
  String surname = "";
  String profile = "";
// CallController callController= CallController();
  void getValue() async {
    userID = (await sp.getStringValue(sp.PATIENT_ID_KEY)).toString();
    name = (await sp.getStringValue(sp.PATIENT_NAME_KEY)).toString();
    surname = (await sp.getStringValue(sp.PATIENT_SURE_NAME_KEY)).toString();
    profile = (await sp.getStringValue(sp.PATIENT_PROFILE)).toString();

    drID = (await sp.getStringValue(sp.DOCTOR_ID_KEY)).toString();
    dName = (await sp.getStringValue(sp.DOCTOR_NAME_KEY)).toString();
    dSurname = (await sp.getStringValue(sp.DOCTOR_SURE_NAME_KEY)).toString();

    log('doctor ID--------$drID');
    log('patient userId--------$userID');


    if(await sp.getStringValue(sp.PATIENT_ID_KEY) != null){
      log('userID START ---');
      log('patient userId--------$userID');
      log(' patient name--------$name');
      log('patient surname--------$surname');
      log('patient profile--------$profile');
      AppConst.Patient_Name = name;
      AppConst.Patinet_Surname = surname;
      AppConst.Patinet_Profile = profile;
      onUserLogin(userID.toString(), "$name $surname","user");
    }else {
      log('drID START ----');
      log('doctor ID--------$drID');
      log('DR name--------$dName');
      log('DR surname--------$dSurname');
      onUserLogin(drID.toString(), "$dName $dSurname","doctor");
    }

  }

  @override
  void initState() {
    getValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: widget.navigatorKey,
      translations: LocalString(),
      locale: const Locale('en', 'US'),
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
              .copyWith(background: Colors.white)),
      debugShowCheckedModeBanner: false,
      title: 'Pro-Physio',
      initialRoute: RouteHelper.getSplashScreen(),
      getPages: RouteHelper.routes,
    );
  }
}

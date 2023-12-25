import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Helper/RoutHelper/RoutHelper.dart';
import '../../Network/ApiService.dart';
import '../../Network/Apis.dart';
import '../../ZegoCallService/ZegoCallService.dart';
import '../../helper/CustomView/CustomView.dart';
import '../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../language_translator/LanguageTranslate.dart';
import '../../network/Internet_connectivity_checker/InternetConnectivity.dart';

class LoginCtr extends GetxController {
  SharedPreferenceProvider sp = SharedPreferenceProvider();
LocalString text =  LocalString();
  CustomView custom = CustomView();
  ApiService apiService = ApiService();
  var loading = false.obs;

  void login(
    BuildContext context,
    String username,
    String password,
  ) async {
    loading.value = true;
    final Map<String, dynamic> LoginPerameter = {
      "username": username,
      "password": password,
    };
    print("Login Parameter$LoginPerameter");
    bool isConnected = await checkInternetConnection();

    if (isConnected) {
      final response = await apiService.postData(MyAPI.Login, LoginPerameter);
      try {
        log("response of Login :-${response.body}");
        loading.value = false;
        var jsonResponse = jsonDecode(response.body);
        String result = jsonResponse['result'].toString();
        String usertype = jsonResponse['user_type'].toString();
        String id = jsonResponse['id'].toString();
        String name = jsonResponse['name'].toString();
        String surname = jsonResponse['surname'].toString();
        // sp.setStringValue(sp.PATIENT_ID_KEY, id);
        if (result == 'Success') {
          sp.setStringValue(sp.USER_TYPE, usertype);
          log("user type $usertype");
          custom.massenger(context, text.Login_successfully.tr);
          if (usertype == "Doctor") {
            loading.value = false;
            sp.setStringValue(sp.DOCTOR_NAME_KEY, name);
            sp.setStringValue(sp.DOCTOR_ID_KEY, id);
            sp.setStringValue(sp.DOCTOR_SURE_NAME_KEY, surname);
            log("Doctor details..............${sp.DOCTOR_NAME_KEY}-----$surname");
            // sp.setStringValue(keyString, valueString)
            sp.setBoolValue(sp.DOCTOR_LOGIN_KEY, true);
            log(sp.DOCTOR_LOGIN_KEY);
            log("${sp.getStringValue(sp.DOCTOR_ID_KEY)}");

             onUserLogin(id.toString(),"${name} ${surname}","doctor");
            log("Doctor login ID${id.toString()}");

            Get.offAndToNamed(RouteHelper.DHomePage());
          } else if (usertype == "User") {
            loading.value = false;
            sp.setStringValue(sp.PATIENT_ID_KEY, id);
            sp.setStringValue(sp.PATIENT_NAME_KEY, name);
            sp.setStringValue(sp.PATIENT_SURE_NAME_KEY, surname);
            sp.setBoolValue(sp.PATIENT_LOGIN_KEY, true);

            log(" Patient login ID -- ${id.toString()}");
             onUserLogin(id.toString(),"${name} ${surname}","user");

            Get.offAndToNamed(RouteHelper.getBottomNavigation());
          }else {
            loading.value = false;
            if(result =="Wait for admin Approve"){
              custom.massenger(context, text.WaitforadminApprove.tr);
            }else{
              custom.massenger(context, text.Invalidemailpassword.tr);
            }
          }
        } else {
          if(result =="Wait for admin Approve"){
            custom.massenger(context, text.WaitforadminApprove.tr);

          }else{
            custom.massenger(context, text.Invalidemailpassword.tr);

          }
          loading.value = false;
        }
      } catch (e) {
        custom.massenger(context, text.SomthingWentWrong.tr);
        loading.value = false;
        log("exception$e");
      }
    } else {
      loading.value = false;
      custom.MySnackBar(context, text.CheckInternetconnection.tr);
    }
  }


  /*----------Update Device  API-----------*/
  void updateToken(
      BuildContext context,
      String id,
      String userTyp,
      String deviceID,
      String deviceTyp,
      ) async {
    final Map<String,dynamic>UpdatePerameter = {
      "user_id": id,
      "device_id": deviceID,
      "device_status": deviceTyp,
      "user_type": userTyp,
    };
    log(" Update Parameter$UpdatePerameter");

    final response =
    await apiService.postData(MyAPI.updateToken,UpdatePerameter);
    try {
      log("response of Device Update:-${response.body}");

      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      if (response.statusCode == 200) {
      } else {
        log("error");
      }
    } catch (e) {
      log("exception$e");
    }
  }
}
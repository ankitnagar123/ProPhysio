import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../Network/ApiService.dart';
import '../../../Network/Apis.dart';
import '../../../helper/CustomView/CustomView.dart';
import '../../../helper/sharedpreference/SharedPrefrenc.dart';

class PatientFilterCtr extends GetxController {
  CustomView custom = CustomView();
  ApiService apiService = ApiService();
  var loading = false.obs;
  var loadingU = false.obs;

  var lables = "".obs;
  var address = "".obs;
  var caps = "".obs;
  var lat = "".obs;
  var long = "".obs;

  SharedPreferenceProvider sp = SharedPreferenceProvider();

/*----------Fetch Patient API-----------*/
  void setLocation(BuildContext context, String lable, String cap,
      String location, String latitude, String longitude) async {
    loading.value = true;
    final Map<String, dynamic> ProfilePerameter = {
      "user_id": await sp.getStringValue(sp.PATIENT_ID_KEY),
      "label": lable,
      "cap": cap,
      "location": location,
      "latitude": latitude,
      "longitude": longitude,
    };
    print("Patient setLocation Parameter$ProfilePerameter");

    final response =
        await apiService.postData(MyAPI.pSetLocation, ProfilePerameter);
    try {
      log("response of Patient setLocation :-${response.body}");
      log("my id ${sp.PATIENT_ID_KEY}");
      loading.value = false;
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        String result = jsonResponse['result'];
        print(result);
        String label = jsonResponse["label"];
        sp.setStringValue(sp.FILTER_LABLE, label);
        String address = jsonResponse["location"];
        sp.setStringValue(sp.FILTER_LOCATION, address);
        String cap = jsonResponse["cap"];
        sp.setStringValue(sp.FILTER_CAP, cap);
        String lat = jsonResponse["latitude"];
        sp.setStringValue(sp.FILTER_LAT, lat);
        String long = jsonResponse["longitude"];
        sp.setStringValue(sp.FILTER_LONG, long);
      } else {
        loading.value = false;
        custom.massenger(context, "Invalid");
      }
    } catch (e) {
      loading.value = false;
      log("exception$e");
    }
  }

/*----------Update Patient API-----------*/
/*  void patientProfileUpdate(
    BuildContext context,
    String name,
    String surname,
    String username,
    String email,
    String helathcard,
    String address,
    String phone,
    String code,
    String image,
    String baseimage,
  ) async {
    loadingU.value = true;
    final Map<String, dynamic> profileUpdatePerameter = {
      "user_id": await sp.getStringValue(sp.PATIENT_ID_KEY),
      "name": name,
      "surname": surname,
      "username": username,
      "health_card": helathcard,
      "email": email,
      "contact": phone,
      "code": code,
      // "password": password,
      "location": address,
      "image": image,
      "img_str": baseimage,
    };
    print("Patient Profile Update Parameter$profileUpdatePerameter");

    final response =
        await apiService.postData(MyAPI.PUpdateProfile, profileUpdatePerameter);
    try {
      log("response of Paitent Profile Update :-${response.body}");
      loadingU.value = false;
      var jsonResponse = jsonDecode(response.body);
      String result = jsonResponse['result'];
      if (result == 'Success') {
        // callback();
        patientProfile(context);
        custom.massenger(context, 'Profile Update Successfully');
      } else {
        loadingU.value = false;
        custom.massenger(context, "Invalid Inputs");
      }
    } catch (e) {
      loadingU.value = false;
      log("excaption$e");
    }
  }*/
}

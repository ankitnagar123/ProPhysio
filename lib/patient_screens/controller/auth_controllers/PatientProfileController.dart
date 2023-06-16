import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';

import '../../../Network/ApiService.dart';
import '../../../Network/Apis.dart';
import '../../../helper/sharedpreference/SharedPrefrenc.dart';

class PatientProfileCtr extends GetxController {
  CustomView custom = CustomView();
  ApiService apiService = ApiService();
  var loading = false.obs;
  var loadingU = false.obs;

  var visible = false.obs;
  var edittext = false.obs;

  var username = "".obs;
  var name = "".obs;
  var surename = "".obs;
  var healthCard = "".obs;
  var Email = "".obs;
  var phone = "".obs;
  var code = "".obs;
  var Password = "".obs;
  var address = "".obs;
  var image = "".obs;
  var gender = "".obs;

  /*--new filed added--*/

  var age = "".obs;
  var height = "".obs;
  var weight = "".obs;
  var taxCode = "".obs;
  var birthplace = "".obs;
  var qrCode = "".obs;
  var flag = "".obs;

  SharedPreferenceProvider sp = SharedPreferenceProvider();


/*----------Fetch Patient API-----------*/
  void patientProfile(BuildContext context) async {
    loading.value = true;
    final Map<String, dynamic> ProfilePerameter = {
      "user_id": await sp.getStringValue(sp.PATIENT_ID_KEY),
    };
    print("Patient Login Parameter$ProfilePerameter");

    final response = await apiService.postData(
        MyAPI.PFetchProfile, ProfilePerameter);
    try {
      log("response of Patient Profile :-${response.body}");
      log("my id ${sp.PATIENT_ID_KEY}");
      loading.value = false;
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        String result = jsonResponse['result'];
        name.value = jsonResponse["name"];
        gender.value = jsonResponse["gender"];
        log(name.value);
        surename.value = jsonResponse["surname"];
        username.value = jsonResponse["username"];
        healthCard.value = jsonResponse["health_card"];
        image.value = jsonResponse["user_profile"];
        qrCode.value = jsonResponse["QR_Code"];
        flag.value = jsonResponse["flag"];


        log(healthCard.value);
        Email.value = jsonResponse["email"];
        phone.value = jsonResponse["contact"];
        code.value = jsonResponse["code"];
        Password.value = jsonResponse["password"];
        address.value = jsonResponse["location"];

        /*--new filed added--*/
        age.value = jsonResponse["age"];
        weight.value = jsonResponse["weight"];
        height.value = jsonResponse["height"];
        birthplace.value = jsonResponse["birth_place"];
        taxCode.value = jsonResponse["tax_code"];


        // Massenger(context, 'My Profile');
      } else {
        loading.value = false;
        custom.massenger(context, "Invalid");
      }
    } catch (e) {
      loading.value = false;
      log("excaption$e");
    }
  }

/*----------Update Patient API-----------*/
  void patientProfileUpdate(BuildContext context, String name, String surname,
      String username, String email,
      String helathcard,
      String address,
      String phone, String code, String flg,String image,
      String baseimage, String gender, String lat, String long, String age,
      String weight, String height, String birthplace, String taxcode,
      VoidCallback callback) async {
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
      "flag":flg,
      // "password": password,
      "location": address,
      "image": image,
      "img_str": baseimage,
      "gender": gender,
      "latitude": lat,
      "longitude": long,
      "age":age,
      "weight":weight,
      "height":height,
      "birth_place":birthplace,
      "tax_code":taxcode,


    };
    print("Patient Profile Update Parameter$profileUpdatePerameter");

    final response = await apiService.postData(
        MyAPI.PUpdateProfile, profileUpdatePerameter);
    try {
      log("response of Paitent Profile Update :-${response.body}");
      loadingU.value = false;
      var jsonResponse = jsonDecode(response.body);
      String result = jsonResponse['result'];
      if (result == 'Success') {
        callback();
        patientProfile(context);
        // custom.massenger(context, 'Profile Update Successfully');
        print("success profile update patient");
      } else {
        loadingU.value = false;
        custom.massenger(context, "Invalid Inputs");
      }
    } catch (e) {
      loadingU.value = false;
      log("excaption$e");
    }
  }
}

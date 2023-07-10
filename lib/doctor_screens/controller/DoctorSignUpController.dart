import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';

import '../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../../network/ApiService.dart';
import '../../../network/Apis.dart';
import '../../Helper/RoutHelper/RoutHelper.dart';
import '../model/DSignUpCategoryModel.dart';

class DoctorSignUpCtr extends GetxController {
  CustomView custom = CustomView();
  ApiService apiService = ApiService();

  RxString location = "".obs;

  var loading = false.obs;
  var loadingotp = false.obs;

  var categoryloding = false.obs;
  var otp = ''.obs;
  var result = ''.obs;
  SharedPreferenceProvider sp = SharedPreferenceProvider();

  var category = <AllCategoryModel>[].obs;

  /*---------Doctor All Category --------*/
  Future<void> DoctorCategory() async {
    try {
      categoryloding.value = true;
      final response = await apiService.getData(MyAPI.DCategorySignUp);
      print(" Category =============${response.body}");
      if (response.statusCode == 200) {
        categoryloding.value = false;
        category.value = allCategoryModelFromJson(response.body.toString());
        log(category.toString());
      } else {
        categoryloding.value = false;
        log("error");
      }
    } catch (e) {
      categoryloding.value = false;
      log("exception$e");
    }
  }

/*-----------Doctor SignUp Otp Api----------*/
  Future<String> doctorSignupOtp(
    BuildContext context,
    String email,
    // VoidCallback callback,
  ) async {
    loadingotp.value = true;
    final Map<String, dynamic> signupPerameter = {
      "email": email,
    };
    print("SignupParameter$signupPerameter");

    final response =
        await apiService.postData(MyAPI.DSignUpOtp, signupPerameter);
    try {
      log("response of Doctor Signup OTP :-${response.body}");
      loadingotp.value = false;
      var jsonResponse = jsonDecode(response.body);
      otp.value = jsonResponse['otp'].toString();

      var result = jsonResponse['result'].toString();
      if (response.statusCode == 200) {
        // callback();
        log("my otp ctr${otp.toString()}");
        custom.massenger(context, otp.toString());
        loadingotp.value = false;
        print(result.toString());
        return jsonResponse['otp'].toString();
      } else {
        custom.massenger(context, result.toString());
      }
    } catch (e) {
      loadingotp.value = false;

      log("exception$e");
      return '';
    }
    return '';
  }

  /*-----------Doctor SignUp Main Api----------*/
  void doctorSignup(
      BuildContext context,
      String name,
      String surnName,
      String username,
      String email,
      String countryCode,
      String mobileNo,
      String flag,
      String password,
      String category,
      String imgString,
      String imgBase,
      String address,
      String lat,
      String lang,
      String subcat,
      String birthDate,
      String birthPlace,
      String universityAttended,
      String enrollmentDate,
      String registerOfBelonging,
      String gender,
      String graducationDate,
      String qualificationDate,
      VoidCallback callback) async {
    loading.value = true;
    final Map<String, dynamic> signupPerameter = {
      "name": name,
      "surname": surnName,
      "username": username,
      "email": email,
      "code": countryCode,
      "contact": mobileNo,
      "flag":flag,
      "password": password,
      "doc_pdf": imgString,
      "docimg_str": imgBase,
      "location": address,
      "category": category,
      "latitude": lat,
      "longitude": lang,
      "subcategory": subcat,
      "birth_date":birthDate,
      "birth_place":birthPlace,
      "university_attended":universityAttended,
      "enrollment_date":enrollmentDate,
      "register_of_belonging":registerOfBelonging,
      "gender":gender,
      "graduation_date":graducationDate,
      "qualification_date":qualificationDate,
    };
    print("Signup Parameter$signupPerameter");
    print(gender);

     final response = await apiService.postData(MyAPI.DSignUp, signupPerameter);
    try {
       log("response of Doctor Signup :-${response.body}");
      loading.value = false;
      var jsonResponse = jsonDecode(response.body);
       String result = jsonResponse['result'];
      if (result == "Success") {
        callback();
        loading.value = false;
         sp.setBoolValue(sp.PATIENT_LOGIN_KEY, true);
         Get.toNamed(RouteHelper.getVerification());
         custom.massenger(context, result);
      } else {
        custom.massenger(context, result);
      }
    } catch (e) {
      log("exception$e");
    }
  }
}

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import '../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../../network/ApiService.dart';
import '../../../network/Apis.dart';

class PatientSignUpCtr extends GetxController {
  CustomView custom = CustomView();
  ApiService apiService = ApiService();
  var loading = false.obs;
  var loadingotp = false.obs;
  var otp = ''.obs;
  var result = ''.obs;
  SharedPreferenceProvider sp = SharedPreferenceProvider();


/*-----------Patient SignUp Otp Api----------*/
  Future<String> PatientSignupOtp(
      BuildContext context,
      String email,
      // VoidCallback callback,
      ) async {
    loadingotp.value = true;
    final Map<String, dynamic> signupPerameter = {
      "email": email,
    };
    print("SignupPerameter$signupPerameter");

    final response =
    await apiService.postData(MyAPI.PSignUpOtp, signupPerameter);
    try {
      log("response of Paitent Signup OTP :-${response.body}");
      loadingotp.value = false;
      var jsonResponse = jsonDecode(response.body);
      otp.value = jsonResponse['otp'].toString();

      // var result = jsonResponse['result'].toString();
      if (response.statusCode == 200) {
        // callback();
        print("my otp ctr${otp.toString()}");
        custom.massenger(context, otp.toString());
        loadingotp.value = false;

        print(result.toString());
        return jsonResponse['otp'].toString();
      } else{
        custom.massenger(context, result.toString());
      }
    } catch (e) {
      log("exception$e");
      return '';
    }
    return '';
  }

  void patientSignup(
      BuildContext context,
      String name,
      String surname,
      String username,
      String email,
      String countrycode,
      String mobileNo,
      String password,
      String healthCard,
      String age,
      String weight,
      String birthplace,
      String height,
      String taxCode,
      String gender,
      VoidCallback callback) async {
    loading.value = true;
    final Map<String, dynamic> signupPerameter = {
      "name":name,
      "surname":surname,
      "username": username,
      "email": email,
      "code": countrycode,
      "contact": mobileNo,
      "password": password,
      "health_card":healthCard,
      "age":age,
      "weight":weight,
      "birth_place":birthplace,
      "height":height,
      "tax_code":taxCode,
      "gender":gender,
    };
    print("SignupPerameter$signupPerameter");

    final response = await apiService.postData("https://cisswork.com/Android/Medica/Apis/a.php", signupPerameter);
    try {
      log("response of Paitent Signup :-${response.body}");
      loading.value = false;
      var jsonResponse = jsonDecode(response.body);
      String result = jsonResponse['result'];
      if (result == "Success") {
        callback();
        loading.value = false;
        // sp.setBoolValue(sp.PATIENT_LOGIN_KEY, true);
        // Get.toNamed(RouteHelper.getVerification());
        custom.massenger(context, result);
      }else{
        custom.massenger(context, result);
      }
    } catch (e) {
      log("excaption$e");
    }
  }


}

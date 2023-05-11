import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import '../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../../network/ApiService.dart';
import '../../../network/Apis.dart';

class CenterAuthCtr extends GetxController {
  CustomView custom = CustomView();
  ApiService apiService = ApiService();
  var loading = false.obs;
  var loadingotp = false.obs;
  var otp = ''.obs;
  var result = ''.obs;
  SharedPreferenceProvider sp = SharedPreferenceProvider();


/*-----------Patient SignUp Otp Api----------*/
  Future<String> CenterSignupOtp(
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
    await apiService.postData(MyAPI.CSignUpOtp, signupPerameter);
    try {
      log("response of Medical Center Signup OTP :-${response.body}");
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

  void centerSignup(
      BuildContext context,
      String name,
      String email,
      String password,
    String address,
      VoidCallback callback) async {
    loading.value = true;
    final Map<String, dynamic> signupPerameter = {
      "name":name,
      "email": email,
      "address": address,
      "password":password,
    };
    print("SignupPerameter for medical center$signupPerameter");

    final response = await apiService.postData(MyAPI.CSignUp, signupPerameter);
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

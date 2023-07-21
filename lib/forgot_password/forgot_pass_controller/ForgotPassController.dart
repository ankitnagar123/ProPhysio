import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';

import '../../Network/ApiService.dart';
import '../../Network/Apis.dart';

class ForgotPassCtr extends GetxController {
  CustomView custom =CustomView();
  ApiService apiService = ApiService();
  var loadingotp = false.obs;
  var loadingset = false.obs;
  var otp = "".obs;
  var id = "".obs;

  /*-------------Forgot Password Verification  OTP--------------*/
  Future<String> forgotPasswordVerification(
      BuildContext context,
      String countryCode,String phone,
       VoidCallback callback
      ) async {
    loadingotp.value = true;
    final Map<String, dynamic> pforgot = {
      "country_code":countryCode,
      "contact":phone,
      // "email": email,
    };
    print("Forgot Perameter$pforgot");

    final response = await apiService.postData(MyAPI.forgotPassword, pforgot);
    try {
      log("response forgot OTP :-${response.body}");
      loadingotp.value = false;
      var jsonResponse = jsonDecode(response.body);
      otp.value = jsonResponse['otp'].toString();
      id.value = jsonResponse['id'].toString();
      var result = jsonResponse['result'].toString();
      if (result == 'success') {
        // callback();
        print("my otp ctr${otp.toString()}");
        custom.massenger(context, otp.toString());
        loadingotp.value = false;

        print(result.toString());
        return jsonResponse['otp'].toString();
      } else {
        custom.massenger(context, "Invalid Email");
      }
    } catch (e) {
      log("exception$e");
      return '';
    }
    return '';
  }

  /*-------------Forgot Password OTP--------------*/
  Future<String> forgotPassword(
      BuildContext context,
      String email,
      // VoidCallback callback
      ) async {
    loadingotp.value = true;
    final Map<String, dynamic> pforgot = {
   /*   "user_type":"Medical",
      "country_code":countryCode,
      "contact":phone,*/
      "email": email,
    };
    print("Forgot Perameter$pforgot");

    final response = await apiService.postData(MyAPI.forgotPassword, pforgot);
    try {
      log("response forgot OTP :-${response.body}");
      loadingotp.value = false;
      var jsonResponse = jsonDecode(response.body);
      otp.value = jsonResponse['otp'].toString();
      id.value = jsonResponse['id'].toString();
      var result = jsonResponse['result'].toString();
      if (result == 'success') {
        // callback();
        print("my otp ctr${otp.toString()}");
        custom.massenger(context, otp.toString());
        loadingotp.value = false;

        print(result.toString());
        return jsonResponse['otp'].toString();
      } else {
        custom.massenger(context, "Invalid Email");
      }
    } catch (e) {
      log("exception$e");
      return '';
    }
    return '';
  }



  /*-------------Set New Password--------------*/
  Future setPassword(BuildContext context, String id, String newpassword,
      String confimpass, VoidCallback callback) async {
    loadingset.value = true;
    final Map<String, dynamic> pSetPass = {
      "id": id,
      "newpassword": newpassword,
      "confirmpassword":confimpass,
    };
    print("Set new password Parameter$pSetPass");

    final response = await apiService.postData(MyAPI.setNewPassword,pSetPass);
    try {
      log("response of Patient new set password :-${response.body}");
      var jsonResponse = jsonDecode(response.body);
      var result = jsonResponse['result'].toString();
      loadingset.value = false;

      if (result == "Success") {
        loadingset.value = false;
        print("my patient set pass$result");
        custom.massenger(context, result.toString());
        print(result.toString());
        callback();
      } else {
        custom.massenger(context, "Invalid Inputs");
      }
    } catch (e) {
      loadingset.value = false;
      log("exception$e");
    }
  }
}

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import '../../Helper/RoutHelper/RoutHelper.dart';
import '../../Network/ApiService.dart';
import '../../Network/Apis.dart';
import '../../helper/CustomView/CustomView.dart';
import '../../language_translator/LanguageTranslate.dart';

class ForgotPassCtr extends GetxController {
  CustomView custom =CustomView();
  ApiService apiService = ApiService();
  LocalString text = LocalString();
  var loadingotp = false.obs;
  var loadingset = false.obs;
  var otp = "".obs;
  var ID = "".obs;
  var userTyp = "".obs;
  var result = ''.obs;

  /*-------------Forgot Password Verification  OTP--------------*/
  Future<String> forgotPasswordVerification(
      BuildContext context,
      String countryCode,String phone,String email,
       VoidCallback callback,
      ) async {
    loadingotp.value = true;
    final Map<String, dynamic> pforgot = {
      "country_code":countryCode,
      "contact":phone,
       "email": email,
      // "user_type":userType
    };
    print("Forgot Perameter$pforgot");

    final response = await apiService.postData(MyAPI.forgotPassword, pforgot);
    try {
      log("response forgot OTP :-${response.body}");
      loadingotp.value = false;
      var jsonResponse = jsonDecode(response.body);
      otp.value = jsonResponse['otp'].toString();
      var result = jsonResponse['result'].toString();
      if (result == 'success') {
         userTyp.value = jsonResponse["user_type"].toString();
         ID.value = jsonResponse['id'].toString();
         print("usertype${userTyp.value}");
        print("my otp ctr${otp.toString()}");
         // callback();
         var id = {"code":countryCode,"phone":phone,"userType": userTyp.value,"id":ID.value};
         Get.toNamed(RouteHelper.getVerification(),parameters: id);
         loadingotp.value = false;

        print(result.toString());
        return jsonResponse['otp'].toString();
      } else {
        custom.massenger(context, text.Invalid);
      }
    } catch (e) {
      log("exception$e");
      return '';
    }
    return '';
  }


   Future<String> forgotPassOtp(
    BuildContext context,
      String countryCode,
      String phone,
      String email,
    String userTyp
    // VoidCallback callback,
  ) async {
    loadingotp.value = true;
    final Map<String, dynamic> signupPerameter = {
      "user_type":userTyp,
      "country_code":countryCode,
      "contact":phone,
      "email": email,
    };
    print("Signup Parameter$signupPerameter");
    final response = await http.post(
        Uri.parse(
            MyAPI.send_otp_twiliosms,
        ),
        body: signupPerameter);
/*    final response =
        await apiService.postData(MyAPI.CSignUpOtp, signupPerameter);*/
    print("parameter  for medical center$signupPerameter");
    try {
      log("response of Medical Center Signup OTP :-${response.body}");
      loadingotp.value = false;
      var jsonResponse = jsonDecode(response.body);
      otp.value = jsonResponse['otp'].toString();
      if (response.statusCode == 200) {
        print("my otp ctr${otp.toString()}");
        // custom.massenger(context, otp.toString());
        loadingotp.value = false;

        print(result.toString());
        return jsonResponse['otp'].toString();
      } else {
        custom.massenger(context, text.SomthingWentWrong.tr);
      }
    } catch (e) {
      custom.massenger(context, text.SomthingWentWrong.tr);
      log("exception$e");
      return '';
    }
    return '';
  }
/*  *//*-------------Forgot Password OTP--------------*//*
  Future<String> forgotPassword(
      BuildContext context,
      String email,
      // VoidCallback callback
      ) async {
    loadingotp.value = true;
    final Map<String, dynamic> pforgot = {
   *//*   "user_type":"Medical",
      "country_code":countryCode,
      "contact":phone,*//*
      "email": email,
    };
    print("Forgot Parameter$pforgot");

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
  }*/



  /*-------------Set New Password--------------*/
  Future setPassword(BuildContext context, String id, String newpassword,
      String confimpass,String userType, VoidCallback callback) async {
    loadingset.value = true;
    final Map<String, dynamic> pSetPass = {
      "id": id,
      "newpassword": newpassword,
      "confirmpassword":confimpass,
      "user_type":userType
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

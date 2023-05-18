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
  var loadingP = false.obs;
  var loadingPass = false.obs;


  var name = "".obs;
  var location = "".obs;
  var Email = "".obs;
  var bio = "".obs;
  var password = "".obs;
  var image = "".obs;

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


/*----------Fetch Doctor Profile Data API-----------*/
  void centerProfile(BuildContext context) async {
    loadingP.value = true;
    final Map<String, dynamic> ProfilePerameter = {
      "center_id": await sp.getStringValue(sp.CENTER_ID_KEY),
    };
    print("Doctor Profile Parameter$ProfilePerameter");

    final response = await apiService.postData(MyAPI.cCenterProfile, ProfilePerameter);
    try {
      log("response of Doctor Profile :-${response.body}");
      log("my id $ProfilePerameter");

      loadingP.value = false;
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        String result = jsonResponse['result'];
        String biography = jsonResponse['biography'];
        var bios = biography.toString();
        bio.value = bios;
        print("bio======>$bios");
        print("my doctor profile====${result.toString()}");
        name.value = jsonResponse["name"];
        Email.value = jsonResponse["email"];
        password.value = jsonResponse['password'];
        location.value = jsonResponse["address"];
        image.value = jsonResponse["image"];

      } else {
        loadingP.value = false;
        custom.massenger(context, "Something went wrong");
      }
    } catch (e) {
      loadingP.value = false;
      log("exception$e");
    }
  }


/*-------------Center Change Password--------------*/
  Future centerPasswordChange(BuildContext context, String oldpass,
      String newpass, String confirmpass, VoidCallback callback) async {
    loadingPass.value = true;
    final Map<String, dynamic> psetpass = {
      "center_id": await sp.getStringValue(sp.CENTER_ID_KEY),
      "old_pass": oldpass,
      "new_pass": newpass,
      "confirm_pass": confirmpass
    };
    print("Change new password Parameter$psetpass");
    final response = await apiService.postData(MyAPI.cChangePassword, psetpass);
    try {
      log("response of Center new Change password :-${response.body}");
      var jsonResponse = jsonDecode(response.body);
      var result = jsonResponse['result'].toString();
      loadingPass.value = false;
      if (result == "Changed Successfull") {
        loadingPass.value = false;
        print("my Doctor set pass$result");
        custom.massenger(context, result.toString());
        print(result.toString());
        callback();
      } else {
        custom.massenger(context, "Password doesn't match");
      }
    } catch (e) {
      loadingPass.value = false;
      log("exception$e");
    }
  }
}

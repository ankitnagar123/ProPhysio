import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';

import '../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../../network/ApiService.dart';
import '../../../network/Apis.dart';
import '../../language_translator/LanguageTranslate.dart';

class CenterAuthCtr extends GetxController {
  CustomView custom = CustomView();
  LocalString text = LocalString();

  ApiService apiService = ApiService();
  var loading = false.obs;
  var loadingotp = false.obs;
  var otp = ''.obs;
  var msg = ''.obs;

  var result = ''.obs;
  var loadingP = false.obs;
  var loadingUpdateP = false.obs;
  var loadingDetails = false.obs;
  var resultVar = RxnInt(0);

  var loadingPass = false.obs;
  var loadingDelete = false.obs;
  var loadingSupport = false.obs;

  var name = "".obs;
  var location = "".obs;
  var lat = "".obs;
  var long = "".obs;

  var Email = "".obs;
  var bio = "".obs;
  var password = "".obs;
  var image = "".obs;


  SharedPreferenceProvider sp = SharedPreferenceProvider();


  /*-----------Center SignUp Otp Verification Api----------*/
  Future<String> CenterSignupOtpVerification(
      BuildContext context,
      String countryCode,
      String phone,
      String email,
       VoidCallback callback,
      ) async {
    loadingotp.value = true;
    final Map<String, dynamic> signupPerameter = {
      "country_code":countryCode,
      "contact":phone,
      "email": email,
    };
    print("Signup verification Parameter$signupPerameter");
    final response =
        await apiService.postData(MyAPI.CSignUpOtp, signupPerameter);
    try {
      log("response of Medical Center Signup OTP :-${response.body}");
      loadingotp.value = false;
      var jsonResponse = jsonDecode(response.body);
      otp.value = jsonResponse['otp'].toString();
      msg.value = jsonResponse['msg'].toString();
      var result = jsonResponse['result'].toString();

      if (response.statusCode == 200) {
        loadingotp.value = false;
        if(msg.value == "true"){
          callback();
          print("my otp ctr${otp.toString()}");
        }else{
          print(result.toString());
          custom.massenger(context, result.toString());
          return jsonResponse['otp'].toString();
        }
        // custom.massenger(context, otp.toString());

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


/*-----------Center SignUp Otp Api----------*/
  Future<String> CenterSignupOtp(
    BuildContext context,
      String countryCode,
      String phone,
      String email,
    // VoidCallback callback,
  ) async {
    loadingotp.value = true;
    final Map<String, dynamic> signupPerameter = {
      "user_type":"Medical",
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
    print("parameter  for medical center${signupPerameter}");
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

  void centerSignup(
      BuildContext context,
      String flag,
      String code,
      String phone,
      String name,
      String email,
      String password,
      String address,
      String lat,
      String long,
      VoidCallback callback) async {
    loading.value = true;
    final Map<String, dynamic> signupPerameter = {
      "flag":flag,
      "code":code,
      "contact":phone,
      "name": name,
      "email": email,
      "address": address,
      "password": password,
      "latitude": lat,
      "longitude": long
    };
    print("SignupPerameter for medical center$signupPerameter");

    final response = await apiService.postData(MyAPI.CSignUp, signupPerameter);
    try {
      log("response of Patient Signup :-${response.body}");
      loading.value = false;
      var jsonResponse = jsonDecode(response.body);
      String result = jsonResponse['result'];
      if (result == "Success") {
        callback();
        loading.value = false;
        custom.massenger(context, "Sign up successfully");
      } else {
        custom.massenger(context, result);
      }
    } catch (e) {
      log("exception$e");
    }
  }

/*----------Fetch Doctor Profile Data API-----------*/
  void centerProfile(BuildContext context) async {
    loadingP.value = true;
    resultVar.value = 0;
    final Map<String, dynamic> ProfilePerameter = {
      "center_id": await sp.getStringValue(sp.CENTER_ID_KEY),
    };
    print("Doctor Profile Parameter$ProfilePerameter");

    final response =
        await apiService.postData(MyAPI.cCenterProfile, ProfilePerameter);
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
        lat.value = jsonResponse["latitude"];
        long.value = jsonResponse["longitude"];
        image.value = jsonResponse["image"];
        resultVar.value = 1;
      } else {
        loadingP.value = false;
        custom.massenger(context, "Something went wrong");
        resultVar.value = 2;
      }
    } catch (e) {
      loadingP.value = false;
      resultVar.value = 2;
      log("exception$e");
    }
  }


/*----------Update CENTER Profile API-----------*/
  void centerProfileUpdate(BuildContext context,
      String name,
      String bio,
      String email,
      String address,
      String lat,
      String long,
      String image,
      String baseImage,
      VoidCallback callback,
      ) async {
    loadingUpdateP.value = true;
    final Map<String, dynamic> profileUpdatePerameter = {
      "center_id": await sp.getStringValue(sp.CENTER_ID_KEY),
      "name": name,
      "email": email,
      "biography":bio,
      "address":address,
      "latitude":lat,
      "longitude":long,
      "image":image,
      "img_str":baseImage,
    };
    print("Center Profile Update Parameter$profileUpdatePerameter");

    final response = await apiService.postData(MyAPI.cCenterProfileUpdate, profileUpdatePerameter);
    try {
      log("response of Center Profile Update :-${response.body}");
      loadingUpdateP.value = false;
      var jsonResponse = jsonDecode(response.body);
      String result = jsonResponse['result'];
      if (result == 'Success') {
        callback();
        centerProfile(context);
        custom.massenger(context, "Profile update successfully");
      } else {
        loadingUpdateP.value = false;
        custom.massenger(context, "Invalid inputs");
      }
    } catch (e) {
      loadingUpdateP.value = false;
      log("exception$e");
    }
  }


  void centerDetails(BuildContext context, String id) async {
    loadingDetails.value = true;
    final Map<String, dynamic> ProfilePerameter = {
      "center_id": id,
    };
    print("Doctor Profile Parameter$ProfilePerameter");

    final response =
        await apiService.postData(MyAPI.cCenterProfile, ProfilePerameter);
    try {
      log("response of Doctor Profile :-${response.body}");
      log("my id $ProfilePerameter");

      loadingDetails.value = false;
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
        loadingDetails.value = false;
        custom.massenger(context, "Something went wrong");
      }
    } catch (e) {
      loadingDetails.value = false;
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

  /*-------------Center Change Password--------------*/
  Future centerDeleteAc(
      BuildContext context, String password, VoidCallback callback) async {
    loadingDelete.value = true;
    final Map<String, dynamic> psetpass = {
      "center_id": await sp.getStringValue(sp.CENTER_ID_KEY),
      "password": password,
    };
    print("Center delete Parameter$psetpass");
    final response = await apiService.postData(MyAPI.cCenterDeleteAc, psetpass);
    try {
      log("response of Center delete:-${response.body}");
      var jsonResponse = jsonDecode(response.body);
      var result = jsonResponse['result'].toString();
      loadingDelete.value = false;
      if (result == "success") {
        callback();
        loadingDelete.value = false;
        print("Center delete$result");
        custom.massenger(context, "Account delete successfully");
        print(result.toString());
      } else {
        custom.massenger(context, "Something went wrong");
      }
    } catch (e) {
      loadingDelete.value = false;
      log("exception$e");
    }
  }

  /*-------------Center Change Password--------------*/
  Future centerSupport(BuildContext context, String subject, String email,
      String msg, VoidCallback callback) async {
    loadingSupport.value = true;
    final Map<String, dynamic> psetpass = {
      "center_id": await sp.getStringValue(sp.CENTER_ID_KEY),
      "subject": subject,
      "email": email,
      "message": msg,
    };
    print("Center support Parameter$psetpass");
    final response = await apiService.postData(MyAPI.cCenterSupport, psetpass);
    try {
      log("response of Center Support:-${response.body}");
      var jsonResponse = jsonDecode(response.body);
      var result = jsonResponse['result'].toString();
      if (result == "success") {
        callback();
        loadingSupport.value = false;
        print("Support delete$result");
        custom.massenger(context, "Successfully send message");
        print(result.toString());
      } else {
        custom.massenger(context, "Something went wrong");
      }
    } catch (e) {
      loadingSupport.value = false;
      log("exception$e");
    }
  }
}

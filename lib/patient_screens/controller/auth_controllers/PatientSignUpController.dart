import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import '../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../../language_translator/LanguageTranslate.dart';
import '../../../network/ApiService.dart';
import '../../../network/Apis.dart';
import 'package:http/http.dart' as http;

class PatientSignUpCtr extends GetxController {
  CustomView custom = CustomView();
  ApiService apiService = ApiService();
  LocalString text = LocalString();
  var loading = false.obs;
  var loadingotp = false.obs;
  var otp = ''.obs;
  var msg = ''.obs;

  var result = ''.obs;
  SharedPreferenceProvider sp = SharedPreferenceProvider();



  /*-----------Patient SignUp Otp Verification Api----------*/
  Future<String> PatientSignupOtpVerification(
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

    print("SignupPerameter$signupPerameter");
    final response =  await apiService.postData(MyAPI.PSignUpOtp, signupPerameter);
    try {
      log("response of Patient verification Signup OTP :-${response.body}");
      loadingotp.value = false;
      var jsonResponse = jsonDecode(response.body);
      otp.value = jsonResponse['otp'].toString();
      msg.value = jsonResponse['msg'].toString();

      var result = jsonResponse['result'].toString();
      if (response.statusCode == 200) {
        if(msg.value == "true"){
          callback();
          print("my otp ctr${otp.toString()}");

        }else{
          loadingotp.value = false;
          custom.massenger(context, result.toString());
          print(result.toString());
          return jsonResponse['otp'].toString();
        }

      } else {
        custom.massenger(context,  text.SomthingWentWrong.tr);
      }
    } catch (e) {
      custom.massenger(context, text.SomthingWentWrong.tr);
      log("exception$e");
      return '';
    }
    return '';
  }




/*-----------Patient SignUp Otp Api----------*/
  Future<String> PatientSignupOtp(
    BuildContext context,
    String countryCode,
    String phone,
    String email,
    // VoidCallback callback,
  ) async {
    loadingotp.value = true;
    final Map<String, dynamic> signupPerameter = {
      "user_type":"User",
      "country_code":countryCode,
      "contact":phone,
      "email": email,

    };
    print("SignupPerameter$signupPerameter");

    final response = await http.post(
        Uri.parse(
          "https://cisswork.com/Android/Medica/Apis/twiliosms/send_otp.php",
        ),
        body: signupPerameter);
        // await apiService.postData("https://cisswork.com/Android/Medica/Apis/twiliosms/send_otp.php", signupPerameter);
    try {
      log("response of Patient Signup OTP :-${response.body}");
      loadingotp.value = false;
      var jsonResponse = jsonDecode(response.body);
      otp.value = jsonResponse['otp'].toString();

      // var result = jsonResponse['result'].toString();
      if (response.statusCode == 200) {
        // callback();
        print("my otp ctr${otp.toString()}");
        // custom.massenger(context, otp.toString());

        loadingotp.value = false;
        print(result.toString());
        return jsonResponse['otp'].toString();
      } else {
        custom.massenger(context,  text.SomthingWentWrong.tr);
      }
    } catch (e) {
      custom.massenger(context, text.SomthingWentWrong.tr);
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
      String flag,
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
      "name": name,
      "surname": surname,
      "username": username,
      "email": email,
      "code": countrycode,
      "contact": mobileNo,
      "flag": flag,
      "password": password,
      "health_card": healthCard,
      "age": age,
      "weight": weight,
      "birth_place": birthplace,
      "height": height,
      "tax_code": taxCode,
      "gender": gender,
    };
    print("SignupPerameter$signupPerameter");
    final response = await http.post(
        Uri.parse(
          "https://cisswork.com/Android/Medica/Apis/a.php",
        ),
        body: signupPerameter);
    // final response = await apiService.postData("https://cisswork.com/Android/Medica/Apis/a.php", signupPerameter);
    try {
      log("response of Patient Signup :-${response.body}");
      loading.value = false;
      var jsonResponse = jsonDecode(response.body);
      String result = jsonResponse['result'];
      if (result == "Success") {
        callback();
        loading.value = false;
        custom.massenger(context, result);
      } else {
        custom.massenger(context, result);
      }
    } catch (e) {
      loading.value = false;
      log("exception$e");
    }
  }
}

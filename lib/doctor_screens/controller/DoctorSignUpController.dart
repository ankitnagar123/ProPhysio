import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../../network/ApiService.dart';
import '../../../network/Apis.dart';
import '../../helper/CustomView/CustomView.dart';
import '../../language_translator/LanguageTranslate.dart';
import '../model/BranchModel.dart';
import '../model/DSignUpCategoryModel.dart';
import '../model/DoctorServicesModel.dart';

class DoctorSignUpCtr extends GetxController {
  CustomView custom = CustomView();
  LocalString text = LocalString();

  ApiService apiService = ApiService();

  RxString location = "".obs;

  var loading = false.obs;
  var loadingotp = false.obs;

  var categoryLoading = false.obs;
  var serviceLoading = false.obs;
  var branchLoading = false.obs;
  var otp = ''.obs;
  var msg = ''.obs;

  var result = ''.obs;
  SharedPreferenceProvider sp = SharedPreferenceProvider();

  var category = <AllCategoryModel>[].obs;
  var services = <DoctorServicesModel>[].obs;
  var branchList = <BranchModel>[].obs;

  /*---------Doctor All Category --------*/
  Future<void> doctorCategory(String branchId) async {
    final Map<String, dynamic> parameter = {
      "language": await sp.getStringValue(sp.LANGUAGE)??"",
      "branch_id":branchId,
    };
    log("doctor Category parameter$parameter");
    try {
      categoryLoading.value = true;
      final response = await apiService.postData(MyAPI.DCategorySignUp,parameter);
      log(" Category =============${response.body}");
      if (response.statusCode == 200) {
        categoryLoading.value = false;
        category.value = allCategoryModelFromJson(response.body.toString());
        log(category.toString());
      } else {
        categoryLoading.value = false;
        log("error");
      }
    } catch (e) {
      categoryLoading.value = false;
      log("exception$e");
    }
  }

  Future<void> patientCategory() async {
    final Map<String, dynamic> parameter = {
      "language": await sp.getStringValue(sp.LANGUAGE)??"",
      "branch_id": await sp.getStringValue(sp.PATIENT_BRANCH),
    };
    log("doctor Category parameter$parameter");
    try {
      categoryLoading.value = true;
      final response = await apiService.postData(MyAPI.DCategorySignUp,parameter);
      log(" Category =============${response.body}");
      if (response.statusCode == 200) {
        categoryLoading.value = false;
        category.value = allCategoryModelFromJson(response.body.toString());
        log(category.toString());
      } else {
        categoryLoading.value = false;
        log("error");
      }
    } catch (e) {
      categoryLoading.value = false;
      log("exception$e");
    }
  }
  /*---------Doctor All Services behalf of category --------*/
  Future<void> doctorServices(String category,String branchId) async {
    final Map<String, dynamic> parameter = {
      "category_id":category,
      "branch_id":branchId,
    };
    print("parameter$parameter");
    try {
      serviceLoading.value = true;
      final response = await apiService.postData(MyAPI.DServicesSignUp,parameter);
      log("Doctor Services =============${response.body}");
      if (response.statusCode == 200) {
        serviceLoading.value = false;
        services.value = doctorServicesModelFromJson(response.body.toString());
        log(services.toString());
      } else {
        serviceLoading.value = false;
        log("error");
      }
    } catch (e) {
      serviceLoading.value = false;
      log("exception$e");
    }
  }


  /*---------BRANCH--------*/
  Future<void> branchListApi() async {
    final Map<String, dynamic> parameter = {
      "language": await sp.getStringValue(sp.LANGUAGE)??"",
    };
    print("parameter$parameter");
    try {
      branchLoading.value = true;
      final response = await apiService.postData(MyAPI.DBranchList,parameter);
      print(" branch List Api =============${response.body}");
      if (response.statusCode == 200) {
        branchLoading.value = false;
        branchList.value = branchModelFromJson(response.body.toString());
        log(category.toString());
      } else {
        branchLoading.value = false;
        log("error");
      }
    } catch (e) {
      branchLoading.value = false;
      log("exception$e");
    }
  }



/*-----------Doctor SignUp Otp Verification Api----------*/
  Future<String> doctorSignupOtpVerification(
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
    print("SignupParameter$signupPerameter");
     final response =
        await apiService.postData(MyAPI.DSignUpOtp, signupPerameter);
    try {
      log("response of Doctor Signup OTP :-${response.body}");
      loadingotp.value = false;
      var jsonResponse = jsonDecode(response.body);
      otp.value = jsonResponse['otp'].toString();
      msg.value = jsonResponse['msg'].toString();

      var result = jsonResponse['result'].toString();
      if (response.statusCode == 200) {
        loadingotp.value = false;
        if(msg.value == "true"){
          callback();
          log("my otp ctr${otp.toString()}");
        }else{
          custom.massenger(context, result.toString());
          print(result.toString());
          return jsonResponse['otp'].toString();
        }

      } else {
        custom.massenger(context, text.SomthingWentWrong.tr);
      }
    } catch (e) {
      loadingotp.value = false;
      custom.massenger(context, text.SomthingWentWrong.tr);

      log("exception------$e");
      return '';
    }
    return '';
  }



/*-----------Doctor SignUp Otp Api send_otp_twiliosms----------*/
  Future<String> doctorSignupOtp(
    BuildContext context,
      String countryCode,
      String phone,
      String email,
    // VoidCallback callback,
  ) async {
    loadingotp.value = true;
    final Map<String, dynamic> signupPerameter = {
      "user_type":"Doctor",
      "country_code":countryCode,
      "contact":phone,
      "email": email,
    };
    print("SignupParameter$signupPerameter");
    final response = await http.post(
        Uri.parse(
          MyAPI.send_otp_twiliosms,
        ),
        body: signupPerameter);
   /* final response =
        await apiService.postData(MyAPI.DSignUpOtp, signupPerameter);*/
    print("perameter$signupPerameter");
    try {
      log("response of Doctor Signup OTP :-${response.body}");
      loadingotp.value = false;
      var jsonResponse = jsonDecode(response.body);
      otp.value = jsonResponse['otp'].toString();

      var result = jsonResponse['result'].toString();
      if (response.statusCode == 200) {
        // callback();
        log("my otp ctr${otp.toString()}");
        // custom.massenger(context, otp.toString());
        loadingotp.value = false;
        print(result.toString());
        return jsonResponse['otp'].toString();
      } else {
        custom.massenger(context, text.SomthingWentWrong.tr);
      }
    } catch (e) {
      loadingotp.value = false;
      custom.massenger(context, text.SomthingWentWrong.tr);

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

      String birthDate,
      String birthPlace,
      String gender,
      String age,
      String experience,
      String description,
      String address,
      String lat,
      String lang,

      String branch,
      String category,
      String service,
      // String workingDays,
      String startTime,
      String endTime,
      String imgString,
      String imgBase,
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

      "location": address,
      "latitude": lat,
      "longitude": lang,
      "birth_date":birthDate,
      "birth_place":birthPlace,
      "gender":gender,
      "age":age,
      "experience":experience,
      "description":description,
      "doc_pdf": imgString,
      "docimg_str": imgBase,

      "branch":branch,
      "category": category,
      "service_ids": service,
      // "total_day": workingDays,
      "start_time": startTime,
      "end_time": endTime,
    };
    log("Signup Parameter$signupPerameter");
     final response = await apiService.postData(MyAPI.DSignUp, signupPerameter);
    try {
       log("response of Doctor Signup :-${response.body}");
      loading.value = false;
      var jsonResponse = jsonDecode(response.body);
       String result = jsonResponse['result'];
      if (response.statusCode ==200) {
        callback();
        loading.value = false;
         custom.massenger(context, text.SignUPSuccess.tr);
      } else {
        custom.massenger(context, result);
      }
    } catch (e) {
      log("exception$e");
    }
  }
}

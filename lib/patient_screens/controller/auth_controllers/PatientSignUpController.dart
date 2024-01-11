import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helper/CustomView/CustomView.dart';
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
    log("Signup-Parameter$signupPerameter");
    final response = await http.post(
        Uri.parse(
          MyAPI.send_otp_twiliosms,
        ),
        body: signupPerameter);

    //await apiService.postData("https://cisswork.com/Android/Medica/Apis/twiliosms/send_otp.php", signupPerameter)
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
      String title,
      String name,
      String surname,
      String email,
      String countrycode,
      String mobileNo,
      String flag,
      String password,
      String age,
      String weight,
      String birthplace,
      String height,
      String taxCode,
      String gender,
      String dob,
      String branchId,
      /*---New---*/
      String idType,
      String idNumber,

      String kinName,
      String kinContact,

      String homeTitle1,
      String homeTitle2,
      String homeAddress,
      String homeState,
      String homePostalCode,
      String homeCountry,
      String homePhone,

      String officeTitle1,
      String officeTitle2,
      String employmentStatus,
      String occupation,
      String employer,
      String officeAddress,
      String officeState,
      String officePostalCode,
      String officeCountry,
      String officePhone,

      String medicalTitle1,
      String medicalTitle2,
      String medicalName,
      String medicalPracticeName,
      String medicalAddress,
      String medicalState,
      String medicalPostalCode,
      String medicalCountry,
      String medicalPhone,

      String aboutUs,
      VoidCallback callback) async {
    loading.value = true;
    final Map<String, dynamic> signupParameter = {
      "title": title,
      "name": name,
      "surname": surname,
      "email": email,
      "code": countrycode,
      "contact": mobileNo,
      "flag": flag,
      "password": password,
      "health_card":"",
      "username":"",
      "age": age,
      "weight": weight,
      "birth_place": birthplace,
      "height": height,
      "tax_code": taxCode,
      "gender": gender,
      "dob": dob,
      "branch_id": branchId,
      /*-----NEW--------*/
      "id_type": idType,
      "id_number": idNumber,

      "kin_name": kinName,
      "kin_phone": kinContact,

      "home_line1": homeTitle1,
      "home_line2": homeTitle2,
      "home_city": homeAddress,
      "home_state": homeState,
      "home_postal_code": homePostalCode,
      "home_country": homeCountry,
      "home_phone": homePhone,

      "employment_status": employmentStatus,
      "occupation": occupation,
      "employer": employer,
      "employer_line1": officeTitle1,
      "employer_line2": officeTitle2,
      "employer_city": officeAddress,
      "employer_state": officeState,
      "employer_postal_code": officePostalCode,
      "employer_country": officeCountry,
      "employer_phone": officePhone,

      "doctor_name": medicalName,
      "doctor_practice_name": medicalPracticeName,
      "doctor_line1": medicalTitle1,
      "doctor_line2": medicalTitle2,
      "doctor_city": medicalAddress,
      "doctor_state": medicalState,
      "doctor_postal_code": medicalPostalCode,
      "doctor_country": medicalCountry,
      "doctor_phone": medicalPhone,
      "about_us":aboutUs,
    };
    log("PatientSignup-Parameter----$signupParameter");
    final response = await http.post(
        Uri.parse(
          MyAPI.PSignUp,
        ),
        body: signupParameter);
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

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';

import '../../../Network/ApiService.dart';
import '../../../Network/Apis.dart';
import '../../../helper/sharedpreference/SharedPrefrenc.dart';

class DoctorProfileCtr extends GetxController {
  CustomView custom = CustomView();
  ApiService apiService = ApiService();
  var loading = false.obs;
  var loadingU = false.obs;

  var visible = false.obs;
  var edittext = false.obs;

  var username = "".obs;
  var name = "".obs;
  var surename = "".obs;
  var location = "".obs;
  var Email = "".obs;
  var phone = "".obs;
  var Password = "".obs;
  var address = "".obs;
  var category = "".obs;
  var lat = "".obs;
  var lang = "".obs;
  var degree = "".obs;
  var bio = "".obs;
  var image = "".obs;
  var gender = "".obs;

  /*new*/
  var dateOfBirth = "".obs;
  var placeOfBirth = "".obs;
  var universityAttended = "".obs;
  var dateOfEnrollment = "".obs;
  var registerOfBelonging = "".obs;
  var dateOfQualification = "".obs;
  var dateOfGraduation = "".obs;
  var resultVar = RxnInt(0);

  SharedPreferenceProvider sp = SharedPreferenceProvider();

/*----------Fetch Doctor Profile Data API-----------*/
  void doctorProfile(BuildContext context) async {
    loading.value = true;
    resultVar.value = 0;
    final Map<String, dynamic> ProfilePerameter = {
      "id": await sp.getStringValue(sp.DOCTOR_ID_KEY),
    };
    print("Doctor Profile Parameter$ProfilePerameter");

    final response =
        await apiService.postData(MyAPI.DFetchProfile, ProfilePerameter);
    try {
      log("response of Doctor Profile :-${response.body}");
      log("my id $ProfilePerameter");

      loading.value = false;
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        String result = jsonResponse['result'];
        String biography = jsonResponse['biography'];
        var bios = biography.toString();
        bio.value = bios;
        print("bio======>$bios");
        print("my doctor profile====${result.toString()}");
        name.value = jsonResponse["name"];
        surename.value = jsonResponse["surname"];
        gender.value = jsonResponse["gender"];
        // bio.value = jsonResponse["biography"];
        username.value = jsonResponse["username"];
        location.value = jsonResponse["location"];
        Email.value = jsonResponse["email"];
        phone.value = jsonResponse["contact"];
        Password.value = jsonResponse["password"];
        image.value = jsonResponse["Doctor_profile"];
        category.value = jsonResponse["category"];
        lat.value = jsonResponse["latitude"];
        lang.value = jsonResponse["longitude"];
        degree.value = jsonResponse["Doctor_document"];
        /*-new-*/
      /*  dateOfBirth.value = jsonResponse["birth_date"];
        placeOfBirth.value = jsonResponse["birth_place"];
        universityAttended.value = jsonResponse["university_attended"];
        dateOfEnrollment.value = jsonResponse["enrollment_date"];
        registerOfBelonging.value = jsonResponse["register_of_belonging"];
        dateOfGraduation.value = jsonResponse["graduation_date"];
        dateOfQualification.value = jsonResponse["qualification_date"];*/
        resultVar.value = 1;

        // Massenger(context, 'My Profile');
      } else {
        resultVar.value = 2;

        loading.value = false;
        custom.massenger(context, "Invalid");
      }
    } catch (e) {
      resultVar.value = 2;
      loading.value = false;
      log("exception$e");
    }
  }

/*----------Update Doctor Profile API-----------*/
  void doctorProfileUpdate(
    BuildContext context,
    String name,
    String surname,
    String username,
    String bio,
    // String location,
    // String docImg,
    // String docBase,
    String code,
    String email,
    String phone,
    // String password,
    String image,
    String baseImage,
    String gender,
    String dateOfBirth,
    String placeOfBirth,
    String universityAttended,
    String dateOfEnrollment,
    String registerOfBelonging,
    String dateOfQualification,
    String dateOfGraduation,
  ) async {
    loadingU.value = true;
    final Map<String, dynamic> profileUpdatePerameter = {
      "id": await sp.getStringValue(sp.DOCTOR_ID_KEY),
      "name": name,
      "surname": surname,
      "username": username,
      "biography": bio,
      "email": email,
      // "category":category,
      // "location":location,
      "code": code,
      "contact": phone,
      // "password": password,
      // "doc_pdf": docImg,
      // "docimg_str":docBase,
      "image": image,
      "img_str": baseImage,
      "gender": gender,
      "birth_date": dateOfBirth,
      "birth_place": placeOfBirth,
      "university_attended": universityAttended,
      "enrollment_date": dateOfEnrollment,
      "register_of_belonging": registerOfBelonging,
      "graduation_date": dateOfGraduation,
      "qualification_date": dateOfQualification,
    };
    print("Patient Profile Update Parameter$profileUpdatePerameter");

    final response =
        await apiService.postData(MyAPI.DUpdateProfile, profileUpdatePerameter);
    try {
      log("response of Doctor Profile Update :-${response.body}");
      loadingU.value = false;
      var jsonResponse = jsonDecode(response.body);
      String result = jsonResponse['result'];
      if (result == 'Success') {
        doctorProfile(context);
        custom.massenger(context, "Profile Update Successfully");
      } else {
        loadingU.value = false;
        custom.massenger(context, "Invalid Inputs");
      }
    } catch (e) {
      loadingU.value = false;
      log("exception$e");
    }
  }
}

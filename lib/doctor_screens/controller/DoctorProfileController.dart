import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Network/ApiService.dart';
import '../../../Network/Apis.dart';
import '../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../helper/CustomView/CustomView.dart';
import '../../language_translator/LanguageTranslate.dart';
import '../model/DoctorProfileModel.dart';

class DoctorProfileCtr extends GetxController {
  CustomView custom = CustomView();
  LocalString text = LocalString();

  ApiService apiService = ApiService();
  var profileDetails = Rxn<DoctorProfileModel>();

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
  var code = "".obs;
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

  var flag = "".obs;

  var age = "".obs;
  var experience = "".obs;
  var description = "".obs;
  var firstService = "".obs;
  var branchId = "".obs;
  var slectedCategory = "".obs;
  var sTime = "".obs;
  var eTime = "".obs;

  var resultVar = RxnInt(0);

  SharedPreferenceProvider sp = SharedPreferenceProvider();

/*----------Fetch Doctor Profile Data API-----------*/
  Future doctorProfile(BuildContext context) async {
    loading.value = true;
    resultVar.value = 0;
    final Map<String, dynamic> ProfilePerameter = {
      "language": await sp.getStringValue(sp.LANGUAGE) ?? "",
      "doctor_id": await sp.getStringValue(sp.DOCTOR_ID_KEY),
    };
    print("Doctor Profile Parameter$ProfilePerameter");

    final response =
        await apiService.postData(MyAPI.DFetchProfile, ProfilePerameter);
    try {
      log("response of Doctor Profile :-${response.body}");
      log("my id $ProfilePerameter");

      loading.value = false;
      if (response.statusCode == 200) {
        profileDetails.value = doctorProfileModelFromJson(response.body);
        log("profileDetails-------${profileDetails.value}");
        var jsonResponse = jsonDecode(response.body);
        String result = jsonResponse['result'].toString();
        String biography = jsonResponse['biography'].toString();
        var bios = biography.toString();
        bio.value = bios;
        print("bio======>$bios");
        print("my doctor profile====${result.toString()}");
        name.value = jsonResponse["name"].toString();
        surename.value = jsonResponse["surname"].toString();
        gender.value = jsonResponse["gender"].toString();
        bio.value = jsonResponse["description"];
        username.value = jsonResponse["username"].toString();
        location.value = jsonResponse["location"].toString();
        Email.value = jsonResponse["email"].toString();
        phone.value = jsonResponse["contact"].toString();
        code.value = jsonResponse["code"].toString();
        flag.value = jsonResponse["flag"].toString();
        Password.value = jsonResponse["password"].toString();
        image.value = jsonResponse["Doctor_profile"].toString();
        category.value = jsonResponse["category"].toString();
        lat.value = jsonResponse["latitude"].toString();
        lang.value = jsonResponse["longitude"].toString();
        degree.value = jsonResponse["Doctor_document"].toString();
        dateOfBirth.value = jsonResponse["birth_date"].toString();
        placeOfBirth.value = jsonResponse["birth_place"].toString();
        /*-new-*/
        age.value = jsonResponse["age"];
        experience.value = jsonResponse["experience"];
        description.value = jsonResponse["description"];
        branchId.value = jsonResponse["branch_id"];
        slectedCategory.value = jsonResponse["category_id"];
        sTime.value = jsonResponse["start_time"];
        eTime.value = jsonResponse["end_time"];
        resultVar.value = 1;
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
    String branch,
    String name,
    String surname,
    String username,
    String email,
    String category,
    String serviceIds,
    String flag,
    String code,
    String contact,
    String password,
    String gender,
    String location,
    String latitude,
    String longitude,
    String birthDate,
    String birthPlace,
    String age,
    String description,
    String experience,
    String startTime,

    String endTime,
    String docPdf,
    String docimgStr,
    String totalDay,
    String image,
    String imgStr,

    VoidCallback callback,
  ) async {
    loadingU.value = true;
    final Map<String, dynamic> profileUpdatePerameter = {
      "doctor_id": await sp.getStringValue(sp.DOCTOR_ID_KEY),
      "branch":branch,
      "name":name,
      "surname":surname,
      "username":username,
      "email":email,
      "category":category,
      "service_ids":serviceIds,
      "flag":flag,
      "code":code,
      "contact":contact,
      "password":password,
      "gender":gender,
      "location":location,
      "latitude":latitude,
      "longitude":longitude,
      "birth_date":birthDate,
      "birth_place":birthPlace,
      "age":age,
      "description":description,
      "experience":experience,
      "start_time":startTime,
      "end_time":endTime,
      "doc_pdf":docPdf,
      "docimg_str":docimgStr,
      "total_day":totalDay,
      "image":image,
      "img_str":imgStr,

    };
    print(" Doctor Profile Update Parameter$profileUpdatePerameter");

    final response = await apiService.postData(MyAPI.DUpdateProfile, profileUpdatePerameter);
    try {
      log("response of Doctor Profile Update :-${response.body}");
      loadingU.value = false;
      var jsonResponse = jsonDecode(response.body);
      String result = jsonResponse['result'];
      if (result == 'Success') {
        callback();
        doctorProfile(context);
        // custom.massenger(context, "Profile Update Successfully");
      } else {
        loadingU.value = false;
        custom.massenger(context, text.Invalid.tr);
      }
    } catch (e) {
      loadingU.value = false;
      log("exception$e");
    }
  }
}

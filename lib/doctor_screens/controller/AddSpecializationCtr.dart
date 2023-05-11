import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:medica/helper/CustomView/CustomView.dart';

import '../../../Network/ApiService.dart';
import 'package:get/get.dart';

import '../../../Network/Apis.dart';
import '../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../model/DoctorSelectedCategoryModel.dart';
import '../model/DrSelectSubCatModel.dart';

class AddSpecializationCtr extends GetxController {
  ApiService apiService = ApiService();
  var loading = false.obs;
  var categoryloding = false.obs;
  var categorySubLoading = false.obs;


  SharedPreferenceProvider sp = SharedPreferenceProvider();
  CustomView custom = CustomView();

  var selectedCategory = <SelectedCategoryModel>[].obs;
  var selectedSubCategory = <SelectedSubCategoryModel>[].obs;


  /*-------------Doctor fetch selected category --------------*/
  Future<void> doctorSelectedCategory() async {
    final Map<String, dynamic> perameter = {
      "doctor_id": await sp.getStringValue(sp.DOCTOR_ID_KEY),
    };
    try {
      categoryloding.value = true;
      final response = await apiService.postData(MyAPI.dSelectedCategory,perameter);
      print(" selected Category=============${response.body}");
      if (response.statusCode == 200) {
        categoryloding.value = false;
        selectedCategory.value = selectedCategoryModelFromJson(response.body.toString());
      } else {
        categoryloding.value = false;
        print("error");
      }
    } catch (e) {
      categoryloding.value = false;
      print("exception$e");
    }
  }


  /*-------------Doctor fetch selected sub category --------------*/
  Future<void> doctorSelectedSubCategory(String categoryId) async {
    final Map<String, dynamic> perameter = {
      "doctor_id": await sp.getStringValue(sp.DOCTOR_ID_KEY),
      "cat_id":categoryId,
    };
    try {
      categorySubLoading.value = true;
      final response = await apiService.postData(MyAPI.dSelectedSubCategory,perameter);
      print("Selected sub-Category=============${response.body}");
      if (response.statusCode == 200) {
        categorySubLoading.value = false;
        selectedSubCategory.value = selectedSubCategoryModelFromJson(response.body.toString());
      } else {
        categorySubLoading.value = false;
        print("error");
      }
    } catch (e) {
      categorySubLoading.value = false;
      print("exception$e");
    }
  }


  /*------------Doctor Add Specialization with Fee and Description----------------*/
  Future addSpecializationFee(BuildContext
  context,String
  category,String subCatId,
      String discrip, String visitName,
      String fee,VoidCallback callback,
      ) async {
    loading.value = true;
    final Map<String, dynamic> perameter = {
      "doctor_id": await sp.getStringValue(sp.DOCTOR_ID_KEY),
      "cat_id":category,
      "subcat_id":subCatId,
      "description":discrip,
      "name": visitName,
      "price": fee,
    };
    print("addSpecialization and Fee  Parameter$perameter");
    final response = await apiService.postData(MyAPI.DAddSpecializationFee, perameter);
    try {
      log("response of Doctor add Specialization Fee Api :-${response.body}");
      var jsonResponse = jsonDecode(response.body);
      var result = jsonResponse['result'].toString();
      loading.value = false;
      if (result == "success") {
        callback();
        loading.value = false;
        print("my Doctor add Specialization Fee Api  $result");
        custom.massenger(context, result.toString());
        print(result.toString());
      } else {
        custom.massenger(context, result.toString());
      }
    } catch (e) {
      loading.value = false;
      log("exception$e");
    }
  }


}
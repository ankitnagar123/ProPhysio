import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import '../../helper/CustomView/CustomView.dart';

import '../../../Network/ApiService.dart';
import 'package:get/get.dart';

import '../../../Network/Apis.dart';
import '../../../helper/sharedpreference/SharedPrefrenc.dart';

class DoctorSupportCtr extends GetxController {
  ApiService apiService = ApiService();
  var loading = false.obs;

  SharedPreferenceProvider sp = SharedPreferenceProvider();
  CustomView custom = CustomView();


/*-------------Doctor Support Api--------------*/
  Future supportApi(BuildContext context, String sub,
      String email, String msg,String? branchId , VoidCallback callback) async {
    loading.value = true;
    final Map<String, dynamic> psetpass = {
      "id": await sp.getStringValue(sp.DOCTOR_ID_KEY),
      "subject": sub,
      "email": email,
      "message": msg,
      "branch_id": branchId.toString(),

    };
    print("support parameter Parameter$psetpass");
    final response = await apiService.postData(MyAPI.DSupport, psetpass);
    try {
      log("response of Doctor Support :-${response.body}");
      var jsonResponse = jsonDecode(response.body);
      var result = jsonResponse['result'].toString();
      loading.value = false;
      if (result == "success") {
        loading.value = false;
        print("my Doctor support $result");
        custom.massenger(context, result.toString());
        print(result.toString());
        callback();
      } else {
        custom.massenger(context, result.toString());
      }
    } catch (e) {
      loading.value = false;
      log("exception$e");
    }
  }
}
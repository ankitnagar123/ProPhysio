import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';


import '../../../Network/ApiService.dart';
import 'package:get/get.dart';

import '../../../Network/Apis.dart';
import '../../../helper/CustomView/CustomView.dart';
import '../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../../language_translator/LanguageTranslate.dart';

class PatientChangePassCtr extends GetxController {
  ApiService apiService = ApiService();
  LocalString text = LocalString();
  var loadingset = false.obs;
  var loadingd = false.obs;

  SharedPreferenceProvider sp= SharedPreferenceProvider();
  CustomView custom = CustomView();
/*-------------Patient Change  Password--------------*/
  Future ChangePasswordApi(BuildContext context, String oldpass,
      String newpass, String confirmpass, VoidCallback callback) async {
    loadingset.value = true;
    final Map<String, dynamic> psetpass = {
      "id": await sp.getStringValue(sp.PATIENT_ID_KEY),
      "old_pass": oldpass,
      "new_pass": newpass,
      "confirm_pass": confirmpass
    };
    print("Change new password Parameter$psetpass");
    final response = await apiService.postData(MyAPI.PChangePassword, psetpass);
    try {
      log("response of Patient new Change password :-${response.body}");
      var jsonResponse = jsonDecode(response.body);
      var result = jsonResponse['result'].toString();
      loadingset.value = false;
      if (result == "Changed Successfull") {
        loadingset.value = false;
        print("my patient set pass$result");
        custom.massenger(context, text.Changed_Pass_Successfully.tr);
        print(result.toString());
        callback();
      } else {
        custom.massenger(context, text.passwordNotMatch.tr);
      }
    } catch (e) {
      loadingset.value = false;
      log("exception$e");
    }
  }



  /*------------ Patient Delete Account API--------------------*/

  Future deleteAccount(BuildContext context,
      String pass, VoidCallback callback) async {
    loadingd.value = true;
    final Map<String, dynamic> psetpass = {
      "user_id": await sp.getStringValue(sp.PATIENT_ID_KEY),
      "password": pass,
    };
    print("response of Patient Delete Accoun$psetpass");
    final response = await apiService.postData(MyAPI.PDeleteAccount, psetpass);
    try {
      log("response of Patient Delete Account :-${response.body}");
      var jsonResponse = jsonDecode(response.body);
      var result = jsonResponse['result'].toString();
      loadingd.value = false;
      if (result  =="Account delete Successfully") {
        callback();
        loadingd.value = false;
        print("my patient $result");
        custom.massenger(context,text.DeleteaccountSuccess.tr);
        print(result.toString());
      } else {
        log("message$result");
        custom.massenger(context, text.Invalid.tr);
      }
    } catch (e) {
      loadingd.value = false;
      log("exception$e");
    }
  }
}
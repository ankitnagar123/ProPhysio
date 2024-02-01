import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../../Network/ApiService.dart';
import 'package:get/get.dart';

import '../../../Network/Apis.dart';
import '../../../helper/CustomView/CustomView.dart';
import '../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../../language_translator/LanguageTranslate.dart';
import '../../model/SupportListModel.dart';

class PatientSupportCtr extends GetxController {
  ApiService apiService = ApiService();
  LocalString text =  LocalString();
  var loading = false.obs;
  var supportLoading = false.obs;

  SharedPreferenceProvider sp = SharedPreferenceProvider();
  CustomView custom = CustomView();
  var supportLists = <SupportListModel>[].obs;


/*-------------supportApi --------------*/
  Future supportApi(BuildContext context, String sub,
      String email, String msg,String? branchId, VoidCallback callback) async {
    loading.value = true;
    final Map<String, dynamic> psetpass = {
      "id": await sp.getStringValue(sp.PATIENT_ID_KEY),
      "subject": sub,
      "email": email,
      "message": msg,
      "branch_id": branchId.toString(),
    };
    log("support parameter Parameter$psetpass");
    final response = await apiService.postData(MyAPI.pSupport, psetpass);
    try {
      log("response of Patient Support :-${response.body}");
      var jsonResponse = jsonDecode(response.body);
      var result = jsonResponse['result'].toString();
      loading.value = false;
      if (result == "success") {
        loading.value = false;
        log("my patient support $result");
        custom.massenger(context,text.success.tr );
        print(result.toString());
        callback();
      } else {
        custom.massenger(context, text.SomthingWentWrong.tr);
      }
    } catch (e) {
      loading.value = false;
      log("exception$e");
    }
  }



  /*-------------task Manage List view --------------*/
  Future<void> supportList(BuildContext context,
      String type,) async {
    Map<String,dynamic> parameter = {
      "id":await sp.getStringValue(sp.PATIENT_ID_KEY),
      "type":type,
    };
    log("parameter$parameter");
    try {
      supportLoading.value = true;
      final response = await apiService.postData(MyAPI.pSupportList,parameter);
      log("p Support List List=============${response.body}");
      if (response.statusCode == 200) {
        supportLoading.value = false;
        supportLists.value = supportListModelFromJson(response.body);
      } else {
        supportLoading.value = false;
        log("error");
      }
    }catch (e) {
      supportLoading.value = false;
      log("exception$e");
    }
  }
}
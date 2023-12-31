import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Network/ApiService.dart';
import '../../Network/Apis.dart';
import '../../helper/CustomView/CustomView.dart';
import '../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../language_translator/LanguageTranslate.dart';
import '../model/CenterRequestListModel.dart';

class CenterRequest extends GetxController {
  var loading = false.obs;

  var loadingAccept = false.obs;
  var loadingReject = false.obs;

  SharedPreferenceProvider sp = SharedPreferenceProvider();
  CustomView custom = CustomView();
  LocalString text = LocalString();


  var centerRequestList = <CenterRequestListModel>[].obs;
  ApiService apiService = ApiService();

  Future<void> CenterRequestListApi(BuildContext context) async {
    loading.value = true;
    final Map<String, dynamic> data = {
      "language": await sp.getStringValue(sp.LANGUAGE)??"",
      "doctor_id": await sp.getStringValue(sp.DOCTOR_ID_KEY),
    };
    try {
      final response = await apiService.postData(MyAPI.dCenterRequest, data);
      print("Center Request LIst${response.body}");
      if (response.statusCode == 200) {
        loading.value = false;
        centerRequestList.value = centerRequestListModelFromJson(response.body);
        log(centerRequestList.toString());
      } else {
        loading.value = false;
        custom.massenger(context, text.SomthingWentWrong.tr);
      }
    } catch (e) {
      loading.value = false;

      return log("exception$e");
    }
  }

  /*-------------Doctor Accept/Reject Center Request--------------*/
  Future centerRequestAcceptReject(BuildContext context, String wardId,
      String type, VoidCallback callback) async {
    if (type == "Confirm") {
      loadingAccept.value = true;
    } else {
      loadingReject.value = true;
    }
    final Map<String, dynamic> psetpass = {
      "doctor_id": await sp.getStringValue(sp.DOCTOR_ID_KEY),
      "ward_id": wardId,
      "status": type,
    };
    log(" CenterRequest Accept/Reject Parameter $psetpass");
    final response =
        await apiService.postData(MyAPI.dCenterRequestAcceptReject, psetpass);
    try {
      log("response of CenterRequest Accept/Reject :-${response.body}");
      var jsonResponse = jsonDecode(response.body);
      var result = jsonResponse['result'].toString();
      if (result == "Success") {
        CenterRequestListApi(context);
        callback();
        loadingAccept.value = false;
        loadingReject.value = false;
        log("response of CenterRequest Accept/Reject $result");
        custom.massenger(context,text.Success.tr);
        log(result.toString());
      } else {
        loadingAccept.value = false;
        loadingReject.value = false;
        custom.massenger(context,text.Success.tr);
      }
    } catch (e) {
      loadingAccept.value = false;
      loadingReject.value = false;
      log("exception$e");
    }
  }
}

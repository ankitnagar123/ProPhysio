import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medica/Network/Apis.dart';

import '../../Network/ApiService.dart';
import '../../helper/CustomView/CustomView.dart';
import '../../helper/sharedpreference/SharedPrefrenc.dart';
import '../model/CenterRequestListModel.dart';

class CenterRequest extends GetxController {
  var loading = false.obs;

  var loadingAccept = false.obs;
  var loadingReject = false.obs;

  SharedPreferenceProvider sp = SharedPreferenceProvider();
  CustomView custom = CustomView();
  var centerRequestList = <CenterRequestListModel>[].obs;
  ApiService apiService = ApiService();

  Future<void> CenterRequestListApi(BuildContext context) async {
    loading.value = true;
    final Map<String, dynamic> data = {
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
        custom.massenger(context, "Something went wrong");
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
        callback();
        loadingAccept.value = false;
        loadingReject.value = false;

        log("response of CenterRequest Accept/Reject $result");
        custom.massenger(context, result.toString());
        log(result.toString());
        callback();
      } else {
        loadingAccept.value = false;
        loadingReject.value = false;
        custom.massenger(context, result.toString());
      }
    } catch (e) {
      loadingAccept.value = false;
      loadingReject.value = false;
      log("exception$e");
    }
  }
}
